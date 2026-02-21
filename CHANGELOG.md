# Change Log

All notable changes to this project will be documented in this file. This project adheres to [Semantic Versioning](http://semver.org/) and [Keep a CHANGELOG](http://keepachangelog.com/).

## [unreleased] - unreleased

### Fixed

- Fixed ODBCStmt reuse bug ([PR #45](https://github.com/redvers/pony-odbc/pull/45))
- Fix buffer handling bugs and improve robustness ([PR #47](https://github.com/redvers/pony-odbc/pull/47))
- Fixed bugfixes centered around memory management ([PR #48](https://github.com/redvers/pony-odbc/pull/48))

### Added

- Add ODBCStmt.tables()? function ([PR #44](https://github.com/redvers/pony-odbc/pull/44))
- Added Property tests ([PR #61](https://github.com/redvers/pony-odbc/pull/61))

### Changed


## [0.3.1] - 2025-10-18

### Fixed

- Changes Default value for new SQLType to SQLNull ([PR #43](https://github.com/redvers/pony-odbc/pull/43))

## [0.3.0] - 2025-09-30

### Fixed

- Misc bugfixes for differences in mariadb behaviour across versions: ([PR #32](https://github.com/redvers/pony-odbc/pull/32))
- Defaults simple API to Bool ? everywhere ([PR #40](https://github.com/redvers/pony-odbc/pull/40))

### Added

- Adds native FFI interface ([PR #33](https://github.com/redvers/pony-odbc/pull/33))
- Adds support for SQLDirectExec, SQLColumns, SQLGetData, SQLFetch, SQLFreeStmt ([PR #38](https://github.com/redvers/pony-odbc/pull/38))
- Add SQL NULL support for SQL Datatypes ([PR #39](https://github.com/redvers/pony-odbc/pull/39))

## [0.2.0] - 2025-09-21

### Added

- Update documentation. ([PR #31](https://github.com/redvers/pony-odbc/pull/31))
- Applying more consistency across the API ([PR #30](https://github.com/redvers/pony-odbc/pull/30))

## [0.1.0] - 2025-09-15

### Added

- Enabled release notification for Zulip & LWIP ([PR #28](https://github.com/redvers/pony-odbc/pull/28))

