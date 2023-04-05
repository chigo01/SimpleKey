// import 'package:firebase_auth/firebase_auth.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:simple_key/src/core/constant/firebase_constant.dart';
import 'package:simple_key/src/model/users_model.dart';

class UserRepository {
  UserRepository({
    required FirebaseAuth auth,
    required FirebaseStorage storage,
    required FirebaseFirestore firebaseFirestore,
  })  : _auth = auth,
        _storage = storage,
        _firebaseFirestore = firebaseFirestore;

  final FirebaseAuth _auth;
  final FirebaseStorage _storage;
  final FirebaseFirestore _firebaseFirestore;

  // Future<UserModel> getUser() async {
  //   final CollectionReference user =
  //       _firebaseFirestore.collection(FirebaseConstants.usersCollection);

  //   return user.where('id', isEqualTo: _auth.currentUser!.uid).get().then(
  //         (value) => UserModel.fromMap(
  //           value.docs.first.data() as Map<String, dynamic>,
  //         ),
  //       );
  // }

  Stream<UserModel> getUser() {
    final userRef = _firebaseFirestore
        .collection(FirebaseConstants.usersCollection)
        .doc(_auth.currentUser!.uid);
    final userData = userRef.snapshots();
    return userData.map(
      (docs) => UserModel.fromMap(
        docs.data() as Map<String, dynamic>,
      ),
    );
  }

  Stream<UserModel> getUserForSender(String id) {
    final userRef =
        _firebaseFirestore.collection(FirebaseConstants.usersCollection);

    final userData = userRef.where("id", isEqualTo: id).snapshots();
    return userData.map(
      (query) => UserModel.fromMap(
        query.docs.first.data(),
      ),
    );
  }

  Stream<UserModel> getUserForProperty(String propertyOwnerId) {
    final userRef =
        _firebaseFirestore.collection(FirebaseConstants.usersCollection);
    final userData =
        userRef.where("id", isEqualTo: propertyOwnerId).snapshots();
    return userData.map(
      (query) => UserModel.fromMap(
        query.docs.first.data(),
      ),
    );
  }
}
