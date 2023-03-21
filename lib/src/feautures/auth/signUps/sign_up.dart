import 'package:flutter/material.dart';
import 'package:simple_key/src/core/presentation/views/app.dart';
import 'package:simple_key/src/core/route/route_navigation.dart';
import 'package:simple_key/src/core/theme/color_pallter.dart';
import 'package:simple_key/src/core/utils/extension.dart';
import 'package:simple_key/src/feautures/auth/presentation/widget/text_field.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key, required this.isAgent});
  final bool isAgent;

  @override
  Widget build(BuildContext context) {
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
        //  keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
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
                        onPressed: () => context.maybePop(),
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
                    child: Image.asset(
                      "assets/images/Camera.png",
                      height: 70,
                      width: 100,
                    ),
                    /*const Icon(
                      Icons.person,
                      size: 50,
                      color: Colors.blue,
                    ),*/
                  ),
                  Text('Add Image')
                ],
              ).onTap(
                () => showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return Container(
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
                            onTap: () {},
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
                            onTap: () {},
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 10),
              Container(
                height: height,
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
                          const TextFieldColumn(
                            headerText: 'Name',
                            hintText: "Steve Jobs",
                            maxLines: 1,
                          ),
                          const TextFieldColumn(
                            headerText: 'Email',
                            hintText: "tim@gmail.com",
                            maxLines: 1,
                          ),
                          const TextFieldColumn(
                            headerText: 'Phone Number',
                            hintText: "08012345678",
                            maxLines: 1,
                          ),
                          const TextFieldColumn(
                            headerText: 'Password',
                            hintText: "Pick a strong password",
                            maxLines: 1,
                          ),
                          const TextFieldColumn(
                            headerText: 'Location',
                            hintText: "Lagos, Nigeria",
                            maxLines: 1,
                          ),
                          if (isAgent)
                            const TextFieldColumn(
                              headerText: 'Company Name',
                              hintText: "LandMark",
                              maxLines: 1,
                            ),
                          if (isAgent)
                            const TextFieldColumn(
                              headerText: "About Me",
                              hintText: "I am a real estate agent",
                              maxLength: 200,
                              maxLines: 8,
                            ),
                        ],
                      ),
                      if (!isAgent) const SizedBox(height: 40),
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Container(
                          height: context.height * 0.06,
                          width: context.width * 0.7,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              //color: Theme.of(context).primaryColor,
                              gradient: gradient()),
                          child: const Center(
                            child: Text(
                              'Create Account',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                        ).onTap(() => Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const App(),
                              ),
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40.0),
                        child: Row(
                          children: [
                            const Text('Already have an account?'),
                            TextButton(
                              onPressed: () {},
                              style: TextButton.styleFrom(),
                              child: Text(
                                'Log in',
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor),
                              ),
                            )
                          ],
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
    );
  }
}
