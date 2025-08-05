# Changelog

All notable changes to this project will be documented in this file.

## [1.6] - 2025-08-05

### Added
- Added the `begincode`, `endcode` and `amp` templates.
- Now automatically detects if the system uses the `python` or `python3` command.
- This Changelog file.

### Changed
- Math equations now use texmath to turn them into MathML rather than clumsy SVGs using a clumsy toolchain.
- Readme improvements - now clearly states program dependencies.
- Improved logo.
- Minor stylistic documentation improvements.
- Replacing `@produces` with `@precedes` when specifying template ordering, as that is a clearer directive.
- Minor template script cleanup.



## [1.5.1] - 2025-03-16

### Changed
- Fixed bash warnings.



## [1.5] - 2023-04-23

### Added
- Added the `include-framed-html` template and extended the `imgframe` template.

### Changed
- Tweaking the toolchain of math to SVG creation.
- Updating doumentation.
- Provided additional argument to pre-script-runner.
- Bug fixes.
- Moved common functions to utils file.
- Improved documentation of util functions.
- More robust handling of the `imgframe` template.



## [1.4] - 2022-11-04

### Added
- Added option to provide a custom template directory.
- Added support for directory structures.
- Added the `article` template.

### Changed
- For math equations: Explicitly setting path of Ghostscript.

### Removed
- Removing the `github` template as it was user specific and provided rather limited value.



## [1.3] - 2022-08-16

### Added
- Added support for having templates within templates.
- Adding a .gitignore file.

### Changed
- Some documentation updates.
- Improved the `imglink` template.
- Changed file permissions of a script.



## [1.2] - 2022-06-30

### Added
- Added documentation.
- Added Readme.
- Added tests.
- Added resource argument to compile script.
- Added the `pipe` template.

### Changed
- Improvements of the `ìmglink` and `ìnclude-html` templates.
- Handling escaped amphersands properly.
- Removing header and footer files after they have been applied.



## [1.1] - 2022-06-19

### Added
- Added the templates `leftcurlybracket` and `rightcurlybracket`.
- For math to SVG conversion: adding workaround for dvisvgm version below 2.13.4.



## [1.0] - 2022-04-07

### Added
- First version of program. Can parse templates in logical order, has several util functions and supports converting math equation to SVGs. The following templates are built-in: `beginmath`, `comment`, `endmath`, `github`, `img`, `imgframe`, `imglink`, `imglinklist`, `imglinklist_after`, `include-css`, `include-html`, `include-script`, `linebreak`, `math`, `mathref`, `ref`, `thumbnail`, `thumbnails`, `thumbnails_after`.
