import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:simple_key/src/feautures/message/data/provider/message.dart';
import 'package:simple_key/src/feautures/message/data/repositoy/message_repo.dart';
import 'package:simple_key/src/model/message.dart';

class MessageNotifier extends AsyncNotifier {
  @override
  FutureOr build() {
    // TODO: implement build
    throw UnimplementedError();
  }

  Future<void> sendMessage({
    required String roomId,
    required Room room,
    required Message message,
    required Room updateRoom,
  }) async {
    final chat = ref.watch(messageRepository);
    return await chat.sendMessage(
      roomId: roomId,
      room: room,
      message: message,
      update: updateRoom,
    );
  }

  Future<void> createRoom(String id, Room room) async {
    final chat = ref.watch(messageRepository);
    return await chat.createRoom(id, room);
  }
}
