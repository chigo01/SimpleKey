import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:simple_key/src/core/constant/firebase_constant.dart';
import 'package:simple_key/src/model/message.dart';

class MessageRepository {
  final FirebaseAuth _auth;
  final FirebaseFirestore _fireStore;

  MessageRepository({
    required FirebaseAuth auth,
    required FirebaseFirestore firestore,
  })  : _auth = auth,
        _fireStore = firestore;

  Future<void> postChatMessage(Message chat) async {
    _fireStore.collection(FirebaseConstants.chatsCollection).add(
          chat.toMap(),
        );
  }

  Future<void> createRoom(String id, Room room) async {
    _fireStore
        .collection(FirebaseConstants.roomsCollection)
        .doc(id)
        .set(room.toMap());
  }

  Future<void> sendMessage({
    required String? roomId,
    required Room room,
    required Message message,
    required Room update,
  }) async {
    if (roomId != null) {
      _fireStore
          .collection(FirebaseConstants.roomsCollection)
          .doc(roomId)
          .update(update.toMap());
      _fireStore
          .collection(FirebaseConstants.roomsCollection)
          .doc(roomId)
          .collection(FirebaseConstants.chatsCollection)
          .add(message.toMap());
    } else {
      _fireStore
          .collection(FirebaseConstants.roomsCollection)
          .add(room.toMap())
          .then(
        (value) async {
          value
              .collection(FirebaseConstants.chatsCollection)
              .add(message.toMap());
        },
      );
    }
  }

  Stream<List<Message>> getSubCollectionStream() {
    final snapshots = FirebaseFirestore.instance
        .collectionGroup(FirebaseConstants.chatsCollection)
        // .orderBy('timestamp', descending: true)
        .snapshots();
    return snapshots.map(
      (querySnapshot) => querySnapshot.docs
          .map(
            (e) => Message.fromJson(
              e.data(),
            ),
          )
          .toList(),
    );
  }

  Stream<List<Room>> getSubCollectionRoom(String roomId) {
    final snapshots = FirebaseFirestore.instance
        .collectionGroup(FirebaseConstants.roomsCollection)
        .where('roomId', isEqualTo: roomId)
        .orderBy('lastMessageTime', descending: true)
        .snapshots();
    return snapshots.map(
      (querySnapshot) => querySnapshot.docs
          .map(
            (e) => Room.fromMap(
              e.data(),
            ),
          )
          .toList(),
    );
  }

  Stream<List<Room>> getSubCollectionRooms() {
    final snapshots = FirebaseFirestore.instance
        .collectionGroup(FirebaseConstants.roomsCollection)
        // .orderBy('lastMessageTime', descending: true)
        .snapshots();
    return snapshots.map(
      (querySnapshot) => querySnapshot.docs
          .map(
            (e) => Room.fromMap(
              e.data(),
            ),
          )
          .toList(),
    );
  }

  Stream<Room> getRoom(String roomId) {
    return _fireStore
        .collectionGroup(FirebaseConstants.roomsCollection)
        .where("roomId", isEqualTo: roomId)
        .orderBy('lastMessageTime', descending: true)
        .snapshots()
        .map((event) => Room.fromMap(event.docs.first.data()));
  }

  Stream<List<Message>> getChatMessagesForRoom(String roomId) {
    return _fireStore
        .collection(FirebaseConstants.roomsCollection)
        .doc(roomId)
        .collection(FirebaseConstants.chatsCollection)
        .orderBy('lastMessageTime', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map(
              (doc) => Message.fromJson(
                doc.data(),
              ),
            )
            .toList());
  }

  Stream<List<Message>> getChatMessages() {
    return _fireStore
        .collection(FirebaseConstants.chatsCollection)
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map(
              (doc) => Message.fromJson(
                doc.data(),
              ),
            )
            .toList());
  }
}
