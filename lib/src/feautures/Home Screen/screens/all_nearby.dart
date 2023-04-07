import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:simple_key/src/core/route/route_navigation.dart';
import 'package:simple_key/src/core/utils/extension.dart';
import 'package:simple_key/src/core/widgets/images_caches.dart';
import 'package:simple_key/src/core/widgets/notfound.dart';
import 'package:simple_key/src/feautures/Home%20Screen/presentation/views/PropertyDetailedScreen.dart';
import 'package:simple_key/src/feautures/Home%20Screen/presentation/views/homeScreen.dart';
import 'package:simple_key/src/feautures/propertyPost/data/controller/provider/property_repo.dart';
import 'package:simple_key/src/feautures/userProfile/data/controller/providers/providers.dart';

class ALLNearbyProperty extends HookConsumerWidget {
  const ALLNearbyProperty({super.key, required this.category});

  final String category;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final propertiesValues = ref.watch(getAllPropertyByCategory(category));
    final user = ref.watch(getUser).valueOrNull;
    List<String> userList = user?.location?.trim().split(',') ?? [];

    final nearby = propertiesValues.value?.where((property) {
      return userList.any(
        (element) =>
            property.propertyLocation.trim().split(',').contains(element),
      );
    }).toList();

    return Scaffold(
        appBar: AppBar(
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Theme.of(context).primaryColor.withOpacity(0.2),
              ),
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          title: Text(
            'All $category Properties In Your Location',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontSize: 15,
                ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: nearby?.isEmpty ?? true
              ? const Center(
                  child: SizedBox(
                    height: 300,
                    child: NotFoundWidget(
                        getNotFound:
                            'No NearBy properties have not been posted yet '),
                  ),
                )
              : ListView.builder(
                  itemCount: nearby?.length,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    final element = nearby?[index];
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
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 1,
                                        blurRadius: 20,
                                        offset: const Offset(0, 3),
                                      ),
                                    ]
                                    // image: DecorationImage(
                                    //   image: AssetImage(
                                    //     element.propertyImages[0],
                                    //   ),
                                    //   fit: BoxFit.cover,
                                    // ),
                                    ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: ImageCaches(
                                    imageUrl: element?.propertyImages[0] ?? '',
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 8.0, top: 17, bottom: 8),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                      element?.propertyLocation ?? '',
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
                                              symbol: "₦ ", decimalDigits: 0)
                                          .format(element?.propertyPrice),
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.copyWith(
                                              fontSize: 15,
                                              color: Theme.of(
                                                context,
                                              ).primaryColor,
                                              fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ).onTap(() {
                      context.pushTransition(
                        PropertyDetailsScreen(agentProperty: element!),
                      );
                    });
                  },
                ),
        ));
  }
}
