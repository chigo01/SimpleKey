import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:ntp/ntp.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:simple_key/src/core/providers/auth_providers.dart';
import 'package:simple_key/src/core/theme/color_pallter.dart';
import 'package:simple_key/src/core/utils/async_widget.dart';
import 'package:simple_key/src/core/utils/extension.dart';
import 'package:simple_key/src/core/widget/arrow_back.dart';
import 'package:simple_key/src/core/widgets/images_caches.dart';
import 'package:simple_key/src/feautures/message/data/provider/message.dart';
import 'package:simple_key/src/feautures/propertyPost/data/controller/provider/property_repo.dart';
import 'package:simple_key/src/feautures/userProfile/data/controller/providers/providers.dart';
import 'package:simple_key/src/model/message.dart';
import 'package:simple_key/src/model/product_model.dart';

final roomId = StateProvider<String>((ref) => '');

class ChatScreen extends HookConsumerWidget {
  const ChatScreen({
    super.key,
    // this.agent,
    this.id,
  });
  // final AgentProperty? agent;
  final String? id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final agent! = ref.watch(agentProperties);
    final currentUser = ref.watch(firebaseAuthProvider).currentUser?.uid;
    //  final User? user1;

    TextEditingController messageController = useTextEditingController();

    final agentRoom = ref.watch(getRoom(id ?? "")).valueOrNull;
    final property =
        ref.watch(getProperty(agentRoom?.roomId ?? "")).valueOrNull;

    final user =
        agentRoom?.users.firstWhere((element) => element != currentUser);

    final users = ref.watch(getAllUser(user ?? "")).valueOrNull;

    final message = ref.watch(getSubCollectionStream);

    final roomId =
        '${property?.propertyId}-${agentRoom?.users[0]}-${property?.propertyOwnerId}';

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
                                    imageUrl: users?.image ??
                                        "" /*nav
                                        ? property?.agentProfileImage ?? ""
                                        : agent?.agentProfileImage ?? ""*/
                                    ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              users?.userName ?? "",
                              /* nav
                                  ? property?.propertyOwnerName ?? ""
                                  : agent?.propertyOwnerName ?? ""*/
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
                          imageUrl: property?.propertyImages[0] ?? ""),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      child: Column(
                        children: [
                          Text(
                            property?.propertyName ?? "",
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15),
                          ),
                          Text(
                            'Type: ${property?.propertyType ?? ""}',
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
                            .format(property?.propertyPrice ?? 0.0),
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
                child: (agentRoom?.isNull ?? false)
                    ? const SizedBox()
                    : AsyncWidget(
                        asyncValue: message,
                        data: (data) {
                          data.sort(
                              (a, b) => a.timestamp.compareTo(b.timestamp));
                          final allData = data.reversed
                              .where((element) => element.propertyId == id)
                              .toList();

                          return (allData.isEmpty)
                              ? const SizedBox()
                              : ListView.builder(
                                  reverse: true,
                                  itemCount: allData.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    final Message chat = allData[index];
                                    final bool sentBy = chat.sendBy == user;

                                    return (allData.isEmpty)
                                        ? const SizedBox()
                                        : Padding(
                                            padding: const EdgeInsets.all(12.0),
                                            child: Align(
                                              alignment: sentBy
                                                  ? Alignment.topRight
                                                  : Alignment.topLeft,
                                              child: Column(
                                                children: [
                                                  Container(
                                                    width: 250,
                                                    decoration: BoxDecoration(
                                                      color: sentBy
                                                          ? null
                                                          : Colors.white38,
                                                      gradient: sentBy
                                                          ? gradient()
                                                          : null,
                                                      borderRadius: sentBy
                                                          ? const BorderRadius
                                                              .only(
                                                              topLeft: Radius
                                                                  .circular(10),
                                                              bottomLeft: Radius
                                                                  .circular(10),
                                                              bottomRight:
                                                                  Radius
                                                                      .circular(
                                                                          15),
                                                            )
                                                          : const BorderRadius
                                                              .only(
                                                              topLeft: Radius
                                                                  .circular(10),
                                                              bottomLeft: Radius
                                                                  .circular(10),
                                                              bottomRight:
                                                                  Radius
                                                                      .circular(
                                                                          15),
                                                            ),
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              10.0),
                                                      child: Row(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        textBaseline:
                                                            TextBaseline
                                                                .ideographic,
                                                        children: [
                                                          Expanded(
                                                            child: Text(
                                                              allData[index]
                                                                  .message,
                                                              style: TextStyle(
                                                                color: sentBy
                                                                    ? Colors
                                                                        .white
                                                                    : Theme.of(
                                                                            context)
                                                                        .primaryColor,
                                                              ),
                                                            ),
                                                          ),
                                                          Align(
                                                            alignment: Alignment
                                                                .bottomRight,
                                                            child: Text(
                                                              ' ${DateFormat('hh:mm a').format(allData[index].timestamp)}',
                                                              style: TextStyle(
                                                                color: sentBy
                                                                    ? Colors
                                                                        .white
                                                                    : Theme.of(
                                                                            context)
                                                                        .primaryColor,
                                                                fontSize: 10,
                                                              ),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(height: 5),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        left: sentBy
                                                            ? 150.0
                                                            : 0.0,
                                                        right: sentBy
                                                            ? 0.0
                                                            : 150.0),
                                                    child: Text(
                                                      ' ${DateFormat('dd MMMM yyyy').format(allData[index].timestamp)}',
                                                      style: const TextStyle(
                                                          // color: Colors.white,
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                ],
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
                height: 80,
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
                      ).onTap(() async {
                        final message = Message(
                            message: messageController.text,
                            sendBy: user ?? '',
                            timestamp: await NTP.now(),
                            propertyId: roomId);

                        final room1 = Room(
                          lastMessage: messageController.text,
                          lastMessageTime: DateTime.now(),
                          roomId: property?.propertyId ?? "",
                          id: roomId,
                          users: agentRoom?.users ?? [],
                        );

                        ref
                            .read(messageRepositoryProvider.notifier)
                            .sendMessage(
                              roomId: roomId,
                              //  roomId: getRoo.valueOrNull?.roomId,
                              room: room1,
                              message: message,
                              updateRoom: Room(
                                  lastMessage: messageController.text,
                                  lastMessageTime: DateTime.now(),
                                  users: agentRoom?.users ?? [],
                                  roomId: '${property?.propertyId}',
                                  id: roomId
                                  //     agent!: agent!,
                                  ),
                            );

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
