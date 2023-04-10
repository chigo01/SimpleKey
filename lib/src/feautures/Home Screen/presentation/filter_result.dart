import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:simple_key/src/core/route/route_navigation.dart';
import 'package:simple_key/src/core/utils/extension.dart';
import 'package:simple_key/src/core/widget/arrow_back.dart';
import 'package:simple_key/src/core/widgets/images_caches.dart';
import 'package:simple_key/src/feautures/Home%20Screen/presentation/views/PropertyDetailedScreen.dart';
import 'package:simple_key/src/model/product_model.dart';

class FilterResult extends StatelessWidget {
  const FilterResult({super.key, required this.categoryProperty});
  final List<AgentProperty> categoryProperty;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: const ArrowBack(),
          title: Text(
            "Your Filter Results",
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Total ${categoryProperty.length} Results",
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontSize: 13,
                    ),
              ),
              const SizedBox(height: 10),
              Expanded(
                flex: 2,
                child: GridView.builder(
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
                    ).onTap(() => context.push(
                          PropertyDetailsScreen(
                            agentProperty: property,
                          ),
                        ));
                  },
                ),
              ),
            ],
          ),
        ));
  }
}
