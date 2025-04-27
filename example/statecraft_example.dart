import 'package:statecraft/statecraft.dart';

void main() async {
  // Imagine this as a service call that can load, succeed, or fail
  AsyncState<String> state = const AsyncInitial();

  printState(state);

  // Start loading
  state = const AsyncLoading();
  printState(state);

  await Future.delayed(const Duration(seconds: 1));

  // Simulate success
  state = AsyncSuccess('Hello, Statecraft!');
  printState(state);

  await Future.delayed(const Duration(seconds: 1));

  // Simulate failure
  state = AsyncFailure('Something went wrong.');
  printState(state);
}

/// Prints the current state description
void printState(AsyncState<String> state) {
  final description = state.when(
    initial: () => 'State: Initial (idle)',
    loading: () => 'State: Loading...',
    success: (data) => 'State: Success with data: $data',
    failure: (error) => 'State: Failure with error: $error',
  );

  print(description);
}
