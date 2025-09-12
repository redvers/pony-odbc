config ?= debug
static ?= false
linker ?=

PACKAGE := pony-odbc
GET_DEPENDENCIES_WITH := corral fetch
CLEAN_DEPENDENCIES_WITH := corral clean
PONYC ?= ponyc
COMPILE_WITH := corral run -- $(PONYC)

BUILD_DIR ?= build/$(config)
SRC_DIR ?= $(PACKAGE)
EXAMPLES_DIR := examples
STRESS_TESTS_DIR := stress-tests
tests_binary := $(BUILD_DIR)/pony-odbc
docs_dir := build/$(PACKAGE)-docs

ifdef config
	ifeq (,$(filter $(config),debug release))
		$(error Unknown configuration "$(config)")
	endif
endif

ifeq ($(config),release)
	PONYC = $(COMPILE_WITH)
else
	PONYC = $(COMPILE_WITH) --debug
endif

ifdef static
	ifeq (,$(filter $(static),true false))
		$(error "static must be true or false)
	endif
endif

ifeq ($(static),true)
	LINKER += --static
endif

ifneq ($(linker),)
	LINKER += --link-ldcmd=$(linker)
endif

ifeq (,$(filter $(MAKECMDGOALS),clean docs realclean TAGS))
  ifeq ($(ssl), 3.0.x)
          SSL = -Dopenssl_3.0.x
  else ifeq ($(ssl), 1.1.x)
          SSL = -Dopenssl_1.1.x
  else ifeq ($(ssl), 0.9.0)
          SSL = -Dopenssl_0.9.0
  else
    SSL = -Dopenssl_3.0.x
  endif
endif

PONYC := $(PONYC) $(SSL) $(LINKER)

SOURCE_FILES := $(shell find $(SRC_DIR) -name *.pony)
EXAMPLES := $(notdir $(shell find $(EXAMPLES_DIR)/* -type d))
EXAMPLES_SOURCE_FILES := $(shell find $(EXAMPLES_DIR) -name *.pony)
EXAMPLES_BINARIES := $(addprefix $(BUILD_DIR)/,$(EXAMPLES))
STRESS_TESTS := $(notdir $(shell find $(STRESS_TESTS_DIR)/* -type d))
STRESS_TESTS_SOURCE_FILES := $(shell find $(STRESS_TESTS_DIR) -name *.pony)
STRESS_TESTS_BINARIES := $(addprefix $(BUILD_DIR)/,$(STRESS_TESTS))

ci: unit-tests examples stress-tests

test: unit-tests

unit-tests: $(tests_binary)
	$^

$(tests_binary): $(GEN_FILES) $(SOURCE_FILES) | $(BUILD_DIR) dependencies
	$(PONYC) -o $(BUILD_DIR) $(SRC_DIR)/tests -b pony-odbc

examples: $(EXAMPLES_BINARIES)

$(EXAMPLES_BINARIES): $(BUILD_DIR)/%: $(SOURCE_FILES) $(EXAMPLES_SOURCE_FILES) | $(BUILD_DIR) dependencies
	$(PONYC) -o $(BUILD_DIR) $(EXAMPLES_DIR)/$*

stress-tests: $(STRESS_TESTS_BINARIES)

$(STRESS_TESTS_BINARIES): $(BUILD_DIR)/%: $(SOURCE_FILES) $(STRESS_TESTS_SOURCE_FILES) | $(BUILD_DIR) dependencies
	$(PONYC) -o $(BUILD_DIR) $(STRESS_TESTS_DIR)/$*

clean:
	$(CLEAN_DEPENDENCIES_WITH)
	rm -rf $(BUILD_DIR)

realclean:
	$(CLEAN_DEPENDENCIES_WITH)
	rm -rf build

$(docs_dir): $(SOURCE_FILES) dependencies
	rm -rf $(docs_dir)
	$(PONYC) --docs-public --pass=docs --output build $(SRC_DIR)

docs: $(docs_dir)

dependencies: corral.json
	$(GET_DEPENDENCIES_WITH)

TAGS:
	ctags --recurse=yes $(SRC_DIR)

all: ci

$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)

start-pg-container:
	@docker run --name pg -e POSTGRES_DB=postgres -e POSTGRES_USER=postgres -e POSTGRES_PASSWORD=postgres -e POSTGRES_HOST_AUTH_METHOD=md5 -e POSTGRES_INITDB_ARGS="--auth-host=md5" -p 5432:5432 -d postgres:14.5

stop-pg-container:
	@docker stop pg
	@docker rm pg

start-mariadb-container:
	@docker run --name mariadb -e MYSQL_USER=pony -e MYSQL_PASSWORD=pony -e MYSQL_DATABASE=pony -e MYSQL_ROOT_PASSWORD=pony -p 3306:3306 -d mariadb

stop-mariadb-container:
	@docker stop mariadb
	@docker rm mariadb


.PHONY: all clean realclean TAGS test
