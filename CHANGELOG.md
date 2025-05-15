# Changelog

All notable changes to this project will be documented here.

## [0.1.2] - 2025-05-15

### ✨ Added

- `FormState<T>`: A dedicated sealed class for handling form submission states (`FormInitial`, `FormSubmitting`, `FormSuccess`, `FormFailure`)
- `FormState.when`, `maybeWhen`, `whenOrNull` APIs for pattern matching
- FormState test coverage similar to `AsyncState`
- Documentation updated with full usage examples for `FormState`
- New widget example added: name & age form submission using `FormState`

## 0.1.1

- Added tests

## 0.1.0

- Initial release of `statecraft`.
- Introduced `AsyncState<T>` sealed class.
- Includes `AsyncInitial`, `AsyncLoading`, `AsyncSuccess`, and `AsyncFailure`.
- Provides `when`, `maybeWhen`, and `whenOrNull` APIs for clean state handling.
