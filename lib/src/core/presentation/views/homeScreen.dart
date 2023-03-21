import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:simple_key/src/core/domain/property.dart';
import 'package:simple_key/src/core/theme/color_pallter.dart';
import 'package:simple_key/src/core/utils/extension.dart';

import '../../widget/menu_widget.dart';

List<String> propertyType = [
  'House',
  'Apartment',
  'Land',
  'Warehouse',
  'Hotel',
  'Event Center',
];
List<IconData> icon = [
  Icons.king_bed_sharp,
  Icons.bathtub_sharp,
  Icons.landscape_sharp,
];

List circularItem = [];

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            Text(
              'Location',
              style: TextStyle(
                fontSize: 9,
                color: Theme.of(context).primaryColor,
              ),
            ),
            Text(
              'Lagos',
              style: TextStyle(
                fontSize: 15,
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        leading: const MenuWidget(),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                Expanded(
                  flex: 5,
                  child: TextField(
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      hintText: 'Search category or location',
                      hintStyle: TextStyle(
                        fontSize: 12,
                        color: Theme.of(context).primaryColor,
                      ),
                      suffixIcon: Icon(Icons.search,
                          color: Theme.of(context).primaryColor),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  flex: 1,
                  child: Container(
                    height: 50,
                    width: 20,
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(
                      PhosphorIcons.slidersHorizontal,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox.fromSize(
            size: Size(context.width, 60),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: propertyType.length,
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  bool isSelected = currentIndex == index;
                  return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: 100,
                        decoration: BoxDecoration(
                          gradient: isSelected ? gradient() : null,
                          color: isSelected ? null : Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            propertyType[index],
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: isSelected
                                  ? Colors.white
                                  : Theme.of(context).primaryColor,
                            ),
                          ),
                        ),
                      ).onTap(
                        () {
                          setState(() {
                            currentIndex = index;
                          });
                        },
                      ));
                },
              ),
            ),
          ),
          Expanded(
            child: IndexedStack(
              index: currentIndex,
              children: [
                Container(
                  height: context.height,
                  width: context.width,
                  // color: Colors.red,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text(
                              'Recently Posted',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text('View all'),
                          ],
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                          child: SizedBox(
                            height: context.height * 0.38,
                            width: context.width,
                            child: ListView.builder(
                              itemCount: properties.length,
                              scrollDirection: Axis.horizontal,
                              physics: const BouncingScrollPhysics(),
                              itemBuilder: (BuildContext context, int index) {
                                final element = properties[index];
                                String getCircularItems(int indexAt) {
                                  return {
                                        0: "${element.numberOfRooms}",
                                        1: "${element.numberOfBathrooms}",
                                        2: "${element.meters} mm",
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
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.white,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Column(
                                        children: [
                                          Expanded(
                                            flex: 4,
                                            child: Container(
                                              height: 200,
                                              width: 280,
                                              // color: Colors.blue,

                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                child: Stack(
                                                  children: [
                                                    Image.asset(
                                                      element.propertyImages[0],
                                                      fit: BoxFit.cover,
                                                      width: 280,
                                                    ),
                                                    Positioned(
                                                      bottom: 10,
                                                      left: 60,
                                                      child: Container(
                                                        height: 60,
                                                        width: 150,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: const Color(
                                                                  0xff857b83)
                                                              .withOpacity(0.8),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                        ),
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            const Spacer(),
                                                            const Text(
                                                              "Price",
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 12,
                                                              ),
                                                            ),
                                                            const Spacer(),
                                                            Text(
                                                              NumberFormat.currency(
                                                                      symbol:
                                                                          "₦ ",
                                                                      decimalDigits:
                                                                          0)
                                                                  .format(element
                                                                      .propertyPrice),

                                                              // "\$${properties[index].propertyPrice}",
                                                              style:
                                                                  const TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 12,
                                                              ),
                                                            ),
                                                            const Spacer(),
                                                          ],
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
                                            child: Container(
                                              height: 40,
                                              width: 280,
                                              //color: Colors.red,
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 8.0),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      properties[index]
                                                          .propertyName,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .titleLarge
                                                          ?.copyWith(
                                                              fontSize: 13),
                                                    ),
                                                    const SizedBox(height: 5),
                                                    Text(
                                                      properties[index]
                                                          .propertyLocation,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .labelMedium
                                                          ?.copyWith(
                                                            fontSize: 13,
                                                            color: Colors.grey,
                                                          ),
                                                    ),
                                                    const SizedBox(height: 5),
                                                    SizedBox(
                                                      height: 30,
                                                      width: double.infinity,
                                                      child: ListView.builder(
                                                        itemCount: 3,
                                                        shrinkWrap: true,
                                                        scrollDirection:
                                                            Axis.horizontal,
                                                        itemBuilder: (
                                                          context,
                                                          element,
                                                        ) {
                                                          return Row(
                                                            children: [
                                                              Row(
                                                                children: [
                                                                  CircleAvatar(
                                                                    radius: 15,
                                                                    backgroundColor: Theme.of(
                                                                            context)
                                                                        .primaryColor
                                                                        .withOpacity(
                                                                            0.3),
                                                                    child: Icon(
                                                                      icon[
                                                                          element],
                                                                      color: Theme.of(
                                                                              context)
                                                                          .primaryColor,
                                                                      size: 15,
                                                                    ),
                                                                  ),
                                                                  const SizedBox(
                                                                      width: 5),
                                                                  Padding(
                                                                    padding:
                                                                        const EdgeInsets.all(
                                                                            8.0),
                                                                    child: Text(
                                                                      getCircularItems(
                                                                          element),
                                                                      style: Theme.of(
                                                                              context)
                                                                          .textTheme
                                                                          .labelMedium
                                                                          ?.copyWith(
                                                                            fontSize:
                                                                                13,
                                                                            color:
                                                                                Theme.of(context).primaryColor,
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
                                );
                              },
                            ),
                          )),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text(
                              'Nearby',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text('View all'),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Container(
                            height: 200,
                            width: context.width,
                            child: ListView.builder(
                              itemCount: properties.length,
                              physics: const BouncingScrollPhysics(),
                              itemBuilder: (BuildContext context, int index) {
                                final element = properties[index];
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                      height: context.height * 0.15,
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
                                                image: DecorationImage(
                                                  image: AssetImage(
                                                    element.propertyImages[0],
                                                  ),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 2,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8.0),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    element.propertyName,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .titleLarge
                                                        ?.copyWith(
                                                          fontSize: 16,
                                                        ),
                                                  ),
                                                  const SizedBox(height: 5),
                                                  Text(
                                                    element.propertyLocation,
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
                                                            .propertyPrice),
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyMedium
                                                        ?.copyWith(
                                                          fontSize: 15,
                                                          color:
                                                              Theme.of(context)
                                                                  .primaryColor,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          )
                                        ],
                                      )),
                                );
                              },
                            )

                            // color: Colors.blue,
                            ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 200,
                  width: context.width,
                  color: Colors.blue,
                ),
                Container(
                  height: 200,
                  width: context.width,
                  color: Colors.green,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
