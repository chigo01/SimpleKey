import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:simple_key/src/core/utils/show_snackbar.dart';
import 'package:simple_key/src/feautures/auth/data/repository/auth_repository.dart';
import 'package:simple_key/src/model/users_model.dart';

final userProvider = StateProvider<UserModel?>((ref) => null);

class AuthNotifier extends AsyncNotifier {
  @override
  FutureOr build() {}

  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
    required UserModel userModel,
    required BuildContext context,
    required WidgetRef ref,
  }) async {
    state = const AsyncValue.loading();

    final user = ref.watch(authRepositoryProvider).signUpWithEmailAndPassword(
          email,
          password,
          userModel,
          ref,
        );

    user.then(
      (value) {
        value.fold(
            (failure) => showSnackBar(context, failure.message),
            (userModel) =>
                ref.read(userProvider.notifier).update((state) => userModel));
      },
    );
  }

  Future<void> signInWithGoogle(BuildContext context) async {
    state = const AsyncValue.loading();
    final user = ref.watch(authRepositoryProvider).signInWithGoogle();

    user.then(
      (value) {
        value.fold(
          (failure) => showSnackBar(context, failure.message),
          (userModel) =>
              ref.read(userProvider.notifier).update((state) => userModel),
        );
      },
    );
  }
}
