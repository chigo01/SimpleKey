import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:simple_key/src/core/constant/firebase_constant.dart';
import 'package:simple_key/src/core/utils/cam.dart';
import 'package:simple_key/src/model/product_model.dart';
import 'package:path/path.dart' as path;

class PropertyRepository {
  final FirebaseFirestore _fireStore;
  final FirebaseStorage _firebaseStorage;
  final FirebaseAuth _user;

  PropertyRepository(
    FirebaseFirestore fireStore,
    FirebaseStorage firebaseStorage,
    FirebaseAuth user,
  )   : _fireStore = fireStore,
        _firebaseStorage = firebaseStorage,
        _user = user;

  CollectionReference get _properties =>
      _fireStore.collection(FirebaseConstants.propertiesCollection);

  Future<void> postProperty(AgentProperty property) async {
    _properties.doc().set(
          property.toMap(),
        );
  }

  Future<void> uploadImages(WidgetRef ref, List<String> newImages) async {
    final imagesPicked = ref.watch(imagePaths);

    if (imagesPicked.isNotEmpty) {
      for (var images in imagesPicked) {
        Reference reference =
            _firebaseStorage.ref().child('property/${path.basename(images)}');
        await reference.putFile(File(images)).whenComplete(
          () async {
            await reference.getDownloadURL().then(
                  (value) => newImages.add(value),
                );
          },
        );
      }
    }
  }

  Stream<List<AgentProperty>> getAllProperties() {
    return _fireStore
        .collection(FirebaseConstants.propertiesCollection)
        .orderBy('createdAt', descending: true)
        .limit(4)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map(
                (doc) => AgentProperty.fromMap(
                  doc.data(),
                ),
              )
              .toList(),
        );
  }

  Stream<List<AgentProperty>> getRecentlyPostedPropertyByCategory(
      String category) {
    return _fireStore
        .collection(FirebaseConstants.propertiesCollection)
        .orderBy('createdAt', descending: true)
        .where('propertyType', isEqualTo: category)
        .limit(4)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map(
                (doc) => AgentProperty.fromMap(
                  doc.data(),
                ),
              )
              .toList(),
        );
  }

  Stream<List<AgentProperty>> getAllPropertyByCategory(String category) {
    return _fireStore
        .collection(FirebaseConstants.propertiesCollection)
        .orderBy('createdAt', descending: true)
        .where('propertyType', isEqualTo: category)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map(
                (doc) => AgentProperty.fromMap(
                  doc.data(),
                ),
              )
              .toList(),
        );
  }

  Stream<List<AgentProperty>> getAllPropertyByAgent(String id) {
    return _fireStore
        .collection(FirebaseConstants.propertiesCollection)
        .orderBy('createdAt', descending: true)
        .where('propertyOwnerId', isEqualTo: id)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map(
                (doc) => AgentProperty.fromMap(
                  doc.data(),
                ),
              )
              .toList(),
        );
  }
}
