sealed class FormState<T> {
  const FormState();

  R when<R>({
    required R Function() initial,
    required R Function() submitting,
    required R Function(T data) success,
    required R Function(String errorMessage) failure,
  });

  R maybeWhen<R>({
    R Function()? initial,
    R Function()? submitting,
    R Function(T data)? success,
    R Function(String errorMessage)? failure,
    required R Function() orElse,
  });

  R? whenOrNull<R>({
    R Function()? initial,
    R Function()? submitting,
    R Function(T data)? success,
    R Function(String errorMessage)? failure,
  });
}

final class FormInitial<T> extends FormState<T> {
  const FormInitial();

  @override
  R when<R>({
    required R Function() initial,
    required R Function() submitting,
    required R Function(T data) success,
    required R Function(String errorMessage) failure,
  }) {
    return initial();
  }

  @override
  R maybeWhen<R>({
    R Function()? initial,
    R Function()? submitting,
    R Function(T data)? success,
    R Function(String errorMessage)? failure,
    required R Function() orElse,
  }) {
    return initial?.call() ?? orElse();
  }

  @override
  R? whenOrNull<R>({
    R Function()? initial,
    R Function()? submitting,
    R Function(T data)? success,
    R Function(String errorMessage)? failure,
  }) {
    return initial?.call();
  }

  @override
  String toString() => 'FormInitial';

  @override
  bool operator ==(Object other) => other is FormInitial<T>;

  @override
  int get hashCode => runtimeType.hashCode;
}

final class FormSubmitting<T> extends FormState<T> {
  const FormSubmitting();

  @override
  R when<R>({
    required R Function() initial,
    required R Function() submitting,
    required R Function(T data) success,
    required R Function(String errorMessage) failure,
  }) {
    return submitting();
  }

  @override
  R maybeWhen<R>({
    R Function()? initial,
    R Function()? submitting,
    R Function(T data)? success,
    R Function(String errorMessage)? failure,
    required R Function() orElse,
  }) {
    return submitting?.call() ?? orElse();
  }

  @override
  R? whenOrNull<R>({
    R Function()? initial,
    R Function()? submitting,
    R Function(T data)? success,
    R Function(String errorMessage)? failure,
  }) {
    return submitting?.call();
  }

  @override
  String toString() => 'FormSubmitting';

  @override
  bool operator ==(Object other) => other is FormSubmitting<T>;

  @override
  int get hashCode => runtimeType.hashCode;
}

final class FormSuccess<T> extends FormState<T> {
  final T data;
  const FormSuccess(this.data);

  @override
  R when<R>({
    required R Function() initial,
    required R Function() submitting,
    required R Function(T data) success,
    required R Function(String errorMessage) failure,
  }) {
    return success(data);
  }

  @override
  R maybeWhen<R>({
    R Function()? initial,
    R Function()? submitting,
    R Function(T data)? success,
    R Function(String errorMessage)? failure,
    required R Function() orElse,
  }) {
    return success?.call(data) ?? orElse();
  }

  @override
  R? whenOrNull<R>({
    R Function()? initial,
    R Function()? submitting,
    R Function(T data)? success,
    R Function(String errorMessage)? failure,
  }) {
    return success?.call(data);
  }

  @override
  String toString() => 'FormSuccess(data: $data)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FormSuccess<T> &&
          runtimeType == other.runtimeType &&
          data == other.data;

  @override
  int get hashCode => data.hashCode;
}

final class FormFailure<T> extends FormState<T> {
  final String errorMessage;
  const FormFailure(this.errorMessage);

  @override
  R when<R>({
    required R Function() initial,
    required R Function() submitting,
    required R Function(T data) success,
    required R Function(String errorMessage) failure,
  }) {
    return failure(errorMessage);
  }

  @override
  R maybeWhen<R>({
    R Function()? initial,
    R Function()? submitting,
    R Function(T data)? success,
    R Function(String errorMessage)? failure,
    required R Function() orElse,
  }) {
    return failure?.call(errorMessage) ?? orElse();
  }

  @override
  R? whenOrNull<R>({
    R Function()? initial,
    R Function()? submitting,
    R Function(T data)? success,
    R Function(String errorMessage)? failure,
  }) {
    return failure?.call(errorMessage);
  }

  @override
  String toString() => 'FormFailure(errorMessage: $errorMessage)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FormFailure<T> &&
          runtimeType == other.runtimeType &&
          errorMessage == other.errorMessage;

  @override
  int get hashCode => errorMessage.hashCode;
}
