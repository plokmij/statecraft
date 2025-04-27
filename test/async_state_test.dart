import 'package:statecraft/statecraft.dart';
import 'package:test/test.dart';

void main() {
  group('AsyncState', () {
    test('AsyncInitial when() returns initial case', () {
      const state = AsyncInitial<String>();

      final result = state.when(
        initial: () => 'Initial',
        loading: () => 'Loading',
        success: (data) => 'Success: $data',
        failure: (error) => 'Failure: $error',
      );

      expect(result, equals('Initial'));
    });

    test('AsyncLoading when() returns loading case', () {
      const state = AsyncLoading<String>();

      final result = state.when(
        initial: () => 'Initial',
        loading: () => 'Loading',
        success: (data) => 'Success: $data',
        failure: (error) => 'Failure: $error',
      );

      expect(result, equals('Loading'));
    });

    test('AsyncSuccess when() returns success case with data', () {
      const state = AsyncSuccess<String>('Loaded data');

      final result = state.when(
        initial: () => 'Initial',
        loading: () => 'Loading',
        success: (data) => 'Success: $data',
        failure: (error) => 'Failure: $error',
      );

      expect(result, equals('Success: Loaded data'));
    });

    test('AsyncFailure when() returns failure case with error', () {
      const state = AsyncFailure<String>('Something went wrong');

      final result = state.when(
        initial: () => 'Initial',
        loading: () => 'Loading',
        success: (data) => 'Success: $data',
        failure: (error) => 'Failure: $error',
      );

      expect(result, equals('Failure: Something went wrong'));
    });

    test('maybeWhen returns success if matched', () {
      const state = AsyncSuccess<String>('Loaded data');

      final result = state.maybeWhen(
        success: (data) => 'Maybe Success: $data',
        orElse: () => 'Fallback',
      );

      expect(result, equals('Maybe Success: Loaded data'));
    });

    test('maybeWhen falls back to orElse if not matched', () {
      const state = AsyncInitial<String>();

      final result = state.maybeWhen(
        success: (data) => 'Maybe Success: $data',
        orElse: () => 'Fallback',
      );

      expect(result, equals('Fallback'));
    });

    test('whenOrNull returns value if matched', () {
      const state = AsyncFailure<String>('Failure reason');

      final result = state.whenOrNull(
        failure: (error) => 'Handled Failure: $error',
      );

      expect(result, equals('Handled Failure: Failure reason'));
    });

    test('whenOrNull returns null if no case matched', () {
      const state = AsyncLoading<String>();

      final result = state.whenOrNull(
        success: (data) => 'Handled Success: $data',
      );

      expect(result, isNull);
    });
  });
}
