# Change Log

All notable changes to this project will be documented in this file. This project adheres to [Semantic Versioning](http://semver.org/) and [Keep a CHANGELOG](http://keepachangelog.com/).

## [unreleased] - unreleased

### Fixed


### Added


### Changed


## [0.2.0] - 2025-09-21

### Added

- Update documentation. ([PR #31](https://github.com/redvers/pony-odbc/pull/31))
- Applying more consistency across the API ([PR #30](https://github.com/redvers/pony-odbc/pull/30))

  * ODBCDbc and ODBCStmt creation are now created from their "parent"
    objects.  ie - ODBCDbc is created via ODBCEnv.dbc()?, and ODBCStmt
    is created via ODBCDbc.stmt()?.

    The reason we do this is that failing to create a valid ODBCDbc or
    ODBCStmt generates an error on the parent object, and not the new
    object.

    This allows us to use partial construtors.

  * Added a "strict" field. In "strict mode", SQLSuccessWithInfo will
    generate errors.  This is the default.

  * Started migrating to Boxed types in the API.  More to come.

  * Updated examples to new API.

  * Updated tests to new API.

  * Added sqlstates() to extract the SQLSTATEs from objects.

  * Added disconnect() method to ODBCDbc

  * We appear to have found a bug in the mariadb driver. So commented out.

## [0.1.0] - 2025-09-15

### Added

- Enabled release notification for Zulip & LWIP ([PR #28](https://github.com/redvers/pony-odbc/pull/28))

