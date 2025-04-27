# statecraft

🎯 **Elegant, lightweight state handling for Flutter and flutter_bloc.**

---

`statecraft` provides simple yet powerful state models (`AsyncState<T>`) that you can use in your Flutter apps, especially with `flutter_bloc`, `Cubit`, or any state management solution.

It removes boilerplate and helps you manage async operations (loading, success, failure) cleanly.

---

## 🚀 Features

- Typed `AsyncState<T>` sealed classes
- Built-in `when`, `maybeWhen`, and `whenOrNull` APIs
- Designed for Dart 3 (`sealed`, `final` classes)
- Extremely lightweight (no code generation, no dependencies)
- Perfect companion for `flutter_bloc` and `Cubit`
- Fully extensible — Form, List, and Pagination states coming soon!

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

`statecraft` solves this by providing **one unified AsyncState<T>** you can reuse everywhere.

---

## 🧩 Usage with flutter_bloc

Here’s a complete real-world example:

---

### 1. Define your Cubit

```dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:statecraft/statecraft.dart';

class PostCubit extends Cubit<AsyncState<Post>> {
  final PostRepository repository;

  PostCubit(this.repository) : super(const AsyncInitial());

  Future<void> fetchPost(int id) async {
    emit(const AsyncLoading());

    try {
      final post = await repository.getPost(id);
      emit(AsyncSuccess(post));
    } catch (e) {
      emit(AsyncFailure(e.toString()));
    }
  }
}
```

---

### 2. Use it in your Flutter Widget

```dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:statecraft/statecraft.dart';

class PostScreen extends StatelessWidget {
  const PostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PostCubit(PostRepository()),
      child: Scaffold(
        appBar: AppBar(title: const Text('Post')),
        body: BlocBuilder<PostCubit, AsyncState<Post>>(
          builder: (context, state) {
            return state.when(
              initial: () => const Center(child: Text('Press the button to load post')),
              loading: () => const Center(child: CircularProgressIndicator()),
              success: (post) => Center(child: Text('Post title: ${post.title}')),
              failure: (error) => Center(child: Text('Failed: $error')),
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => context.read<PostCubit>().fetchPost(1),
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
| :---------------- | :---------------------------------------------- |
| `AsyncInitial`    | The initial idle state before anything starts   |
| `AsyncLoading`    | Represents an ongoing async operation           |
| `AsyncSuccess<T>` | Represents a successful operation with [T] data |
| `AsyncFailure`    | Represents a failure with an error message      |

---

## 📜 API Overview

All AsyncState<T> classes expose:

- `when` — handle every case explicitly
- `maybeWhen` — handle some cases, fallback with `orElse`
- `whenOrNull` — handle only what you need, ignore others

### Example:

```dart
state.maybeWhen(
  success: (data) => Text('Data loaded: $data'),
  orElse: () => const CircularProgressIndicator(),
);
```

---

## 🚧 Roadmap

- [x] `AsyncState<T>` (this release!)
- [ ] `FormState<T>` — for form submissions
- [ ] `ListState<T>` — for simple list loading
- [ ] `PaginationState<T>` — for infinite scroll and pagination

---

## 📃 License

This package is licensed under the MIT License.  
Feel free to use it in your personal or commercial projects.

---

# 🌟 Why use statecraft?

- Stop writing Loading/Loaded/Error states manually.
- Make your Flutter BLoCs smaller, readable, and powerful.
- Type-safe state management with zero extra dependencies.
- Grow with your app: Forms, Lists, Pagination coming soon!

---

Made with ❤️ for Flutter devs who love clean architecture.
