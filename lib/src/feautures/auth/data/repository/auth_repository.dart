import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fpdart/fpdart.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:simple_key/src/core/constant/firebase_constant.dart';
import 'package:simple_key/src/core/providers/auth_providers.dart';
import 'package:simple_key/src/core/utils/cam.dart';
import 'package:simple_key/src/core/utils/extension.dart';
import 'package:simple_key/src/core/utils/typedef.dart';
import 'package:simple_key/src/model/users_model.dart';
import 'package:path/path.dart' as path;

import '../../../../core/utils/failure.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final fireStore = ref.watch(fireStoreProvider);
  final auth = ref.watch(firebaseAuthProvider);
  final storage = ref.watch(firebaseStorageProvider);
  return AuthRepository(
    fireStore: fireStore,
    auth: auth,
    storage: storage,
  );
});

class AuthRepository {
  final FirebaseFirestore _fireStore;
  final FirebaseAuth _auth;
  final FirebaseStorage _firebaseStorage;
  AuthRepository({
    required FirebaseFirestore fireStore,
    required FirebaseAuth auth,
    required FirebaseStorage storage,
  })  : _fireStore = fireStore,
        _auth = auth,
        _firebaseStorage = storage;

  CollectionReference get _users =>
      _fireStore.collection(FirebaseConstants.usersCollection);

  FutureEither<UserModel> signUpWithEmailAndPassword(
    String email,
    String password,
    UserModel userModel,
    WidgetRef ref,
  ) async {
    try {
      final userCredentials = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      userModel = userModel.copyWith(
        id: userCredentials.user!.uid,
        image: await uploadImage(ref),
      );

      await _users.doc(userCredentials.user!.uid).set(userModel.toMap());
      return right(userModel);
    } on FirebaseException catch (e) {
      return left(
        Failure(
          catchFirebaseEmailError(e.toString()),
        ),
      );
    }
  }

  FutureEither<UserModel> signInWithGoogle() async {
    try {
      late UserModel userModel;
      final GoogleSignIn googleSignIn = GoogleSignIn();

      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();

      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );
        await _auth.signInWithCredential(credential);
        userModel = UserModel(
          userName: googleSignInAccount.displayName!,
          userRole: "Customer",
          email: googleSignInAccount.email,
          image: googleSignInAccount.photoUrl,
        );

        await _users.add(userModel.toMap());
      }
      return right(userModel);
    } on FirebaseException catch (e) {
      return left(
        Failure(
          catchFirebaseGoogleSignInError(e.toString()),
        ),
      );
    }
  }

  Future<String> uploadImage(
    WidgetRef ref,
  ) async {
    final imagesPicked = ref.watch(imagePath);
    String? newImage;

    if (imagesPicked.isNotNull) {
      Reference reference =
          _firebaseStorage.ref().child('user/${path.basename(imagesPicked!)}');
      await reference.putFile(File(imagesPicked));
      newImage = await reference.getDownloadURL();

      // ref.read(image.notifier).update((state) => state = newImage);
      // print(newImage);
    }
    return newImage ?? "";
  }
}

String catchFirebaseEmailError(String failure) {
  switch (failure) {
    case 'email-already-in-use':
      return 'The email address is already in use by another account.';
    case 'invalid-email':
      return 'The email address is badly formatted.';
    case 'operation-not-allowed':
      return 'Password sign-in is disabled for this project.';
    case 'weak-password':
      return 'The password must be 6 characters long or more.';
    default:
      return 'Something went wrong';
  }
}

String catchFirebaseGoogleSignInError(String failure) {
  return {
        'account-exists-with-different-credential':
            'The account already exists with a different credential.',
        'invalid-credential': 'Error occurred while accessing credentials.',
        'operation-not-allowed': 'This operation is not allowed.',
      }[failure] ??
      "Error occurred using Google Sign-In. Try again.";
}
