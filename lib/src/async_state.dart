/// {@template async_state}
/// A sealed class representing an asynchronous state with common phases:
/// - `initial`: before any operation starts
/// - `loading`: during an ongoing asynchronous operation
/// - `success`: when the operation completes successfully
/// - `failure`: when the operation fails
///
/// You can use [when], [maybeWhen], or [whenOrNull] to safely map the current state.
/// {@endtemplate}
sealed class AsyncState<T> {
  /// {@macro async_state}
  const AsyncState();

  /// Maps the current [AsyncState] to a value of type [R].
  ///
  /// Requires handlers for all possible states:
  /// - [initial]: Called if the state is [AsyncInitial].
  /// - [loading]: Called if the state is [AsyncLoading].
  /// - [success]: Called if the state is [AsyncSuccess], with [data].
  /// - [failure]: Called if the state is [AsyncFailure], with [errorMessage].
  ///
  /// Example:
  /// ```dart
  /// state.when(
  ///   initial: () => Text('Idle'),
  ///   loading: () => CircularProgressIndicator(),
  ///   success: (data) => Text('Loaded: $data'),
  ///   failure: (error) => Text('Error: $error'),
  /// );
  /// ```
  R when<R>({
    required R Function() initial,
    required R Function() loading,
    required R Function(T data) success,
    required R Function(String errorMessage) failure,
  });

  /// Maps the current [AsyncState] to a value of type [R].
  ///
  /// Similar to [when], but you only need to handle the states you care about.
  /// If the current state isn't handled, the [orElse] fallback will be called.
  ///
  /// Example:
  /// ```dart
  /// state.maybeWhen(
  ///   success: (data) => Text('Loaded: $data'),
  ///   orElse: () => Text('Not loaded yet'),
  /// );
  /// ```
  R maybeWhen<R>({
    R Function()? initial,
    R Function()? loading,
    R Function(T data)? success,
    R Function(String errorMessage)? failure,
    required R Function() orElse,
  });

  /// Maps the current [AsyncState] to a value of type [R] or returns `null`.
  ///
  /// Similar to [when], but optional handlers for each state.
  /// If no matching handler is found, returns `null`.
  ///
  /// Example:
  /// ```dart
  /// final widget = state.whenOrNull(
  ///   success: (data) => Text('Data: $data'),
  /// ) ?? const Text('No data yet');
  /// ```
  R? whenOrNull<R>({
    R Function()? initial,
    R Function()? loading,
    R Function(T data)? success,
    R Function(String errorMessage)? failure,
  });
}

/// {@template async_initial}
/// The initial state before any asynchronous operation has started.
///
/// Typically used to represent an idle or untouched state.
///
/// Example:
/// ```dart
/// if (state is AsyncInitial) {
///   // Show idle UI
/// }
/// ```
/// {@endtemplate}
final class AsyncInitial<T> extends AsyncState<T> {
  /// {@macro async_initial}
  const AsyncInitial();

  @override
  R when<R>({
    required R Function() initial,
    required R Function() loading,
    required R Function(T data) success,
    required R Function(String errorMessage) failure,
  }) {
    return initial();
  }

  @override
  R maybeWhen<R>({
    R Function()? initial,
    R Function()? loading,
    R Function(T data)? success,
    R Function(String errorMessage)? failure,
    required R Function() orElse,
  }) {
    return initial?.call() ?? orElse();
  }

  @override
  R? whenOrNull<R>({
    R Function()? initial,
    R Function()? loading,
    R Function(T data)? success,
    R Function(String errorMessage)? failure,
  }) {
    return initial?.call();
  }
}

/// {@template async_loading}
/// Represents an ongoing asynchronous operation.
///
/// Typically used to render loading indicators while waiting for
/// an operation to complete.
///
/// Example:
/// ```dart
/// if (state is AsyncLoading) {
///   // Show loading spinner
/// }
/// ```
/// {@endtemplate}
final class AsyncLoading<T> extends AsyncState<T> {
  const AsyncLoading();

  @override
  R when<R>({
    required R Function() initial,
    required R Function() loading,
    required R Function(T data) success,
    required R Function(String errorMessage) failure,
  }) {
    return loading();
  }

  @override
  R maybeWhen<R>({
    R Function()? initial,
    R Function()? loading,
    R Function(T data)? success,
    R Function(String errorMessage)? failure,
    required R Function() orElse,
  }) {
    return loading?.call() ?? orElse();
  }

  @override
  R? whenOrNull<R>({
    R Function()? initial,
    R Function()? loading,
    R Function(T data)? success,
    R Function(String errorMessage)? failure,
  }) {
    return loading?.call();
  }
}

/// {@template async_success}
/// Represents a successful completion of an asynchronous operation.
///
/// Typically used to display the result of an operation.
///
/// Example:
/// ```dart
/// if (state is AsyncSuccess) {
///  final data = (state as AsyncSuccess).data;
///     //Show the loaded data
/// }
/// ```
/// {@endtemplate}
final class AsyncSuccess<T> extends AsyncState<T> {
  final T data;

  const AsyncSuccess(this.data);

  @override
  R when<R>({
    required R Function() initial,
    required R Function() loading,
    required R Function(T data) success,
    required R Function(String errorMessage) failure,
  }) {
    return success(data);
  }

  @override
  R maybeWhen<R>({
    R Function()? initial,
    R Function()? loading,
    R Function(T data)? success,
    R Function(String errorMessage)? failure,
    required R Function() orElse,
  }) {
    return success != null ? success(data) : orElse();
  }

  @override
  R? whenOrNull<R>({
    R Function()? initial,
    R Function()? loading,
    R Function(T data)? success,
    R Function(String errorMessage)? failure,
  }) {
    return success?.call(data);
  }
}

/// {@template async_failure}
/// Represents a failed asynchronous operation with an error message.
///
/// Typically used to display error states or retry options.
///
/// Example:
/// ```dart
/// if (state is AsyncFailure) {
///   final error = (state as AsyncFailure).errorMessage;
///   // Show error message or retry button
/// }
/// ```
/// {@endtemplate}
final class AsyncFailure<T> extends AsyncState<T> {
  final String errorMessage;

  const AsyncFailure(this.errorMessage);

  @override
  R when<R>({
    required R Function() initial,
    required R Function() loading,
    required R Function(T data) success,
    required R Function(String errorMessage) failure,
  }) {
    return failure(errorMessage);
  }

  @override
  R maybeWhen<R>({
    R Function()? initial,
    R Function()? loading,
    R Function(T data)? success,
    R Function(String errorMessage)? failure,
    required R Function() orElse,
  }) {
    return failure != null ? failure(errorMessage) : orElse();
  }

  @override
  R? whenOrNull<R>({
    R Function()? initial,
    R Function()? loading,
    R Function(T data)? success,
    R Function(String errorMessage)? failure,
  }) {
    return failure?.call(errorMessage);
  }
}
