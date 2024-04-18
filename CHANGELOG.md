# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

> `## [Unreleased]`
> `### Added | Changed | Removed | Fixed
> `## [Maj.Min.Tweak] - YYYY-MM-DD`

## [Unreleased]

### Changed
- Expanded scrubbing bubble gitmergescrub include `git remote prune origin`

[0.1.1] - 2024-04-18

### Changed
- Updated README with better instructions
- Scrubbing bubble loop fix for hack team cleaning `gitmergescrub`
- Improved formatting for t3x
- Enabling both .sh and .t3x for scripts in t3x but only showing .t3x
- First draft `t3x update` that uses simple sanity checking before `git pull`

[0.1.0] - 2024-04-15

Initial public release 

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
