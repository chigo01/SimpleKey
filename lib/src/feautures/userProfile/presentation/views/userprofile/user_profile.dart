import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:simple_key/src/core/providers/auth_providers.dart';
import 'package:simple_key/src/core/utils/async_widget.dart';
import 'package:simple_key/src/core/utils/constants.dart';
import 'package:simple_key/src/core/utils/extension.dart';
import 'package:simple_key/src/core/widget/menu_widget.dart';
import 'package:simple_key/src/core/widgets/images_caches.dart';
import 'package:simple_key/src/core/widgets/notfound.dart';
import 'package:simple_key/src/feautures/propertyPost/data/controller/provider/property_repo.dart';
import 'package:simple_key/src/feautures/userProfile/data/controller/providers/providers.dart';

final currentIndex = StateProvider((ref) => 0);

class Profile extends HookConsumerWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Color primary = Theme.of(context).primaryColor;
    final currentUser = ref.watch(firebaseAuthProvider).currentUser?.uid;

    final users = ref.watch(getAllUser(currentUser ?? "")).valueOrNull;
    final agentProperty = ref.watch(getAllPropertyByAgent(currentUser ?? ""));

    return Scaffold(
      appBar: AppBar(
        backgroundColor: primary.withOpacity(0.3),
        // title: const Text('My Profile'),
        leading: const MenuWidget(),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                height: context.height * 0.3,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: primary.withOpacity(0.3),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 100.0),
                  child: Row(
                    children: [
                      const SizedBox(width: 10),
                      Container(
                        height: context.height * 0.16,
                        width: context.width * 0.3,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          //color: Colors.white,
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(25),
                          child: ImageCaches(imageUrl: users?.image ?? ""),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          height: context.height * 0.9,
                          width: context.width * 0.5,

                          ///   color: Colors.white,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Text(
                                  users?.userName ?? "",
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge
                                      ?.copyWith(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 10,
                                      ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              Expanded(
                                child: Text(
                                  users?.email ?? "",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(
                                        color: primary,
                                        fontSize: 10,
                                      ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                users?.phone ?? "",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge
                                    ?.copyWith(color: primary, fontSize: 10),
                              ),
                              const SizedBox(height: 10),
                              Expanded(
                                flex: 2,
                                child: Container(
                                  height: 70,
                                  width: 120,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white.withOpacity(0.2),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: Text(
                                          'Profile Type',
                                          style: TextStyle(
                                            fontSize:
                                                context.height > 700 ? 10 : 7,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Text(
                                          users?.userRole ?? "",
                                          style: TextStyle(
                                            fontSize:
                                                context.height > 700 ? 15 : 9,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: context.height * 0.5,
                  child: Column(
                    children: [
                      Expanded(
                        flex: 1,
                        child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: propertyType.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              final bool isSelected =
                                  ref.watch(currentIndex) == index;
                              return Padding(
                                padding: EdgeInsets.only(
                                  bottom: context.height > 800 ? 40.0 : 20,
                                ),
                                child: SizedBox(
                                  height: 70,
                                  width: 70,
                                  // color: Colors.red,
                                  child: Column(
                                    children: [
                                      const SizedBox(height: 40),
                                      Expanded(
                                        flex: 3,
                                        child: Text(
                                          propertyType[index],
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall
                                              ?.copyWith(
                                                  fontSize: 10,
                                                  color: isSelected
                                                      ? primary
                                                      : null,
                                                  fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      if (isSelected)
                                        Expanded(
                                          flex: 1,
                                          child: Container(
                                            height: 2,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: primary,
                                            ),
                                          ),
                                        )
                                    ],
                                  ).onTap(() => ref
                                      .read(currentIndex.notifier)
                                      .state = index),
                                ),
                              );
                            }),
                      ),
                      Expanded(
                          flex: 3,
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
                          ))
                    ],
                  ),
                ),
              )
            ],
          ),
          Positioned(
            top: context.height * 0.2,
            left: context.width * 0.05,
            child: Container(
              height: context.height * 0.15,
              width: context.width * 0.9,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.white,
              ),
              child: Column(
                children: [
                  const Text(
                    'ABOUT ME',
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Center(
                      child: Text(
                        users?.description ?? "",
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(fontSize: 15, color: primary, shadows: [
                          const BoxShadow(color: Colors.black, blurRadius: 2)
                        ]),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class TabBody extends HookConsumerWidget {
  const TabBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUser = ref.watch(firebaseAuthProvider).currentUser?.uid;
    final agentProperty = ref.watch(getAllPropertyByAgent(currentUser ?? ""));

    return Container(
      child: AsyncWidget(
        asyncValue: agentProperty,
        data: (properties) {
          final index = ref.watch(currentIndex);
          final categoryProperty = properties
              .where(
                (element) => element.propertyType == propertyType[index],
              )
              .toList();

          return categoryProperty.isEmpty
              ? Center(
                  child: SizedBox(
                    height: 200,
                    child: NotFoundWidget(
                      getNotFound:
                          'You have no ${propertyType[index]} related properties yet',
                    ),
                  ),
                )
              : GridView.builder(
                  itemCount: categoryProperty.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 3,
                    mainAxisSpacing: 3,
                  ),
                  itemBuilder: (context, index) {
                    final property = categoryProperty[index];

                    debugPrint(categoryProperty.length.toString());
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 230,
                        width: 70,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.white.withOpacity(0.5),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Expanded(
                                child: SizedBox(
                                  height: 100,
                                  width: 100,
                                  child: ImageCaches(
                                    imageUrl: property.propertyImages[0],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 5),
                              Expanded(
                                child: Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: Colors.white,
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        property.propertyName,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleLarge
                                            ?.copyWith(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                            ),
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        NumberFormat.currency(
                                                symbol: "₦ ", decimalDigits: 0)
                                            .format(
                                          property.propertyPrice,
                                        ),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall
                                            ?.copyWith(
                                              fontWeight: FontWeight.bold,
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
        },
      ),
    );
  }
}
