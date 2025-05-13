# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

> `## [Unreleased]`
> `### Added | Changed | Removed | Fixed
> `## [Maj.Min.Tweak] - YYYY-MM-DD`

## [0.3.1] - 2025-05-13

### Changed

  - The “t3x enabled” message at the CLI’s top has changed to “t3x v[version number] enabled”.

## [0.3.0] - 2025-04-30
- First stable release

### Changed

  - Updated README
  - Refactored package lists
  - Fixed `dectalk`

### Added

  - Cleanup script for node-red `cleanup.sh`
  - Cleanup script for bash history `prep-clean.sh`
  - Separate package lists for Bullseye, Bookworm
  - `packages.t3x`

## [0.2.0] - 2025-02-10

### Changed

- Updated README with better instructions
- Scrubbing bubble loop fix for hack team cleaning `gitmergescrub`
- Improved formatting for t3x
- Enabling both .sh and .t3x for scripts in t3x but only showing .t3x
- First draft `t3x update` that uses simple sanity checking before `git pull`
- Piles of other updates not cleanly captured in the CHANGELOG

## [0.1.0] - 2024-04-15
- Initial public release 

### Added
- CHANGELOG.md (this file)
- primary interface command: `bin/t3x`
- structure for basic libraries in `lib`
- command scripts in `scripts`
- LICENSE file with UAF copyright under MIT
- README.md structure
- `sshdisable.sh` script
- `poem.sh` for fun
- `starship` installer added (with nerdfont)
- `dectalk` installer added
- `mu` installer added
- `sanity` script
- `t3x pi` tool
