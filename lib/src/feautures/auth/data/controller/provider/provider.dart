import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:simple_key/src/feautures/auth/data/controller/notifiers/auth_notifiers.dart';

final authNotifierProvider = AsyncNotifierProvider(
  () => AuthNotifier(),
);
