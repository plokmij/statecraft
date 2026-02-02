/// {@template pagination_state}
/// A sealed class representing a paginated data state with common phases:
/// - `initial`: before any data is loaded
/// - `loading`: first page is loading
/// - `loaded`: has data, possibly more pages available
/// - `loadingMore`: loading next page while preserving existing items
/// - `failure`: error occurred, with existing items preserved
///
/// You can use [when], [maybeWhen], or [whenOrNull] to safely map the current state.
/// {@endtemplate}
sealed class PaginationState<T> {
  /// {@macro pagination_state}
  const PaginationState();

  R when<R>({
    required R Function() initial,
    required R Function() loading,
    required R Function(List<T> items, int page, bool hasMore) loaded,
    required R Function(List<T> items, int page) loadingMore,
    required R Function(String errorMessage, List<T> items, int page) failure,
  });

  R maybeWhen<R>({
    R Function()? initial,
    R Function()? loading,
    R Function(List<T> items, int page, bool hasMore)? loaded,
    R Function(List<T> items, int page)? loadingMore,
    R Function(String errorMessage, List<T> items, int page)? failure,
    required R Function() orElse,
  });

  R? whenOrNull<R>({
    R Function()? initial,
    R Function()? loading,
    R Function(List<T> items, int page, bool hasMore)? loaded,
    R Function(List<T> items, int page)? loadingMore,
    R Function(String errorMessage, List<T> items, int page)? failure,
  });
}

/// {@template pagination_initial}
/// The initial state before any data has been loaded.
/// {@endtemplate}
final class PaginationInitial<T> extends PaginationState<T> {
  /// {@macro pagination_initial}
  const PaginationInitial();

  @override
  R when<R>({
    required R Function() initial,
    required R Function() loading,
    required R Function(List<T> items, int page, bool hasMore) loaded,
    required R Function(List<T> items, int page) loadingMore,
    required R Function(String errorMessage, List<T> items, int page) failure,
  }) {
    return initial();
  }

  @override
  R maybeWhen<R>({
    R Function()? initial,
    R Function()? loading,
    R Function(List<T> items, int page, bool hasMore)? loaded,
    R Function(List<T> items, int page)? loadingMore,
    R Function(String errorMessage, List<T> items, int page)? failure,
    required R Function() orElse,
  }) {
    return initial?.call() ?? orElse();
  }

  @override
  R? whenOrNull<R>({
    R Function()? initial,
    R Function()? loading,
    R Function(List<T> items, int page, bool hasMore)? loaded,
    R Function(List<T> items, int page)? loadingMore,
    R Function(String errorMessage, List<T> items, int page)? failure,
  }) {
    return initial?.call();
  }
}

/// {@template pagination_loading}
/// The first page is currently being loaded.
/// {@endtemplate}
final class PaginationLoading<T> extends PaginationState<T> {
  /// {@macro pagination_loading}
  const PaginationLoading();

  @override
  R when<R>({
    required R Function() initial,
    required R Function() loading,
    required R Function(List<T> items, int page, bool hasMore) loaded,
    required R Function(List<T> items, int page) loadingMore,
    required R Function(String errorMessage, List<T> items, int page) failure,
  }) {
    return loading();
  }

  @override
  R maybeWhen<R>({
    R Function()? initial,
    R Function()? loading,
    R Function(List<T> items, int page, bool hasMore)? loaded,
    R Function(List<T> items, int page)? loadingMore,
    R Function(String errorMessage, List<T> items, int page)? failure,
    required R Function() orElse,
  }) {
    return loading?.call() ?? orElse();
  }

  @override
  R? whenOrNull<R>({
    R Function()? initial,
    R Function()? loading,
    R Function(List<T> items, int page, bool hasMore)? loaded,
    R Function(List<T> items, int page)? loadingMore,
    R Function(String errorMessage, List<T> items, int page)? failure,
  }) {
    return loading?.call();
  }
}

/// {@template pagination_loaded}
/// Data has been loaded with items, current page, and whether more pages exist.
/// {@endtemplate}
final class PaginationLoaded<T> extends PaginationState<T> {
  final List<T> items;
  final int page;
  final bool hasMore;

  /// {@macro pagination_loaded}
  const PaginationLoaded(this.items, {required this.page, required this.hasMore});

  @override
  R when<R>({
    required R Function() initial,
    required R Function() loading,
    required R Function(List<T> items, int page, bool hasMore) loaded,
    required R Function(List<T> items, int page) loadingMore,
    required R Function(String errorMessage, List<T> items, int page) failure,
  }) {
    return loaded(items, page, hasMore);
  }

  @override
  R maybeWhen<R>({
    R Function()? initial,
    R Function()? loading,
    R Function(List<T> items, int page, bool hasMore)? loaded,
    R Function(List<T> items, int page)? loadingMore,
    R Function(String errorMessage, List<T> items, int page)? failure,
    required R Function() orElse,
  }) {
    return loaded != null ? loaded(items, page, hasMore) : orElse();
  }

  @override
  R? whenOrNull<R>({
    R Function()? initial,
    R Function()? loading,
    R Function(List<T> items, int page, bool hasMore)? loaded,
    R Function(List<T> items, int page)? loadingMore,
    R Function(String errorMessage, List<T> items, int page)? failure,
  }) {
    return loaded?.call(items, page, hasMore);
  }
}

/// {@template pagination_loading_more}
/// Loading the next page while preserving existing items.
/// {@endtemplate}
final class PaginationLoadingMore<T> extends PaginationState<T> {
  final List<T> items;
  final int page;

  /// {@macro pagination_loading_more}
  const PaginationLoadingMore(this.items, {required this.page});

  @override
  R when<R>({
    required R Function() initial,
    required R Function() loading,
    required R Function(List<T> items, int page, bool hasMore) loaded,
    required R Function(List<T> items, int page) loadingMore,
    required R Function(String errorMessage, List<T> items, int page) failure,
  }) {
    return loadingMore(items, page);
  }

  @override
  R maybeWhen<R>({
    R Function()? initial,
    R Function()? loading,
    R Function(List<T> items, int page, bool hasMore)? loaded,
    R Function(List<T> items, int page)? loadingMore,
    R Function(String errorMessage, List<T> items, int page)? failure,
    required R Function() orElse,
  }) {
    return loadingMore != null ? loadingMore(items, page) : orElse();
  }

  @override
  R? whenOrNull<R>({
    R Function()? initial,
    R Function()? loading,
    R Function(List<T> items, int page, bool hasMore)? loaded,
    R Function(List<T> items, int page)? loadingMore,
    R Function(String errorMessage, List<T> items, int page)? failure,
  }) {
    return loadingMore?.call(items, page);
  }
}

/// {@template pagination_failure}
/// An error occurred, with existing items preserved.
/// {@endtemplate}
final class PaginationFailure<T> extends PaginationState<T> {
  final String errorMessage;
  final List<T> items;
  final int page;

  /// {@macro pagination_failure}
  const PaginationFailure(this.errorMessage,
      {required this.items, required this.page});

  @override
  R when<R>({
    required R Function() initial,
    required R Function() loading,
    required R Function(List<T> items, int page, bool hasMore) loaded,
    required R Function(List<T> items, int page) loadingMore,
    required R Function(String errorMessage, List<T> items, int page) failure,
  }) {
    return failure(errorMessage, items, page);
  }

  @override
  R maybeWhen<R>({
    R Function()? initial,
    R Function()? loading,
    R Function(List<T> items, int page, bool hasMore)? loaded,
    R Function(List<T> items, int page)? loadingMore,
    R Function(String errorMessage, List<T> items, int page)? failure,
    required R Function() orElse,
  }) {
    return failure != null ? failure(errorMessage, items, page) : orElse();
  }

  @override
  R? whenOrNull<R>({
    R Function()? initial,
    R Function()? loading,
    R Function(List<T> items, int page, bool hasMore)? loaded,
    R Function(List<T> items, int page)? loadingMore,
    R Function(String errorMessage, List<T> items, int page)? failure,
  }) {
    return failure?.call(errorMessage, items, page);
  }
}
