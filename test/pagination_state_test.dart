import 'package:statecraft/statecraft.dart';
import 'package:test/test.dart';

void main() {
  group('PaginationState', () {
    test('PaginationInitial when() returns initial case', () {
      const state = PaginationInitial<String>();

      final result = state.when(
        initial: () => 'Initial',
        loading: () => 'Loading',
        loaded: (items, page, hasMore) => 'Loaded',
        loadingMore: (items, page) => 'LoadingMore',
        failure: (error, items, page) => 'Failure',
      );

      expect(result, equals('Initial'));
    });

    test('PaginationLoading when() returns loading case', () {
      const state = PaginationLoading<String>();

      final result = state.when(
        initial: () => 'Initial',
        loading: () => 'Loading',
        loaded: (items, page, hasMore) => 'Loaded',
        loadingMore: (items, page) => 'LoadingMore',
        failure: (error, items, page) => 'Failure',
      );

      expect(result, equals('Loading'));
    });

    test('PaginationLoaded when() returns loaded case with data', () {
      final state = PaginationLoaded<String>(
        ['a', 'b'],
        page: 1,
        hasMore: true,
      );

      final result = state.when(
        initial: () => 'Initial',
        loading: () => 'Loading',
        loaded: (items, page, hasMore) =>
            'Loaded: $items, page=$page, hasMore=$hasMore',
        loadingMore: (items, page) => 'LoadingMore',
        failure: (error, items, page) => 'Failure',
      );

      expect(result, equals('Loaded: [a, b], page=1, hasMore=true'));
    });

    test('PaginationLoadingMore when() returns loadingMore case with data',
        () {
      final state = PaginationLoadingMore<String>(['a', 'b'], page: 1);

      final result = state.when(
        initial: () => 'Initial',
        loading: () => 'Loading',
        loaded: (items, page, hasMore) => 'Loaded',
        loadingMore: (items, page) => 'LoadingMore: $items, page=$page',
        failure: (error, items, page) => 'Failure',
      );

      expect(result, equals('LoadingMore: [a, b], page=1'));
    });

    test('PaginationFailure when() returns failure case with data', () {
      final state = PaginationFailure<String>(
        'Network error',
        items: ['a'],
        page: 1,
      );

      final result = state.when(
        initial: () => 'Initial',
        loading: () => 'Loading',
        loaded: (items, page, hasMore) => 'Loaded',
        loadingMore: (items, page) => 'LoadingMore',
        failure: (error, items, page) =>
            'Failure: $error, items=$items, page=$page',
      );

      expect(result, equals('Failure: Network error, items=[a], page=1'));
    });

    test('maybeWhen returns loaded if matched', () {
      final state = PaginationLoaded<String>(
        ['a'],
        page: 1,
        hasMore: false,
      );

      final result = state.maybeWhen(
        loaded: (items, page, hasMore) => 'Got items: $items',
        orElse: () => 'Fallback',
      );

      expect(result, equals('Got items: [a]'));
    });

    test('maybeWhen falls back to orElse if not matched', () {
      const state = PaginationInitial<String>();

      final result = state.maybeWhen(
        loaded: (items, page, hasMore) => 'Got items',
        orElse: () => 'Fallback',
      );

      expect(result, equals('Fallback'));
    });

    test('whenOrNull returns value if matched', () {
      final state = PaginationFailure<String>(
        'Error',
        items: [],
        page: 0,
      );

      final result = state.whenOrNull(
        failure: (error, items, page) => 'Handled: $error',
      );

      expect(result, equals('Handled: Error'));
    });

    test('whenOrNull returns null if no case matched', () {
      const state = PaginationLoading<String>();

      final result = state.whenOrNull(
        loaded: (items, page, hasMore) => 'Got items',
      );

      expect(result, isNull);
    });

    test('PaginationFailure preserves existing items', () {
      final state = PaginationFailure<String>(
        'Timeout',
        items: ['x', 'y'],
        page: 2,
      );

      expect(state.errorMessage, equals('Timeout'));
      expect(state.items, equals(['x', 'y']));
      expect(state.page, equals(2));
    });
  });
}
