import 'package:flutter/material.dart';
import 'package:taski_to_do/core/failures/failure.dart';

extension ContextExtension on BuildContext {
  ColorScheme get colorScheme => Theme.of(this).colorScheme;
  TextTheme get textTheme => Theme.of(this).textTheme;

  void showFailureSnackBar(Failure f) => ScaffoldMessenger.of(this).showSnackBar(SnackBar(
        content: Text(f.message),
        backgroundColor: colorScheme.error,
      ));

  Future<T?> showBottomSheet<T>(Widget Function(BuildContext) builder) => showModalBottomSheet<T>(
        isScrollControlled: true,
        context: this,
        builder: builder,
      );
}
