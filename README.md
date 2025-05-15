# statecraft

🎯 **Elegant, lightweight state handling for Flutter and flutter_bloc.**

---

`statecraft` provides simple yet powerful state models (`AsyncState<T>`, `FormState<T>`) that you can use in your Flutter apps, especially with `flutter_bloc`, `Cubit`, or any state management solution.

It removes boilerplate and helps you manage async operations (loading, success, failure) and form states cleanly.

---

## 🚀 Features

- Typed `AsyncState<T>` and `FormState<T>` sealed classes
- Built-in `when`, `maybeWhen`, and `whenOrNull` APIs
- Designed for Dart 3 (`sealed`, `final` classes)
- Extremely lightweight (no code generation, no dependencies)
- Perfect companion for `flutter_bloc` and `Cubit`
- Fully extensible — Pagination state coming soon!

---

## 📦 Installation

```bash
dart pub add statecraft
```

or manually in your `pubspec.yaml`:

```yaml
dependencies:
  statecraft: ^0.1.0
```

---

## ✨ Philosophy

Handling asynchronous states in Flutter is a repetitive task.  
Typically you create:

- Loading State
- Success State
- Error State

for every BLoC manually.  
This leads to **boilerplate** and **messy switch-cases**.

`statecraft` solves this by providing **unified AsyncState<T> and FormState<T>** you can reuse everywhere.

---

## 🧩 Usage with flutter_bloc

Here’s a complete real-world example using `AsyncState<T>`:

### 1. Define your Cubit

```dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:statecraft/statecraft.dart';

class ExampleCubit extends Cubit<AsyncState<String>> {
  final ExampleRepository repository;

  ExampleCubit(this.repository) : super(const AsyncInitial());

  Future<void> fetchData() async {
    emit(const AsyncLoading());
    try {
      final result = await repository.loadExampleData();
      emit(AsyncSuccess(result));
    } catch (e) {
      emit(AsyncFailure(e.toString()));
    }
  }
}
```

### 2. Use it in your Flutter Widget

```dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:statecraft/statecraft.dart';

class ExampleScreen extends StatelessWidget {
  const ExampleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ExampleCubit(ExampleRepository()),
      child: Scaffold(
        appBar: AppBar(title: const Text('Async Example')),
        body: BlocBuilder<ExampleCubit, AsyncState<String>>(
          builder: (context, state) {
            return state.when(
              initial: () => const Center(child: Text('Press the button to load data')),
              loading: () => const Center(child: CircularProgressIndicator()),
              success: (data) => Center(child: Text('Result: $data')),
              failure: (error) => Center(child: Text('Failed: $error')),
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => context.read<ExampleCubit>().fetchData(),
          child: const Icon(Icons.download),
        ),
      ),
    );
  }
}
```

---

## ✨ AsyncState Lifecycle

| State             | Meaning                                         |
| ----------------- | ----------------------------------------------- |
| `AsyncInitial`    | The initial idle state before anything starts   |
| `AsyncLoading`    | Represents an ongoing async operation           |
| `AsyncSuccess<T>` | Represents a successful operation with [T] data |
| `AsyncFailure`    | Represents a failure with an error message      |

---

## ✨ FormState Lifecycle

Use `FormState<T>` to handle user form submission flows — from untouched to submission, success, or error.

| State            | Meaning                                  |
| ---------------- | ---------------------------------------- |
| `FormInitial`    | Form has not been submitted yet          |
| `FormSubmitting` | Submission in progress                   |
| `FormSuccess<T>` | Submitted successfully, with result data |
| `FormFailure`    | Submission failed with error message     |

### 🔄 Example: Form Cubit

```dart
class ProfileFormCubit extends Cubit<FormState<Profile>> {
  ProfileFormCubit() : super(const FormInitial());

  Future<void> submit(String name) async {
    emit(const FormSubmitting());
    try {
      await Future.delayed(const Duration(seconds: 2));
      emit(FormSuccess(Profile(name: name)));
    } catch (_) {
      emit(FormFailure('Submission failed.'));
    }
  }
}
```

### 🧱 In your Widget

```dart
BlocBuilder<ProfileFormCubit, FormState<Profile>>(
  builder: (context, state) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        state.when(
          initial: () => const Text('Please submit the form'),
          submitting: () => const CircularProgressIndicator(),
          success: (profile) => Text('Welcome ${profile.name}'),
          failure: (error) => Text('Error: $error'),
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: () => context.read<ProfileFormCubit>().submit('Samfan'),
          child: const Text('Submit'),
        ),
      ],
    );
  },
);
```

---

## 📜 API Overview

All states expose:

- `when` — handle every case explicitly
- `maybeWhen` — handle some cases, fallback with `orElse`
- `whenOrNull` — handle only what you need, ignore others

### Example:

```dart
state.maybeWhen(
  success: (data) => Text('Loaded: $data'),
  orElse: () => const CircularProgressIndicator(),
);
```

---

## 🚧 Roadmap

- [x] `AsyncState<T>` – async loading/success/failure
- [x] `FormState<T>` – form submission lifecycle ✅
- [ ] `PaginationState<T>` – for infinite scroll & pagination

---

## 📃 License

MIT License — free to use for personal or commercial projects.

---

# 🌟 Why use statecraft?

- Stop writing `Loading/Loaded/Error` states manually.
- Smaller, readable, and reusable BLoC/Cubit logic.
- Type-safe state management with zero boilerplate.
- Grows with your app: Async, Form, Pagination states.

---

Made with ❤️ for Flutter devs who love clean architecture.
