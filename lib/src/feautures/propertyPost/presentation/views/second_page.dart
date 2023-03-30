import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:simple_key/src/core/utils/cam.dart';
import 'package:simple_key/src/core/utils/extension.dart';
import 'package:simple_key/src/core/utils/show_snackbar.dart';
import 'package:simple_key/src/core/widgets/loading_indicator.dart';
import 'package:simple_key/src/feautures/auth/presentation/widget/text_field.dart';
import 'package:simple_key/src/feautures/propertyPost/data/controller/provider/property_repo.dart';
import 'package:simple_key/src/feautures/propertyPost/presentation/widgets/scrolling-text.dart';
import 'package:simple_key/src/feautures/userProfile/data/controller/providers/providers.dart';
import 'package:simple_key/src/model/product_model.dart';
import 'package:uuid/uuid.dart';

final property = StateProvider<String?>((ref) => null);

class NextPageScreen extends HookConsumerWidget {
  const NextPageScreen({
    Key? key,
    required this.propertyName,
    required this.propertyType,
    required this.propertyLocation,
    required this.propertyPrice,
    this.numberOfRooms,
    this.numberOfBathrooms,
    required this.meters,
  }) : super(key: key);
  final TextEditingController propertyName;
  final String propertyType;
  final TextEditingController propertyLocation;
  final TextEditingController propertyPrice;
  final TextEditingController? numberOfRooms;
  final TextEditingController? numberOfBathrooms;
  final TextEditingController meters;

  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final descriptionController = useTextEditingController();
    final proType = ref.watch(property);
    final propertyImages = <String>[];
    final DateTime createdAt = DateTime.now();
    final user = ref.watch(getUser).valueOrNull;
    final images = ref.watch(imagePaths);
    final upload = ref.watch(productPostProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Sell That Amazing Proprieties here",
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontSize: 15,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
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
                height: 600,
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
                      const SizedBox(height: 10),
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 12.0),
                            child: images.isNotEmpty
                                ? SizedBox(
                                    height: 230,
                                    width: double.infinity,
                                    child: GridView.builder(
                                      itemCount: images.length,
                                      gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 2),
                                      itemBuilder: (_, index) {
                                        return Card(
                                          elevation: 10,
                                          child: Image.file(
                                            File(
                                              images[index],
                                            ),
                                            fit: BoxFit.cover,
                                          ),
                                        );
                                      },
                                    ),
                                  )
                                : DottedBorder(
                                    borderType: BorderType.RRect,
                                    radius: const Radius.circular(20),
                                    //  dashPattern: [10, 10],
                                    color: Colors.grey,
                                    strokeWidth: 2,

                                    child: SizedBox(
                                      width: double.infinity,
                                      height: 200,
                                      child: Card(
                                        color: Theme.of(context)
                                            .primaryColor
                                            .withOpacity(0.9),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Center(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: const [
                                              Icon(
                                                PhosphorIcons.fileArrowDownFill,
                                                color: Colors.white,
                                                size: 40,
                                              ),
                                              SizedBox(height: 10),
                                              Text(
                                                'Add Photos',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ).onTap(
                                      () async {
                                        await getImages(ref);
                                        print('ImageS $images');
                                      },
                                    ),
                                  ),
                          ),
                          const SizedBox(height: 30),
                          TextFieldColumn(
                            hintText: 'Description',
                            headerText: 'Property Description ',
                            maxLines: 10,
                            controller: descriptionController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return '';
                              }
                              return null;
                            },
                          )
                        ],
                      ),
                      const SizedBox(height: 20),
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
                    child: Center(
                      child: upload.isLoading
                          ? const Spinner(size: 40)
                          : const Text(
                              'Upload',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                    ),
                  ).onTap(
                    () {
                      final property = AgentProperty(
                        propertyName: propertyName.text,
                        propertyType: propertyType,
                        propertyLocation: propertyLocation.text,
                        propertyPrice: propertyPrice.text.toDouble,
                        propertyImages: propertyImages,
                        propertyDescription: descriptionController.text,
                        propertyId: const Uuid().v4(),
                        propertyOwnerId: user?.id ?? "",
                        propertyOwnerName: user?.userName ?? "",
                        numberOfRooms: numberOfRooms?.text.toInt,
                        numberOfBathrooms: numberOfBathrooms?.text.toInt,
                        meters: meters.text.toInt,
                        createdAt: createdAt,
                        agentProfileImage: user?.image ?? "",
                      );
                      if (images.isNotEmpty &&
                          _formKey.currentState!.validate() &&
                          user?.userRole == 'Agent') {
                        ref
                            .read(productPostProvider.notifier)
                            .uploadProperty(ref, propertyImages, property)
                            .then(
                              (value) => showSnackBar(
                                context,
                                'Property uploaded successfully',
                              ),
                            )
                            .whenComplete(() {
                          ref
                              .read(imagePaths.notifier)
                              .update((state) => state = []);
                          descriptionController.clear();
                          Navigator.pop(context);

                          propertyName.clear();
                          propertyLocation.clear();
                          propertyPrice.clear();
                          meters.clear();
                          numberOfRooms?.clear();
                          numberOfBathrooms?.clear();
                        });
                        // } else if (user?.userRole == 'Customer') {
                        //   showSnackBar(
                        //     context,
                        //     'It seems like you are not an Realtor. You are not authorized to upload property',
                        //   );
                      } else {
                        showSnackBar(
                          context,
                          'Please give a detailed description of the property and upload property images before uploading',
                        );
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
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
