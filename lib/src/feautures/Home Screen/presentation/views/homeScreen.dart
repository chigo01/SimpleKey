import 'package:flutter/material.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:simple_key/src/core/route/route_navigation.dart';

import 'package:simple_key/src/core/theme/color_pallter.dart';
import 'package:simple_key/src/core/utils/constants.dart';
import 'package:simple_key/src/core/utils/extension.dart';
import 'package:simple_key/src/core/widget/menu_widget.dart';
import 'package:simple_key/src/feautures/Home%20Screen/presentation/filter_result.dart';
import 'package:simple_key/src/feautures/propertyPost/data/controller/provider/property_repo.dart';

import 'package:simple_key/src/feautures/userProfile/data/controller/providers/providers.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import 'tap/tab_body.dart';

List circularItem = [];
//Map<int, PhosphorIconData> check = {0: PhosphorIcons.light.check};
final check = StateProvider((ref) => {'House'});

final currentIndex = StateProvider((ref) => 0);
final filterCurrentIndex = StateProvider((ref) => 0);

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  RangeValues _currentRangeValues = const RangeValues(305000, 1000000);
  TextEditingController filterSearch = TextEditingController();
  String search = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    filterSearch.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final panelController = PanelController();
    return Scaffold(
      //resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Consumer(
            builder: (BuildContext context, WidgetRef ref, Widget? child) {
          final user = ref.watch(getUser).valueOrNull;

          return Column(
            children: [
              Text(
                'Location',
                style: TextStyle(
                  fontSize: 9,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              Text(
                user?.location ?? 'No location',
                style: TextStyle(
                  fontSize: 15,
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          );
        }),
        leading: const MenuWidget(),
      ),
      body: Stack(children: [
        Consumer(builder: (BuildContext context, WidgetRef ref, Widget? child) {
          //  final propertiesRead = ref.watch(getAllProperties);

          // final propertiesValues = ref
          //     .watch(getPropertyByCategory.notifier)
          //     .getPropertyByCategory('House');

          return Column(
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
                        child: PhosphorIcon(
                          PhosphorIcons.fill.slidersHorizontal,
                          color: Colors.white,
                        ),
                      ).onTap(() => panelController.open()),
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
                      bool isSelected = ref.watch(currentIndex) == index;
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
                              ref
                                  .watch(currentIndex.notifier)
                                  .update((state) => state = index);
                              ref.read(categoryName.notifier).update(
                                  (state) => state = propertyType[index]);
                            },
                          ));
                    },
                  ),
                ),
              ),
              Expanded(
                child: IndexedStack(
                  index: ref.watch(currentIndex),
                  children: const [
                    TabBody(),
                    TabBody(),
                    TabBody(),
                    TabBody(),
                    TabBody(),
                    TabBody(),
                  ],
                ),
              ),
            ],
          );
        }),
        SlidingUpPanel(
          controller: panelController,
          minHeight: 0,
          maxHeight: context.height * 0.5,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(50),
            topRight: Radius.circular(50),
          ),
          defaultPanelState: PanelState.CLOSED,
          panel: Consumer(
              builder: (BuildContext context, WidgetRef ref, Widget? child) {
            final checks = ref.watch(check);
            final currentSelected = ref.watch(filterCurrentIndex);

            final allProperty = ref.watch(getAllProperty).valueOrNull;

            final filterByCategory = allProperty?.where((element) {
                  return checks.any((value) => value == element.propertyType) &&
                      element.propertyPrice >= _currentRangeValues.start &&
                      element.propertyPrice <= _currentRangeValues.end &&
                      element.propertyLocation.toUpperCase().contains(
                            search.toUpperCase(),
                          );
                }).toList() ??
                [];
            bool isSelected = false;

            return Center(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 20.0, horizontal: context.width / 2.5),
                      child: Container(
                        height: 4,
                        width: 90,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey,
                        ),
                      ),
                    ).onTap(() => {
                          panelController.close(),
                          ref
                              .read(check.notifier)
                              .update((state) => state = {}),
                          ref
                              .read(filterCurrentIndex.notifier)
                              .update((state) => state = 0),
                        }),
                    const Text(
                      'Search Filter',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: TextField(
                        controller: filterSearch,
                        onChanged: (value) {
                          setState(() {
                            search = value;
                          });
                        },
                        decoration: InputDecoration(
                          fillColor: Colors.grey[200],
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
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const Text(
                            'PRICE',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                              '${NumberFormat.currency(symbol: "₦ ", decimalDigits: 0).format(_currentRangeValues.start.round())} - ${NumberFormat.currency(symbol: "₦ ", decimalDigits: 0).format(_currentRangeValues.end.round())}',
                              style: const TextStyle(
                                fontSize: 12,
                              )),
                          RangeSlider(
                              values: _currentRangeValues,
                              min: 100000,
                              max: 100000000,
                              divisions: 1000000,
                              activeColor: Theme.of(context).primaryColor,
                              inactiveColor: Colors.grey,
                              onChanged: (value) {
                                setState(() {
                                  _currentRangeValues = value;
                                });
                              }),
                        ],
                      ),
                    ),
                    const Text(
                      'PROPERTY TYPE',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 80,
                      //color: Colors.red,
                      child: Wrap(
                        children: [
                          //  for (var i = 0; i < propertyType.length; i++)

                          ...propertyType.map(
                            (type) {
                              isSelected = checks.contains(type);
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  width: 100,
                                  height: 30,
                                  decoration: BoxDecoration(
                                    // color: Theme.of(context).primaryColor,
                                    gradient: gradient(),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        type,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                      isSelected
                                          ? PhosphorIcon(
                                              PhosphorIcons.bold.check,
                                              color: Colors.white,
                                              size: 15,
                                            )
                                          : const SizedBox.shrink()
                                    ],
                                  ),
                                ).onTap(
                                  () {
                                    if (checks.contains(type)) {
                                      isSelected = true;
                                      ref.read(check.notifier).update(
                                            (state) => state
                                                .where(
                                                  (element) => element != type,
                                                )
                                                .toSet(),
                                          );
                                    } else {
                                      ref.read(check.notifier).update(
                                            (state) => state = {
                                              ...checks,
                                              type,
                                            },
                                          );
                                    }
                                  },
                                ),
                              );
                            },
                          ).toList()
                        ],
                      ),
                    ),
                    const SizedBox(height: 15),
                    Container(
                      height: 50,
                      width: context.width * 0.5,
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        //gradient: gradient(),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          filterByCategory.isNotEmpty
                              ? 'View ${filterByCategory.length} Results'
                              : "No Results", //  'Apply Filter',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ).onTap(filterByCategory.isNotEmpty
                        ? () {
                            context.push(
                              FilterResult(categoryProperty: filterByCategory),
                            );
                            panelController.close();
                          }
                        : () {}),
                  ],
                ),
              ),
            );
          }),
        )
      ]),
    );
  }
}
