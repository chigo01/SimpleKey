import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:simple_key/src/core/providers/auth_providers.dart';
import 'package:simple_key/src/core/theme/color_pallter.dart';
import 'package:simple_key/src/core/utils/async_widget.dart';
import 'package:simple_key/src/core/utils/extension.dart';
import 'package:simple_key/src/core/widget/arrow_back.dart';
import 'package:simple_key/src/core/widgets/images_caches.dart';
import 'package:simple_key/src/feautures/message/data/provider/message.dart';
import 'package:simple_key/src/feautures/propertyPost/data/controller/provider/property_repo.dart';
import 'package:simple_key/src/model/message.dart';
import 'package:simple_key/src/model/product_model.dart';

final roomId = StateProvider<String>((ref) => '');

class ChatScreen extends HookConsumerWidget {
  const ChatScreen({super.key, this.agent, this.id, required this.nav});
  final AgentProperty? agent;
  final String? id;
  final bool nav;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final agent! = ref.watch(agentProperties);
    final user = ref.watch(firebaseAuthProvider).currentUser?.uid;
    //  final User? user1;

    TextEditingController messageController = useTextEditingController();
    final property = ref.watch(getProperty(id ?? "")).valueOrNull;
    //  final id = ref.watch(roomId);
    final agentRoom = ref.watch(
      getSubCollectionRoom(
        agent?.propertyId ?? "",
      ),
    );
    final room = ref.watch(getSubCollectionRoom(property?.propertyId ?? ""));
    final getRoo = ref.watch(getRoom(property?.propertyId ?? "")).valueOrNull;
    final agentRoo = ref.watch(getRoom(agent?.propertyId ?? "")).valueOrNull;

    final message = ref.watch(getSubcollectionStream);
    //   final agentRoom = ref.watch(getSubCollectionRoom(nav?property?.propertyId ?? "":agent!.propertyId));
    final agentFilterRoom = agentRoom.valueOrNull
        ?.where((element) =>
            element.users.contains(agent!.propertyOwnerId) &&
            element.users.contains(user) &&
            element.roomId == agent!.propertyId)
        .toList();

    final filterRoom = room.valueOrNull
        ?.where((element) =>
            element.users.contains(property?.propertyOwnerId) &&
            element.users.contains(user) &&
            element.roomId == property?.propertyId)
        .toList();

    print('firete $filterRoom');
    //print('helll ${filterRoom?[0].roomId}');
    print('property, $property');
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: 100,
              color: Colors.white,
              child: Column(
                children: [
                  Row(
                    children: [
                      const ArrowBack(),
                      const SizedBox(width: 40),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Row(
                          children: [
                            Container(
                              height: 70,
                              width: 70,
                              decoration:
                                  const BoxDecoration(shape: BoxShape.circle),
                              child: ClipOval(
                                child: ImageCaches(
                                    imageUrl: nav
                                        ? property?.agentProfileImage ?? ""
                                        : agent?.agentProfileImage ?? ""),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              nav
                                  ? property?.propertyName ?? ""
                                  : agent?.propertyOwnerName ?? "",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Container(
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: Row(
                  children: [
                    Container(
                      height: 80,
                      width: 80,
                      padding: const EdgeInsets.all(10),
                      margin: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          //shape: BoxShape.circle,
                          borderRadius: BorderRadius.circular(10),
                          color:
                              Theme.of(context).primaryColor.withOpacity(0.2)),
                      child: ImageCaches(
                        imageUrl: nav
                            ? property?.propertyImages[0] ?? ""
                            : agent?.propertyImages[0] ?? "",
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      child: Column(
                        children: [
                          Text(
                            nav
                                ? property?.propertyName ?? ""
                                : agent?.propertyName ?? "",
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15),
                          ),
                          Text(
                            'Type: ${nav ? property?.propertyType ?? "" : agent?.propertyType ?? ""}',
                            style:
                                Theme.of(context).textTheme.bodySmall?.copyWith(
                                      color: Colors.grey,
                                      fontSize: 14,
                                    ),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(right: 20.0),
                      child: Text(
                        NumberFormat.currency(symbol: "₦ ", decimalDigits: 0)
                            .format(
                          nav
                              ? property?.propertyPrice ?? 0.0
                              : agent?.propertyPrice ?? 0.0,
                        ),
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            //stop
            Expanded(
              child: SizedBox(
                height: 450,
                // child: room.valueOrNull?.first.users.isNotEmpty ?? false
                //     ? const Center(
                //         child: Text('No message'),
                //       )
                child: (nav
                        ? filterRoom?.isEmpty ?? false
                        : agentFilterRoom?.isEmpty ?? false)
                    ? const SizedBox()
                    : AsyncWidget(
                        asyncValue: message,
                        data: (data) {
                          data.sort(
                              (a, b) => a.timestamp.compareTo(b.timestamp));
                          final allData = nav
                              ? data.reversed
                                  .where((element) =>
                                      element.propertyId ==
                                      filterRoom?.last.roomId)
                                  .toList()
                              : data.reversed
                                  .where(
                                    (element) =>
                                        element.propertyId ==
                                        agentFilterRoom?.last.roomId,
                                  )
                                  .toList();

                          // final agentAllData = data.reversed
                          //     .where(
                          //       (element) =>
                          //           element.propertyId ==
                          //           agentFilterRoom?.last.roomId,
                          //     )
                          //     .toList();

                          // print('alldata $agentAllData');

                          return allData.isEmpty
                              ? const SizedBox()
                              : ListView.builder(
                                  reverse: true,
                                  itemCount: allData.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    final Message chat =
                                        nav ? allData[index] : data[index];

                                    return (nav
                                            ? allData.isEmpty
                                            : allData.isEmpty)
                                        ? const SizedBox()
                                        : chat.sendBy == user
                                            ? Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Align(
                                                  alignment: Alignment.topRight,
                                                  child: Container(
                                                    width: 250,
                                                    decoration: BoxDecoration(
                                                      gradient: gradient(),
                                                      borderRadius:
                                                          const BorderRadius
                                                              .only(
                                                        topLeft:
                                                            Radius.circular(10),
                                                        bottomLeft:
                                                            Radius.circular(10),
                                                        bottomRight:
                                                            Radius.circular(15),
                                                      ),
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              10.0),
                                                      child: Text(
                                                        allData[index].message,
                                                        style: const TextStyle(
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              )
                                            : Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Align(
                                                  alignment: Alignment.topLeft,
                                                  child: Container(
                                                    width: 250,
                                                    decoration:
                                                        const BoxDecoration(
                                                      color: Colors.white38,
                                                      borderRadius:
                                                          BorderRadius.only(
                                                        topLeft:
                                                            Radius.circular(10),
                                                        bottomLeft:
                                                            Radius.circular(10),
                                                        bottomRight:
                                                            Radius.circular(15),
                                                      ),
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              10.0),
                                                      child: Text(
                                                        chat.message,
                                                        style: TextStyle(
                                                            color: Theme.of(
                                                                    context)
                                                                .primaryColor),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              );
                                  },
                                );
                        },
                      ),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
              child: SizedBox(
                width: context.width * 0.75,
                height: 70,
                child: TextField(
                  maxLines: 2,
                  controller: messageController,
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    hintText: 'Type Something....',
                    hintStyle: TextStyle(
                      fontSize: 12,
                      color: Theme.of(context).primaryColor,
                    ),
                    suffixIcon: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          gradient: gradient(),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: PhosphorIcon(
                          PhosphorIcons.fill.paperPlaneTilt,
                          color: Colors.white,
                        ),
                      ).onTap(() {
                        final message = Message(
                          message: messageController.text,
                          sendBy: user ?? '',
                          timestamp: DateTime.now(),
                          propertyId: nav
                              ? property?.propertyId ?? ""
                              : agent?.propertyId ?? "",
                        );

                        final room1 = Room(
                          lastMessage: messageController.text,
                          lastMessageTime: DateTime.now(),
                          roomId: nav
                              ? property?.propertyId ?? ""
                              : agent?.propertyId ?? "",
                          // users: [
                          //   user ?? '',
                          //   nav
                          //       ? property?.propertyOwnerId ?? "hello"
                          //       : agent?.propertyOwnerId ?? "booo"
                          //   // nav
                          //   //     ? property?.propertyOwnerId ?? ''
                          //   //     : agent!.propertyOwnerId,
                          // ],
                          users: nav ? getRoo!.users : agentRoo!.users,
                        );

                        ref
                            .read(messageRepositoryProvider.notifier)
                            .sendMessage(
                                roomId: nav
                                    ? property?.propertyId ?? ""
                                    : agent?.propertyId ?? "",
                                //  roomId: getRoo.valueOrNull?.roomId,
                                room: room1,
                                message: message,
                                updateRoom: Room(
                                  lastMessage: messageController.text,
                                  lastMessageTime: DateTime.now(),
                                  users: nav ? getRoo!.users : agentRoo!.users,
                                  // users: [
                                  //   user ?? '',
                                  //   agent?.propertyOwnerId ?? ""
                                  // ],
                                  roomId: nav
                                      ? property?.propertyId ?? ""
                                      : agent?.propertyId ?? "",
                                  //     agent!: agent!,
                                ));

                        messageController.clear();
                      }),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
