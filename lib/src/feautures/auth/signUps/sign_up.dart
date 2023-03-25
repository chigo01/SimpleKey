import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:simple_key/src/core/route/route_navigation.dart';
import 'package:simple_key/src/core/theme/color_pallter.dart';
import 'package:simple_key/src/core/utils/cam.dart';
import 'package:simple_key/src/core/utils/extension.dart';
import 'package:simple_key/src/core/utils/show_snackbar.dart';
import 'package:simple_key/src/feautures/Home%20Screen/presentation/views/app.dart';
import 'package:simple_key/src/feautures/auth/data/controller/provider/provider.dart';
import 'package:simple_key/src/feautures/auth/presentation/widget/text_field.dart';
import 'package:simple_key/src/model/users_model.dart';

final obscureText = StateProvider<bool>((ref) => false);

class SignUpScreen extends HookConsumerWidget {
  const SignUpScreen({super.key, required this.isAgent});
  final bool isAgent;
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();
    final phoneController = useTextEditingController();
    final nameController = useTextEditingController();
    final addressController = useTextEditingController();
    final companyController = useTextEditingController();
    final aboutController = useTextEditingController();
    final user = FirebaseAuth.instance.currentUser;
    final passwordVisibility = ref.watch(obscureText);
    final authRepo = ref.watch(authNotifierProvider);
    final imagePicked = ref.watch(imagePath);
    FocusNode nameFocusNode = useFocusNode();
    FocusNode emailFocusNode = useFocusNode();
    FocusNode passwordFocusNode = useFocusNode();
    FocusNode phoneFocusNode = useFocusNode();
    FocusNode addressFocusNode = useFocusNode();
    FocusNode companyFocusNode = useFocusNode();
    FocusNode aboutFocusNode = useFocusNode();

    late double height;
    if (isAgent) {
      // height =
      // context.height < 800 ? context.height * 1.4 : context.height * 1.25;
      if (context.height < 700) {
        height = context.height * 1.55;
      } else if (context.height < 800) {
        height = context.height * 1.4;
      } else if (context.height >= 900) {
        height = context.height * 1.1;
      } else {
        height = context.height * 1.25;
      }
    } else {
      height =
          context.height < 700 ? context.height * 1.1 : context.height * 0.9;
    }

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.only(top: 30.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20, top: 8),
                  child: Row(
                    children: [
                      Container(
                        height: 40,
                        width: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                        child: IconButton(
                          onPressed: () {
                            context.maybePop();
                            ref.read(imagePath.notifier).update(
                                  (state) => state = null,
                                );
                          },
                          icon: const Icon(Icons.arrow_back_ios),
                        ),
                      ),
                      const SizedBox(width: 20),
                      Text(
                        'Sign Up',
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColor),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Column(
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.blue.withOpacity(0.2),
                      // backgroundColor: Colors.transparent,
                      child: imagePicked == null
                          ? Image.asset(
                              "assets/images/Camera.png",
                              height: 70,
                              width: 100,
                            )
                          : ClipOval(
                              child: Image.file(
                                File(imagePicked),
                                height: 80,
                                width: 80,
                                fit: BoxFit.cover,
                              ),
                            ),
                    ),
                    const Text('Add Image')
                  ],
                ).onTap(
                  () => showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return SizedBox(
                        height: 150,
                        child: Column(
                          children: [
                            const SizedBox(height: 10),
                            ListTile(
                              leading: Icon(Icons.camera_alt,
                                  color: Theme.of(context).primaryColor),
                              title: Text(
                                'Camera',
                                style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                              onTap: () => getImage(ref, 'Camera'),
                            ),
                            ListTile(
                              leading: Icon(
                                Icons.image,
                                color: Theme.of(context).primaryColor,
                              ),
                              title: Text(
                                'Gallery',
                                style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                              onTap: () {
                                getImage(ref, 'Gallery');
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  height: context.height * 0.68, //height,
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
                  child: Scrollbar(
                    thickness: 5,
                    child: SingleChildScrollView(
                      //physics: const BouncingScrollPhysics(),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10.0, left: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              children: [
                                TextFieldColumn(
                                  headerText: 'Name',
                                  hintText: "Steve Jobs",
                                  focusNode: nameFocusNode,
                                  maxLines: 1,
                                  controller: nameController,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please enter your name';
                                    }
                                    return null;
                                  },
                                  onFieldSubmitted: (value) {
                                    nameFocusNode.unfocus();
                                    FocusScope.of(context)
                                        .requestFocus(emailFocusNode);
                                  },
                                ),
                                TextFieldColumn(
                                  headerText: 'Email',
                                  hintText: "tim@gmail.com",
                                  focusNode: emailFocusNode,
                                  maxLines: 1,
                                  controller: emailController,
                                  keyboardType: TextInputType.emailAddress,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please enter your email';
                                    }
                                    if (!value.isValidEmail) {
                                      return 'Please enter a valid email';
                                    }
                                    return null;
                                  },
                                  onFieldSubmitted: (value) {
                                    emailFocusNode.unfocus();
                                    FocusScope.of(context)
                                        .requestFocus(phoneFocusNode);
                                  },
                                ),
                                TextFieldColumn(
                                  headerText: 'Phone Number',
                                  hintText: "08012345678",
                                  maxLines: 1,
                                  focusNode: phoneFocusNode,
                                  controller: phoneController,
                                  keyboardType: TextInputType.phone,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please enter your phone number';
                                    }
                                    if (value.length > 11 ||
                                        value.length < 11) {
                                      return 'Please enter a valid phone number';
                                    }
                                    return null;
                                  },
                                  onFieldSubmitted: (value) {
                                    phoneFocusNode.unfocus();
                                    FocusScope.of(context)
                                        .requestFocus(passwordFocusNode);
                                  },
                                ),
                                TextFieldColumn(
                                  headerText: 'Password',
                                  hintText: "Pick a strong password",
                                  maxLines: 1,
                                  controller: passwordController,
                                  obscureText: passwordVisibility,
                                  focusNode: passwordFocusNode,
                                  obscuringCharacter:
                                      !passwordVisibility ? '.' : '◉',
                                  suffixIcon: IconButton(
                                    onPressed: () => ref
                                        .read(obscureText.notifier)
                                        .update((state) => !state),
                                    icon: Icon(
                                      passwordVisibility
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Password cannot be empty';
                                    } else if (value.length < 6) {
                                      return 'Password must be at least 6 characters';
                                    } else if (!value.validatePassword) {
                                      return 'Password must contain at least one uppercase, one lowercase, one number and one special character';
                                    }
                                    return null;
                                  },
                                  onFieldSubmitted: (value) {
                                    passwordFocusNode.unfocus();
                                    FocusScope.of(context)
                                        .requestFocus(addressFocusNode);
                                  },
                                ),
                                TextFieldColumn(
                                  headerText: 'Location',
                                  hintText: "Lagos, Nigeria",
                                  focusNode: addressFocusNode,
                                  maxLines: 1,
                                  controller: addressController,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please enter your address';
                                    }
                                    return null;
                                  },
                                  onFieldSubmitted: (value) {
                                    addressFocusNode.unfocus();
                                    FocusScope.of(context)
                                        .requestFocus(companyFocusNode);
                                  },
                                ),
                                if (isAgent)
                                  TextFieldColumn(
                                    headerText: 'Company Name',
                                    hintText: "LandMark",
                                    maxLines: 1,
                                    controller: companyController,
                                    focusNode: companyFocusNode,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Please enter your company name';
                                      }
                                      return null;
                                    },
                                    onFieldSubmitted: (value) {
                                      companyFocusNode.unfocus();
                                      FocusScope.of(context)
                                          .requestFocus(aboutFocusNode);
                                    },
                                  ),
                                if (isAgent)
                                  TextFieldColumn(
                                    headerText: "About Me",
                                    hintText: "I am a real estate agent",
                                    maxLength: 200,
                                    focusNode: aboutFocusNode,
                                    maxLines: 8,
                                    controller: aboutController,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Please enter a short description about yourself';
                                      }
                                      return null;
                                    },
                                    onFieldSubmitted: (value) {
                                      aboutFocusNode.unfocus();
                                    },
                                  ),
                              ],
                            ),
                            if (!isAgent) const SizedBox(height: 40),
                            Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: Consumer(
                                builder: (BuildContext context, WidgetRef ref,
                                    Widget? child) {
                                  return Container(
                                    height: context.height * 0.06,
                                    width: context.width * 0.7,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        //color: Theme.of(context).primaryColor,
                                        gradient: gradient()),
                                    child: Center(
                                      child: authRepo.isLoading
                                          ? const Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            )
                                          : const Text(
                                              'Create Account',
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white),
                                            ),
                                    ),
                                  ).onTap(
                                    () {
                                      if (_formKey.currentState!.validate() &&
                                          imagePicked != null) {
                                        final userModel = UserModel(
                                          userName: nameController.text,
                                          userRole:
                                              isAgent ? "Agent" : "Customer",
                                          email: emailController.text,

                                          phone: phoneController.text,
                                          location: addressController.text,
                                          image: imagePicked,
                                          companyName: companyController.text,
                                          description: aboutController.text,
                                          // id: user user!.uid ,
                                        );
                                        ref
                                            .read(authNotifierProvider.notifier)
                                            .signInWithEmailAndPassword(
                                              emailController.text,
                                              passwordController.text,
                                              userModel,
                                              context,
                                            );
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => const App(),
                                          ),
                                        );
                                      }

                                      showSnackBar(
                                        context,
                                        imagePicked == null
                                            ? 'Upload an Image for identification'
                                            : 'Please fix the errors in red before submitting',
                                      );
                                    },
                                  );
                                },
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 40.0),
                              child: Row(
                                children: [
                                  const Text('Already have an account?'),
                                  TextButton(
                                    onPressed: () {},
                                    style: TextButton.styleFrom(),
                                    child: Text(
                                      'Log in',
                                      style: TextStyle(
                                          color:
                                              Theme.of(context).primaryColor),
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
