// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class Room {
  String lastMessage;
  DateTime lastMessageTime;
  String? roomId;
  List<String> users;

  Room({
    required this.lastMessage,
    required this.lastMessageTime,
    this.roomId,
    required this.users,
  });

  Room copyWith({
    String? lastMessage,
    DateTime? lastMessageTime,
    String? roomId,
    List<String>? users,
  }) {
    return Room(
      lastMessage: lastMessage ?? this.lastMessage,
      lastMessageTime: lastMessageTime ?? this.lastMessageTime,
      roomId: roomId ?? this.roomId,
      users: users ?? this.users,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'lastMessage': lastMessage,
      'lastMessageTime': lastMessageTime,
      'roomId': roomId,
      'users': users,
    };
  }

  factory Room.fromMap(Map<String, dynamic> map) {
    return Room(
        lastMessage: map['lastMessage'] as String,
        lastMessageTime: (map['lastMessageTime'] as Timestamp).toDate(),
        roomId: map['roomId'] as String,
        users: List<String>.from(
          (map['users'] as List<dynamic>),
        ));
  }

  String toJson() => json.encode(toMap());

  factory Room.fromJson(String source) =>
      Room.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Room(lastMessage: $lastMessage, lastMessageTime: $lastMessageTime, roomId: $roomId, users: $users)';
  }

  @override
  bool operator ==(covariant Room other) {
    if (identical(this, other)) return true;

    return other.lastMessage == lastMessage &&
        other.lastMessageTime == lastMessageTime &&
        other.roomId == roomId &&
        listEquals(other.users, users);
  }

  @override
  int get hashCode {
    return lastMessage.hashCode ^
        lastMessageTime.hashCode ^
        roomId.hashCode ^
        users.hashCode;
  }
}

class Message {
  final String message;
  final String sendBy;

  final String propertyId;
  final DateTime timestamp;

  Message({
    required this.message,
    required this.sendBy,
    required this.timestamp,
    required this.propertyId,
  });

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        message: json['message'] as String,
        sendBy: json['sendBy'] as String,
        timestamp: (json['timestamp'] as Timestamp).toDate(),
        propertyId: json['roomId'] as String,
      );

  Map<String, dynamic> toMap() {
    return {
      'message': message,
      'sendBy': sendBy,
      'timestamp': timestamp,
      'roomId': propertyId
    };
  }

  @override
  String toString() {
    return 'Message(message: $message, sendBy: $sendBy,  timestamp: $timestamp)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Message &&
        other.message == message &&
        other.sendBy == sendBy &&
        other.timestamp == timestamp;
  }

  @override
  int get hashCode {
    return message.hashCode ^ sendBy.hashCode ^ timestamp.hashCode;
  }
}
