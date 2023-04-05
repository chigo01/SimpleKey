import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:simple_key/src/core/providers/auth_providers.dart';
import 'package:simple_key/src/feautures/message/data/notifers/message_notifier.dart';
import 'package:simple_key/src/feautures/message/data/repositoy/message_repo.dart';
import 'package:simple_key/src/model/message.dart';

final messageRepository = Provider(
  (ref) => MessageRepository(
    auth: ref.watch(firebaseAuthProvider),
    firestore: ref.watch(fireStoreProvider),
  ),
);

final postChat = FutureProvider.family<void, Message>(
  (ref, chat) => ref.watch(messageRepository).postChatMessage(chat),
);

final getChatMessages =
    StreamProvider.family<List<Message>, String>((ref, roomId) async* {
  yield* ref.watch(messageRepository).getChatMessagesForRoom(roomId);
});

final getChatMessages1 = StreamProvider((ref) async* {
  yield* ref.watch(messageRepository).getChatMessages();
});

final messageRepositoryProvider = AsyncNotifierProvider(
  () => MessageNotifier(),
);

final getRoom = StreamProvider.family<Room, String>((ref, roomId) async* {
  yield* ref.watch(messageRepository).getRoom(roomId);
});

final getSubcollectionStream = StreamProvider((ref) async* {
  yield* ref.watch(messageRepository).getSubcollectionStream();
});

final getSubCollectionRoom =
    StreamProvider.family<List<Room>, String>((ref, roomId) async* {
  yield* ref.watch(messageRepository).getSubCollectionRoom(roomId);
});

final getSubCollectionRooms = StreamProvider(
  (ref) => ref.watch(messageRepository).getSubCollectionRooms(),
);




 

// final getChatMessagesForReceiver = StreamProvider.family<List<Message>, String>(
//   (ref, receiverId) =>
//       ref.watch(messageRepository).getChatMessagesForReceiver(receiverId),
// );
