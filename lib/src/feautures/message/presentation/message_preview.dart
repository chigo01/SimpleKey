import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:simple_key/src/core/providers/auth_providers.dart';
import 'package:simple_key/src/core/route/route_navigation.dart';
import 'package:simple_key/src/core/utils/extension.dart';
import 'package:simple_key/src/core/widget/menu_widget.dart';
import 'package:simple_key/src/core/widgets/images_caches.dart';
import 'package:simple_key/src/feautures/Home%20Screen/presentation/views/PropertyDetailedScreen.dart';
import 'package:simple_key/src/feautures/message/data/provider/message.dart';
import 'package:simple_key/src/feautures/message/presentation/views/chat_screen.dart';
import 'package:simple_key/src/feautures/userProfile/data/controller/providers/providers.dart';

class MessagePreview extends HookConsumerWidget {
  const MessagePreview({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List newWChats = [];
    List newMessages = [];
    final propery = ref.watch(agentProperties);
    final currentUser = ref.watch(firebaseAuthProvider).currentUser?.uid;
    final message = ref.watch(getSubcollectionStream).valueOrNull;

    final chats = ref
        .watch(getSubCollectionRooms)
        .value
        ?.where((element) => element.users.contains(currentUser))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Messages",
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontSize: 15,
          ),
        ),
        leading: const MenuWidget(),
      ),
      body: ListView.builder(
          itemCount: chats
              ?.length, //newWChats.length, //allUserReceivedMessage?.length ?? 0,
          itemBuilder: (BuildContext context, int index) {
            final room = chats?[index];
            // final user = ref.watch(getUser)

            // final agent =
            //     ref.watch(getProperty(chats?[index].roomId ?? '')).valueOrNull;

            // final msg = message
            //     ?.where((element) => element.propertyId == room?.roomId)
            //     .first;

            print('mes ${room?.roomId}');
//
            return Padding(
              padding: const EdgeInsets.all(12.0),
              child: SizedBox(
                height: 80,
                child: Row(
                  children: [
                    const SizedBox(
                      height: 70,
                      width: 70,
                      child: ClipOval(
                          child: ImageCaches(
                              imageUrl:
                                  "https://picsum.photos/250?image=9") //"https://picsum.photos/250?image=9"),
                          ),
                    ),
                    const SizedBox(width: 10),
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Container(
                          height: 70,
                          width: 200,
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "",
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                room?.lastMessage ?? "",
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Theme.of(context).primaryColor),
                              ),
                            ],
                          )),
                    )
                  ],
                ),
              ),
            ).onTap(
              () => context.pushTransition(
                ChatScreen(
                  // agent: agent!,
                  id: room?.roomId ?? "",
                  nav: true,
                ),
              ),
            );
          }),
    );
  }
}
