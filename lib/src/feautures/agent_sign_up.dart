import 'package:flutter/material.dart';
import 'package:simple_key/src/core/route/route_navigation.dart';
import 'package:simple_key/src/core/theme/color_pallter.dart';
import 'package:simple_key/src/core/utils/extension.dart';

class AgentSignUpScreen extends StatelessWidget {
  const AgentSignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
              const SizedBox(height: 20),
              Container(
                height: context.height * 1.2,
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
                        children: const [
                          TextFieldColumn(
                            headerText: 'Name',
                            hintText: "Steve Jobs",
                          ),
                          TextFieldColumn(
                            headerText: 'Email',
                            hintText: "tim@gmail.com",
                          ),
                          TextFieldColumn(
                            headerText: 'Phone Number',
                            hintText: "08012345678",
                          ),
                          TextFieldColumn(
                            headerText: 'Password',
                            hintText: "Pick a strong password",
                          ),
                          TextFieldColumn(
                            headerText: 'Location',
                            hintText: "Lagos, Nigeria",
                          ),
                          TextFieldColumn(
                            headerText: 'Company Name',
                            hintText: "LandMark",
                          ),
                          TextFieldColumn(
                            headerText: "About Me",
                            hintText: "I am a real estate agent",
                            maxLength: 200,
                            maxLines: 8,
                          ),
                        ],
                      ),
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
  }
}

class TextFieldColumn extends StatelessWidget {
  const TextFieldColumn({
    super.key,
    required this.hintText,
    required this.headerText,
    this.maxLength,
    this.maxLines,
  });

  final String hintText;
  final String headerText;
  final int? maxLength;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              headerText,
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor),
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: TextFormField(
              maxLength: maxLength,
              maxLines: maxLines,
              decoration: InputDecoration(
                hintText: hintText,
                fillColor: Theme.of(context).primaryColor.withOpacity(0.3),
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(
                    color: Theme.of(context).primaryColor,
                    width: 2,
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
