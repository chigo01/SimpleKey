import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:simple_key/src/core/providers/auth_providers.dart';
import 'package:simple_key/src/feautures/userProfile/data/repository/user_repository.dart';
import 'package:simple_key/src/model/users_model.dart';

final getUser = StreamProvider<UserModel>((ref) async* {
  final user = ref.watch(userRepositoryProvider);
  yield* user.getUser();
});

final getAllUser =
    StreamProvider.family<UserModel, String>((ref, senderID) async* {
  final user = ref.watch(userRepositoryProvider);
  yield* user.getUserForSender(senderID);
});

final getUserForProperty =
    StreamProvider.family<UserModel, String>((ref, propertyOwnerId) async* {
  final user = ref.watch(userRepositoryProvider);
  yield* user.getUserForProperty(propertyOwnerId);
});

final userRepositoryProvider = Provider<UserRepository>((ref) {
  final auth = ref.watch(firebaseAuthProvider);
  final storage = ref.watch(firebaseStorageProvider);
  final fireStore = ref.watch(fireStoreProvider);
  return UserRepository(
    auth: auth,
    storage: storage,
    firebaseFirestore: fireStore,
  );
});
