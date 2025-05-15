import 'package:statecraft/statecraft.dart';
import 'package:test/test.dart';

void main() {
  group('FormState', () {
    test('FormInitial when() returns initial case', () {
      const state = FormInitial<String>();

      final result = state.when(
        initial: () => 'Initial',
        submitting: () => 'Submitting',
        success: (data) => 'Success: $data',
        failure: (error) => 'Failure: $error',
      );

      expect(result, equals('Initial'));
    });

    test('FormSubmitting when() returns submitting case', () {
      const state = FormSubmitting<String>();

      final result = state.when(
        initial: () => 'Initial',
        submitting: () => 'Submitting',
        success: (data) => 'Success: $data',
        failure: (error) => 'Failure: $error',
      );

      expect(result, equals('Submitting'));
    });

    test('FormSuccess when() returns success case with data', () {
      const state = FormSuccess<String>('Form submitted');

      final result = state.when(
        initial: () => 'Initial',
        submitting: () => 'Submitting',
        success: (data) => 'Success: $data',
        failure: (error) => 'Failure: $error',
      );

      expect(result, equals('Success: Form submitted'));
    });

    test('FormFailure when() returns failure case with error', () {
      const state = FormFailure<String>('Invalid input');

      final result = state.when(
        initial: () => 'Initial',
        submitting: () => 'Submitting',
        success: (data) => 'Success: $data',
        failure: (error) => 'Failure: $error',
      );

      expect(result, equals('Failure: Invalid input'));
    });

    test('maybeWhen returns success if matched', () {
      const state = FormSuccess<String>('Form complete');

      final result = state.maybeWhen(
        success: (data) => 'Maybe Success: $data',
        orElse: () => 'Fallback',
      );

      expect(result, equals('Maybe Success: Form complete'));
    });

    test('maybeWhen falls back to orElse if not matched', () {
      const state = FormInitial<String>();

      final result = state.maybeWhen(
        success: (data) => 'Maybe Success: $data',
        orElse: () => 'Fallback',
      );

      expect(result, equals('Fallback'));
    });

    test('whenOrNull returns value if matched', () {
      const state = FormFailure<String>('Validation failed');

      final result = state.whenOrNull(
        failure: (error) => 'Handled Failure: $error',
      );

      expect(result, equals('Handled Failure: Validation failed'));
    });

    test('whenOrNull returns null if no case matched', () {
      const state = FormSubmitting<String>();

      final result = state.whenOrNull(
        success: (data) => 'Handled Success: $data',
      );

      expect(result, isNull);
    });
  });
}
