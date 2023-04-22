import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:simple_key/src/feautures/auth/data/controller/notifiers/auth_notifiers.dart';
import 'package:simple_key/src/feautures/auth/model/authmodel.dart';

final authNotifierProvider = NotifierProvider<AuthNotifier, bool>(
  () => AuthNotifier(),
);
final loggedInSuccessProvider = StateProvider<bool>((ref) => false);
final errorMessageProvider = StateProvider<String>((ref) => '');
final authStateProvider = StateProvider<AuthState>((ref) => AuthState.failed);
