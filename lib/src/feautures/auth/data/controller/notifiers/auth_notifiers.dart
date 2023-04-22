import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:simple_key/src/core/utils/show_snackbar.dart';
import 'package:simple_key/src/feautures/auth/data/controller/provider/provider.dart';
import 'package:simple_key/src/feautures/auth/data/repository/auth_repository.dart';
import 'package:simple_key/src/feautures/auth/model/authmodel.dart';
import 'package:simple_key/src/model/users_model.dart';

final userProvider = StateProvider<UserModel?>((ref) => null);

class AuthNotifier extends Notifier<bool> {
  bool isLoading = false;

  @override
  bool build() {
    return isLoading;
  }

  Future<void> signUpWithEmailAndPassword({
    required String email,
    required String password,
    required UserModel userModel,
    required BuildContext context,
    required WidgetRef ref,
  }) async {
    state = isLoading = true;

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

  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
    required BuildContext context,
    required WidgetRef ref,
  }) async {
    state = isLoading = true;
    final user = ref.watch(authRepositoryProvider).signInWithEmailAndPassword(
          email,
          password,
          ref,
        );

    user.then(
      (value) {
        value.fold((failure) {
          ref
              .read(authStateProvider.notifier)
              .update((state) => AuthState.failed);
          state = isLoading = false;

          showSnackBar(context, failure.message);
        }, (userModel) {
          ref
              .read(authStateProvider.notifier)
              .update((state) => AuthState.successful);
          state = isLoading = false;
        });
      },
    );
  }

  Future<void> signInWithGoogle(BuildContext context) async {
    state = isLoading = true;
    final user = ref.watch(authRepositoryProvider).signInWithGoogle();

    user.then(
      (value) {
        value.fold((failure) {
          state = isLoading = false;
          showSnackBar(context, failure.message);
        }, (userModel) {
          state = isLoading = false;
          ref.read(userProvider.notifier).update((state) => userModel);
        });
      },
    );
    state = isLoading = false;
  }

  Future<void> signOut() async {
    ref.watch(authRepositoryProvider).signOut();
  }
}
