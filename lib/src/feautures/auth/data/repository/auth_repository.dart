import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:simple_key/src/core/constant/firebase_constant.dart';
import 'package:simple_key/src/core/providers/auth_providers.dart';
import 'package:simple_key/src/core/utils/typedef.dart';
import 'package:simple_key/src/model/users_model.dart';

import '../../../../core/utils/failure.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final fireStore = ref.watch(fireStoreProvider);
  final auth = ref.watch(firebaseAuthProvider);
  return AuthRepository(
    fireStore: fireStore,
    auth: auth,
  );
});

class AuthRepository {
  final FirebaseFirestore _fireStore;
  final FirebaseAuth _auth;
  AuthRepository({
    required FirebaseFirestore fireStore,
    required FirebaseAuth auth,
  })  : _fireStore = fireStore,
        _auth = auth;
  CollectionReference get _users =>
      _fireStore.collection(FirebaseConstants.usersCollection);

  FutureEither<UserModel> signUpWithEmailAndPassword(
    String email,
    String password,
    UserModel userModel,
  ) async {
    try {
      final userCredentials = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
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
