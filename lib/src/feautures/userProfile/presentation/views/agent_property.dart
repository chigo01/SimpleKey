import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:simple_key/src/core/providers/auth_providers.dart';
import 'package:simple_key/src/core/route/route_navigation.dart';
import 'package:simple_key/src/core/theme/color_pallter.dart';
import 'package:simple_key/src/core/utils/async_widget.dart';
import 'package:simple_key/src/core/utils/extension.dart';
import 'package:simple_key/src/core/widget/arrow_back.dart';
import 'package:simple_key/src/core/widgets/images_caches.dart';
import 'package:simple_key/src/feautures/Home%20Screen/presentation/views/read_more.dart';
import 'package:simple_key/src/feautures/message/data/provider/message.dart';
import 'package:simple_key/src/feautures/message/presentation/views/chat_screen.dart';
import 'package:simple_key/src/feautures/propertyPost/data/controller/provider/property_repo.dart';
import 'package:simple_key/src/feautures/userProfile/data/controller/providers/providers.dart';
import 'package:simple_key/src/model/message.dart';
import 'package:simple_key/src/model/product_model.dart';

class AgentProfile extends HookConsumerWidget {
  const AgentProfile(this.id, {super.key, required this.agent});
  final String id;
  final AgentProperty agent;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(getUserForProperty(id));
    final agentProperty = ref.watch(getAllPropertyByAgent(id));
    final agentListings = agentProperty.valueOrNull?.length;
    final currentUser = ref.watch(firebaseAuthProvider).currentUser?.uid;

    //final chats = ref.watch(getSubCollectionRooms).value;
    return Scaffold(
      appBar: AppBar(
        leading: const ArrowBack(),
        title: Text(
          'Agent Profile',
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: AsyncWidget(
        asyncValue: user,
        data: (userId) {
          return SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 10),
                Container(
                  height: 475,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 15.0, vertical: 15),
                  margin: const EdgeInsets.symmetric(horizontal: 20.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset:
                            const Offset(0, 3), // changes position of shadow
                      ),
                    ],
                    color: Colors.white,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        leading: Container(
                          height: 60,
                          width: 70,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: ImageCaches(imageUrl: userId.image ?? ''),
                          ),
                        ),
                        title: Text(
                          userId.userName,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        subtitle: Row(
                          children: [
                            PhosphorIcon(PhosphorIcons.bold.mapPin, size: 15),
                            const SizedBox(width: 5),
                            Text(userId.location ?? '',
                                style: Theme.of(context).textTheme.labelMedium),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Information',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.copyWith(fontSize: 15),
                            ),
                            const SizedBox(height: 15),
                            Row(
                              children: [
                                CircleAvatar(
                                  radius: 15,
                                  backgroundColor: Theme.of(context)
                                      .primaryColor
                                      .withOpacity(0.3),
                                  child: PhosphorIcon(
                                    PhosphorIcons.fill.phoneCall,
                                    color: Theme.of(context).primaryColor,
                                    size: 15,
                                  ),
                                ),
                                const SizedBox(width: 5),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    userId.phone ?? '',
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelMedium
                                        ?.copyWith(
                                          fontSize: 13,
                                          color: Theme.of(context).primaryColor,
                                        ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 15),
                            Row(
                              children: [
                                CircleAvatar(
                                  radius: 15,
                                  backgroundColor: Theme.of(context)
                                      .primaryColor
                                      .withOpacity(0.3),
                                  child: PhosphorIcon(
                                    PhosphorIcons.fill.envelope,
                                    color: Theme.of(context).primaryColor,
                                    size: 15,
                                  ),
                                ),
                                const SizedBox(width: 5),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    userId.email,
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelMedium
                                        ?.copyWith(
                                          fontSize: 13,
                                          color: Theme.of(context).primaryColor,
                                        ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 15),
                            Row(
                              children: [
                                CircleAvatar(
                                  radius: 15,
                                  backgroundColor: Theme.of(context)
                                      .primaryColor
                                      .withOpacity(0.3),
                                  child: PhosphorIcon(
                                    PhosphorIcons.fill.house,
                                    color: Theme.of(context).primaryColor,
                                    size: 15,
                                  ),
                                ),
                                const SizedBox(width: 5),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    '$agentListings Listings',
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelMedium
                                        ?.copyWith(
                                          fontSize: 13,
                                          fontWeight: FontWeight.bold,
                                          color: Theme.of(context).primaryColor,
                                        ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Text(
                              'About me',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.copyWith(fontSize: 15),
                            ),
                            const SizedBox(height: 15),
                            SingleChildScrollView(
                              child: ReadMoreText(
                                userId.description ?? '',
                                trimLines: 3,
                                colorClickableText: Colors.pink,
                                trimMode: TrimMode.Line,
                                trimCollapsedText: "....show more",
                                trimExpandedText: ".....show less",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                            ),
                            const SizedBox(height: 70),
                            if (currentUser != id)
                              Align(
                                alignment: Alignment.center,
                                child: Container(
                                  height: 50,
                                  width: 200,
                                  decoration: BoxDecoration(
                                    gradient: gradient(),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: const Center(
                                    child: Text(
                                      'Contact Agent',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ).onTap(() {
                                  context.pushTransition(
                                    ChatScreen(
                                      agent: agent,
                                      nav: false,
                                    ),
                                  );

                                  final room = Room(
                                    lastMessage: '',
                                    lastMessageTime: DateTime.now(),
                                    roomId: agent.propertyId,
                                    users: [
                                      currentUser!,
                                      agent.propertyOwnerId
                                    ],
                                    // agent: agent,
                                  );
                                  ref
                                      .read(messageRepositoryProvider.notifier)
                                      .createRoom(agent.propertyId, room);
                                }),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Agent Listings',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor,
                      ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: AsyncWidget(
                    asyncValue: agentProperty,
                    data: (listing) {
                      return SizedBox(
                        height: 250,
                        width: double.infinity,
                        child: ListView.builder(
                          itemCount: listing.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (BuildContext context, int index) {
                            final agentList = listing[index];
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height: 250,
                                width: 230,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white,
                                ),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: SizedBox(
                                        height: 130,
                                        width: double.infinity,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: ImageCaches(
                                            imageUrl:
                                                agentList.propertyImages[0],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        agentList.propertyName,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleLarge
                                            ?.copyWith(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                              color: Theme.of(context)
                                                  .primaryColor,
                                            ),
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Text(
                                        agentList.propertyLocation,
                                        maxLines: 2,
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelMedium
                                            ?.copyWith(
                                              fontSize: 14,
                                              color: Colors.grey,
                                            ),
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Text(
                                        NumberFormat.currency(
                                                symbol: "₦ ", decimalDigits: 0)
                                            .format(
                                          agentList.propertyPrice,
                                        ),
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelMedium
                                            ?.copyWith(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: Theme.of(context)
                                                  .primaryColor,
                                            ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
