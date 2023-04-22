import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:simple_key/src/core/providers/auth_providers.dart';
import 'package:simple_key/src/core/route/route_navigation.dart';
import 'package:simple_key/src/core/utils/extension.dart';
import 'package:simple_key/src/core/widget/menu_widget.dart';
import 'package:simple_key/src/core/widgets/images_caches.dart';
import 'package:simple_key/src/feautures/message/data/provider/message.dart';
import 'package:simple_key/src/feautures/message/presentation/views/chat_screen.dart';
import 'package:simple_key/src/feautures/propertyPost/data/controller/provider/property_repo.dart';
import 'package:simple_key/src/feautures/userProfile/data/controller/providers/providers.dart';

class MessagePreview extends HookConsumerWidget {
  const MessagePreview({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUser = ref.watch(firebaseAuthProvider).currentUser?.uid;
    final message = ref.watch(getSubCollectionStream).valueOrNull;

    final chats = ref
        .watch(getSubCollectionRooms)
        .value
        ?.where((element) => element.users.contains(currentUser))
        .toList();

    chats?.sort(((a, b) => a.lastMessageTime.compareTo(b.lastMessageTime)));

    final chat = chats?.reversed.toList();

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
          itemCount: chat
              ?.length, //newWChats.length, //allUserReceivedMessage?.length ?? 0,
          itemBuilder: (BuildContext context, int index) {
            final room = chat?[index];
            final user =
                room?.users.firstWhere((element) => element != currentUser);
            final property =
                ref.watch(getProperty(room?.roomId ?? "")).valueOrNull;

            final users = ref.watch(getAllUser(user ?? "")).valueOrNull;

            // final user = ref.watch(getAllUser(room?.users.first));
            return Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8),
              child: Container(
                height: 85,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 4,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      SizedBox(
                        height: 70,
                        width: 70,
                        child: ClipOval(
                            child: ImageCaches(
                                imageUrl: users?.image ??
                                    "") //"https://picsum.photos/250?image=9"),
                            ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        flex: 2,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Container(
                              height: 70,
                              width: 200,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    users?.userName ?? "",
                                    style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(height: 5),
                                  Expanded(
                                    child: Text(
                                      room?.lastMessage ?? "",
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontSize: 13,
                                          color:
                                              Theme.of(context).primaryColor),
                                    ),
                                  ),
                                ],
                              )),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: SizedBox(
                          height: 70,
                          width: 200,
                          //  color: Colors.white,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                property?.propertyName ?? "",
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Theme.of(context).primaryColor,
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FontStyle.italic),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ).onTap(
              () => context.pushTransition(
                ChatScreen(
                  // agent: agent!,
                  id: room?.id ?? "",
                  //  nav: true,
                  // roomId: room?.roomId ?? "",
                ),
              ),
            );
          }),
    );
  }
}
