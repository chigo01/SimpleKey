import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:simple_key/src/core/route/route_navigation.dart';
import 'package:simple_key/src/core/utils/constants.dart';
import 'package:simple_key/src/core/utils/extension.dart';
import 'package:simple_key/src/core/widget/menu_widget.dart';
import 'package:simple_key/src/feautures/auth/presentation/widget/text_field.dart';
import 'package:simple_key/src/feautures/propertyPost/presentation/views/second_page.dart';
import 'package:simple_key/src/feautures/propertyPost/presentation/widgets/scrolling-text.dart';

final property = StateProvider<String?>((ref) => null);

class PropertyPost extends HookConsumerWidget {
  const PropertyPost({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nameController = TextEditingController();
    final proType = ref.watch(property);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Sell That Amazing Proprieties here",
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontSize: 15,
          ),
        ),
        leading: const MenuWidget(),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.red.withOpacity(0.2),
                ),
                height: 37,
                width: context.width * 1,
                child: ScrollingText(
                  text:
                      'If you are not yet an Agent you can\'t upload or sell properties. Only Agents ',
                  textStyle: TextStyle(
                    fontSize: 15,
                    color: Theme.of(context).primaryColor,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              height: 680, //height,
              width: context.width * 0.9,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 10.0, left: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        TextFieldColumn(
                            headerText: "Property Name",
                            hintText: "Enter Property Name",
                            maxLines: 1,
                            controller: nameController),
                        const SizedBox(height: 10),
                        TextFieldColumn(
                            headerText: "Location",
                            hintText: "Location of the property",
                            maxLines: 1,
                            controller: nameController),
                        const SizedBox(height: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8.0, horizontal: 20),
                              child: Text(
                                'Property Type',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 18.0, right: 20),
                              child: SizedBox(
                                width: context.width * 0.8,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Material(
                                    color: Theme.of(context)
                                        .primaryColor
                                        .withOpacity(0.3),
                                    child: DropdownButton<String>(
                                      isExpanded: true,
                                      style: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                        fontSize: 16,
                                      ),
                                      menuMaxHeight: 200,
                                      hint: const Text('Select Property Type'),
                                      value: proType,
                                      items: propertyType
                                          .map(
                                            (String properCategory) =>
                                                DropdownMenuItem<String>(
                                              value: properCategory,
                                              child: Text(properCategory),
                                            ),
                                          )
                                          .toList(),
                                      onChanged: (value) {
                                        if (value != null) {
                                          ref.read(property.notifier).state =
                                              value;
                                        }
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      height: 100,
                      width: context.width * 0.8,
                      child: Wrap(
                        spacing: 10,
                        children: [
                          const WrapContainer(text: 'BedRooms'),
                          const WrapContainer(text: 'BathRooms'),
                          TextFieldColumn(
                            hintText: 'Square kilometers',
                            headerText: 'Land Area',
                            controller: nameController,
                            maxLines: 1,
                          ),
                          const SizedBox(height: 10),
                          TextFieldColumn(
                              headerText: "Amount of the property",
                              hintText: "Enter Price",
                              maxLines: 1,
                              controller: nameController),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 12.0, right: 30),
                child: Container(
                  height: 50,
                  width: context.width * 0.24,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Theme.of(context).primaryColor,
                  ),
                  child: const Center(
                    child: Text(
                      'Next Step',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ).onTap(
                  () => context.pushTransition(
                    const NextPageScreen(),
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

class WrapContainer extends StatelessWidget {
  const WrapContainer({
    super.key,
    required this.text,
    this.maxLine,
  });

  final String text;
  final int? maxLine;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: 150,
      child: Row(
        children: [
          Expanded(
            flex: 6,
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                text,
                maxLines: 2,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Padding(
              padding: const EdgeInsets.only(
                top: 5,
                bottom: 5.0,
              ),
              child: TextFormField(
                //  maxLines: maxLine,
                decoration: InputDecoration(
                  fillColor: Theme.of(context).primaryColor.withOpacity(0.3),
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(
                      color: Theme.of(context).primaryColor,
                      width: 2,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
