import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

import 'package:simple_key/src/feautures/Home%20Screen/presentation/views/read_more.dart';
import 'package:simple_key/src/model/product_model.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

final currentIndex = StateProvider<int>((ref) => 0);

class PropertyDetailsScreen extends HookConsumerWidget {
  const PropertyDetailsScreen({Key? key, required this.agentProperty})
      : super(key: key);
  final AgentProperty agentProperty;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10.0, top: 5),
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
              const SizedBox(height: 10),
              Container(
                height: 400,
                padding:
                    const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15),
                margin: const EdgeInsets.symmetric(horizontal: 20.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: 200,
                      child: CarouselSlider(
                        items: agentProperty.propertyImages
                            .map(
                              (images) => Stack(children: [
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Center(
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      // child: Image.network(
                                      //   images,
                                      //   fit: BoxFit.cover,
                                      //   width: 1000,
                                      // ),
                                      child: CachedNetworkImage(
                                        imageUrl: images,
                                        errorWidget: (context, url, error) =>
                                            const Icon(Icons.error),
                                        placeholder: (BuildContext context,
                                                String url) =>
                                            SpinKitFadingCircle(
                                          size: 80,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return DecoratedBox(
                                              decoration: BoxDecoration(
                                                color: index.isEven
                                                    ? Colors.white
                                                    : Theme.of(context)
                                                        .primaryColor,
                                              ),
                                            );
                                          },
                                        ),
                                        maxWidthDiskCache: 500,
                                        maxHeightDiskCache: 300,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 30,
                                  right: 30,
                                  top: 80,
                                  child: Padding(
                                    padding: const EdgeInsets.all(50.0),
                                    child: Container(
                                      height: 60,
                                      width: 150,
                                      decoration: BoxDecoration(
                                        color: const Color(0xff857b83)
                                            .withOpacity(0.8),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const Spacer(),
                                          const Text(
                                            "Price",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12,
                                            ),
                                          ),
                                          const Spacer(),
                                          Text(
                                            NumberFormat.currency(
                                                    symbol: "₦ ",
                                                    decimalDigits: 0)
                                                .format(agentProperty
                                                    .propertyPrice),

                                            // "\$${properties[index].propertyPrice}",
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 12,
                                            ),
                                          ),
                                          const Spacer(),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ]),
                            )
                            .toList(),
                        options: CarouselOptions(
                          height: 500.0,
                          enlargeCenterPage: true,
                          autoPlay: true,
                          autoPlayCurve: Curves.fastOutSlowIn,
                          enableInfiniteScroll: true,
                          autoPlayAnimationDuration:
                              const Duration(milliseconds: 800),
                          viewportFraction: 1,
                          onPageChanged: (index, reason) {
                            ref.read(currentIndex.notifier).state = index;
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    AnimatedSmoothIndicator(
                      activeIndex: ref.watch(currentIndex),
                      count: agentProperty.propertyImages.length,
                      effect: ExpandingDotsEffect(
                        dotHeight: 3,
                        dotWidth: 12,
                        dotColor: Colors.grey,
                        activeDotColor: Theme.of(context).primaryColor,
                        spacing: 4.0,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Column(
                      children: [
                        Text(
                          agentProperty.propertyName,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            agentProperty.propertyLocation,
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Posted on 12 mar 2023',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Wrap(
                          children: [
                            WrapWidget(
                              agentProperty:
                                  '${agentProperty.numberOfRooms} Rooms',
                              text: 'Bedrooms',
                            ),
                            Container(
                              height: 30,
                              width: 1,
                              color: Colors.grey,
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 10),
                            ),
                            WrapWidget(
                              agentProperty:
                                  '${agentProperty.numberOfBathrooms} Baths',
                              text: 'Bathrooms',
                            ),
                            Container(
                              height: 30,
                              width: 1,
                              color: Colors.grey,
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 10),
                            ),
                            WrapWidget(
                              agentProperty: '${agentProperty.meters} sqft',
                              text: 'Area',
                            ),
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Container(
                height: 100,
                padding:
                    const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15),
                margin: const EdgeInsets.symmetric(horizontal: 20.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Container(
                          height: 60,
                          width: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: const DecorationImage(
                              image: AssetImage('assets/images/profile.jpg'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              agentProperty.propertyOwnerName,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 5),
                            const Text('View agent profile')
                          ],
                        ),
                        const Spacer(),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.arrow_forward,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Container(
                height: 200,
                padding:
                    const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15),
                margin: const EdgeInsets.symmetric(horizontal: 20.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Description',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    ReadMoreText(
                      agentProperty.propertyDescription,
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
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class WrapWidget extends StatelessWidget {
  const WrapWidget({
    super.key,
    required this.agentProperty,
    required this.text,
  });

  final String agentProperty;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          text,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).primaryColor,
          ),
        ),
        Text(
          agentProperty,
          style: TextStyle(
            fontSize: 12,
            color: Theme.of(context).primaryColor,
          ),
        ),
      ],
    );
  }
}
