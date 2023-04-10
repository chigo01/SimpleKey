import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:simple_key/src/core/route/route_navigation.dart';
import 'package:simple_key/src/core/utils/async_widget.dart';
import 'package:simple_key/src/core/utils/extension.dart';
import 'package:simple_key/src/core/widgets/images_caches.dart';
import 'package:simple_key/src/core/widgets/notfound.dart';
import 'package:simple_key/src/feautures/propertyPost/data/controller/provider/property_repo.dart';
import 'package:simple_key/src/feautures/userProfile/data/controller/providers/providers.dart';

import '../../../screens/all_nearby.dart';
import '../../../screens/recent_posted.dart';
import '../PropertyDetailedScreen.dart';

final categoryName = StateProvider((ref) => 'House');
List<IconData> icon = [
  Icons.king_bed_sharp,
  Icons.bathtub_sharp,
  Icons.landscape_sharp,
];

class TabBody extends StatelessWidget {
  const TabBody({
    super.key,
    // required this.propertiesValues,
  });

//  final AsyncValue<List<AgentProperty>> propertiesValues;

  @override
  Widget build(
    BuildContext context,
  ) {
    return Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? child) {
        final category = ref.watch(categoryName);
        final propertiesValues =
            ref.watch(getRecentPropertyByCategory(category));

        final user = ref.watch(getUser).valueOrNull;
        List<String> userList = user?.location?.trim().split(',') ?? [];

        final nearby = propertiesValues.value?.where((property) {
          return userList.any(
            (element) =>
                property.propertyLocation.trim().split(',').contains(element),
          );
        }).toList();
        return SingleChildScrollView(
          child: SizedBox(
            height: context.height * 0.67,
            width: context.width,
            // color: Colors.red,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Recently Posted',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          context.push(
                            ALLProperty(
                              category: category,
                            ),
                          );
                        },
                        child: Text(
                          'View all',
                          style:
                              TextStyle(color: Theme.of(context).primaryColor),
                        ),
                      ),
                    ],
                  ),
                ),
                AsyncWidget(
                    asyncValue: propertiesValues,
                    data: (properties) => Padding(
                        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                        child: SizedBox(
                          height: context.height * 0.38,
                          width: context.width,
                          child: properties.isEmpty
                              ? NotFoundWidget(
                                  getNotFound:
                                      '${ref.watch(categoryName)} properties have not been posted yet ')
                              : ListView.builder(
                                  itemCount: properties.length,
                                  scrollDirection: Axis.horizontal,
                                  physics: const BouncingScrollPhysics(),
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    final element = properties[index];
                                    String getCircularItems(int indexAt) {
                                      return {
                                            0: "${element.numberOfRooms}",
                                            1: "${element.numberOfBathrooms}",
                                            2: "${element.meters} sqft",
                                          }[indexAt] ??
                                          '';
                                    }

                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        height: 240,
                                        width: 280,
                                        //color: Colors.white,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          color: Colors.white,
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Column(
                                            children: [
                                              Expanded(
                                                flex: 4,
                                                child: SizedBox(
                                                  height: 200,
                                                  width: 280,
                                                  // color: Colors.blue,

                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                    child: Stack(
                                                      children: [
                                                        ImageCaches(
                                                          imageUrl: element
                                                              .propertyImages[0],
                                                        ),
                                                        Positioned(
                                                          left: 10,
                                                          top: 30,
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(50.0),
                                                            child: Container(
                                                              height: 60,
                                                              width: 150,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: const Color(
                                                                        0xff857b83)
                                                                    .withOpacity(
                                                                        0.8),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10),
                                                              ),
                                                              child: Column(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  const Spacer(),
                                                                  const Text(
                                                                    "Price",
                                                                    style:
                                                                        TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize:
                                                                          12,
                                                                    ),
                                                                  ),
                                                                  const Spacer(),
                                                                  Text(
                                                                    NumberFormat.currency(
                                                                            symbol:
                                                                                "₦ ",
                                                                            decimalDigits:
                                                                                0)
                                                                        .format(
                                                                            element.propertyPrice),

                                                                    // "\$${properties[index].propertyPrice}",
                                                                    style:
                                                                        const TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize:
                                                                          12,
                                                                    ),
                                                                  ),
                                                                  const Spacer(),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 2,
                                                child: SizedBox(
                                                  height: 40,
                                                  width: 280,
                                                  //color: Colors.red,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 8.0),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                            properties[index]
                                                                .propertyName,
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .titleLarge
                                                                ?.copyWith(
                                                                    fontSize:
                                                                        13)),
                                                        const SizedBox(
                                                            height: 5),
                                                        Text(
                                                          properties[index]
                                                              .propertyLocation,
                                                          style: Theme.of(
                                                                  context)
                                                              .textTheme
                                                              .labelMedium
                                                              ?.copyWith(
                                                                fontSize: 13,
                                                                color:
                                                                    Colors.grey,
                                                              ),
                                                        ),
                                                        const SizedBox(
                                                            height: 5),
                                                        SizedBox(
                                                          height: 30,
                                                          width:
                                                              double.infinity,
                                                          child:
                                                              ListView.builder(
                                                            itemCount: 3,
                                                            shrinkWrap: true,
                                                            scrollDirection:
                                                                Axis.horizontal,
                                                            itemBuilder:
                                                                (context,
                                                                    element) {
                                                              return Row(
                                                                children: [
                                                                  Row(
                                                                    children: [
                                                                      CircleAvatar(
                                                                        radius:
                                                                            15,
                                                                        backgroundColor: Theme.of(context)
                                                                            .primaryColor
                                                                            .withOpacity(0.3),
                                                                        child: Icon(
                                                                            icon[
                                                                                element],
                                                                            color:
                                                                                Theme.of(context).primaryColor,
                                                                            size: 15),
                                                                      ),
                                                                      const SizedBox(
                                                                          width:
                                                                              5),
                                                                      Padding(
                                                                        padding:
                                                                            const EdgeInsets.all(8.0),
                                                                        child:
                                                                            Text(
                                                                          getCircularItems(
                                                                              element),
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
                                                                  )
                                                                ],
                                                              );
                                                            },
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ).onTap(
                                      () => context.push(
                                        PropertyDetailsScreen(
                                            agentProperty: element),
                                      ),
                                    );
                                  },
                                ),
                        ))),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Nearby',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          context.push(
                            ALLNearbyProperty(
                              category: category,
                            ),
                          );
                        },
                        child: Text(
                          'View all',
                          style:
                              TextStyle(color: Theme.of(context).primaryColor),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: SizedBox(
                      height: 220,
                      width: context.width,
                      child: nearby?.isEmpty ?? true
                          ? const NotFoundWidget(
                              getNotFound: 'No nearby properties found')
                          : ListView.builder(
                              itemCount: nearby?.length,
                              physics: const BouncingScrollPhysics(),
                              itemBuilder: (BuildContext context, int index) {
                                final element = nearby?[index];
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    height: 100, // context.height * 0.15,
                                    width: context.width,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: Container(
                                            height: context.height * 0.15,
                                            width: context.width * 0.3,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              child: ImageCaches(
                                                  imageUrl: element
                                                          ?.propertyImages[0] ??
                                                      ''),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0, top: 17, bottom: 8),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  element?.propertyName ?? '',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleLarge
                                                      ?.copyWith(
                                                        fontSize: 16,
                                                      ),
                                                ),
                                                const SizedBox(height: 5),
                                                Text(
                                                  element?.propertyLocation ??
                                                      '',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .labelMedium
                                                      ?.copyWith(
                                                        fontSize: 13,
                                                        color: Colors.grey,
                                                      ),
                                                ),
                                                const SizedBox(height: 10),
                                                Text(
                                                  NumberFormat.currency(
                                                          symbol: "₦ ",
                                                          decimalDigits: 0)
                                                      .format(element
                                                          ?.propertyPrice),
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyMedium
                                                      ?.copyWith(
                                                        fontSize: 15,
                                                        color: Theme.of(
                                                          context,
                                                        ).primaryColor,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ).onTap(
                                  () => context.push(
                                    PropertyDetailsScreen(
                                        agentProperty: element!),
                                  ),
                                );
                              },
                            )

                      // color: Colors.blue,
                      ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
