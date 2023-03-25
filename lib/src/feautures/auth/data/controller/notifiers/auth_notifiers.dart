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

  void signInWithEmailAndPassword(
    String email,
    String password,
    UserModel userModel,
    BuildContext context,
  ) {
    final user = ref.watch(authRepositoryProvider).signUpWithEmailAndPassword(
          email,
          password,
          userModel,
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

  void signInWithGoogle(BuildContext context) {
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
