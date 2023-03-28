// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:simple_key/src/core/utils/show_snackbar.dart';

class AsyncWidget<T> extends StatelessWidget {
  final AsyncValue<T> asyncValue;
  final Widget Function(T data) data;
  const AsyncWidget({
    super.key,
    required this.asyncValue,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return asyncValue.when(
      data: data,
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Text('Error: $error'),
    );
  }
}
