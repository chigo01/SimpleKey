import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:simple_key/src/core/route/route_navigation.dart';
import 'package:simple_key/src/core/theme/color_pallter.dart';
import 'package:simple_key/src/core/utils/extension.dart';
import 'package:simple_key/src/feautures/auth/data/controller/provider/provider.dart';
import 'package:simple_key/src/feautures/auth/signUps/login.dart';
import 'package:simple_key/src/feautures/auth/signUps/sign_up.dart';

class SelectAuthType extends StatelessWidget {
  const SelectAuthType({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Profile Type',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          //  crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // const Spacer(),
            SizedBox(height: context.height * 0.02),
            SizedBox(
              child: Text.rich(
                TextSpan(
                  text: 'Do you have an account? ',
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 45, 45, 45),
                  ),
                  children: [
                    TextSpan(
                      text: "Login",
                      style: TextStyle(
                          color: Theme.of(context).primaryColor, fontSize: 15),
                    ),
                  ],
                ),
              ).onTap(
                () => context.push(
                  const LoginScreen(),
                ),
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "Select your profile type according to your needs, to sell your property or to buy a property",
              style: TextStyle(
                fontSize: 15,
                color: Color.fromARGB(255, 45, 45, 45),
              ),
            ),
            SizedBox(height: context.height * 0.03),

            Expanded(
              flex: 2,
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      height: context.height * 0.5,
                      width: context.width * 0.5,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Theme.of(context).primaryColor,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 40,
                            backgroundColor: Colors.blue.withOpacity(0.2),
                            // backgroundColor: Colors.transparent,
                            child: Image.asset(
                              "assets/images/agent.png",
                              height: 200,
                              width: 100,
                              fit: BoxFit.cover,
                            ),
                            /*const Icon(
                              Icons.person,
                              size: 50,
                              color: Colors.white,
                            ),*/
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            "Agent",
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: context.width * 0.06),
                            child: const Text(
                              "I want to sell my property",
                              maxLines: 2,
                              style: TextStyle(
                                fontSize: 15,
                                color: Color.fromARGB(255, 190, 180, 180),
                              ),
                            ),
                          )
                        ],
                      ),
                    ).onTap(
                      () => context.pushTransition(
                        const SignUpScreen(isAgent: true),
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Container(
                      height: context.height * 0.5,
                      width: context.width * 0.5,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 40,
                            backgroundColor: Colors.blue.withOpacity(0.2),
                            // backgroundColor: Colors.transparent,
                            child: Image.asset(
                              "assets/images/buyer.png",
                              height: 200,
                              width: 100,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            "Customer",
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 12),
                          const Text(
                            "Buy a property",
                            maxLines: 2,
                            style: TextStyle(
                              fontSize: 15,
                              color: Color(0xffbebebe),
                            ),
                          )
                        ],
                      ),
                    ).onTap(
                      () => context.pushTransition(
                        const SignUpScreen(isAgent: false),
                      ),
                    ),
                  )
                ],
              ),
            ),

            const SizedBox(height: 10),

            Expanded(
              child: Consumer(builder:
                  (BuildContext context, WidgetRef ref, Widget? child) {
                return Column(
                  children: [
                    context.height < 700
                        ? Expanded(
                            child: Text(
                              "Or",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).primaryColor),
                            ),
                          )
                        : Text(
                            "Or",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).primaryColor),
                          ),
                    Text(
                      'Sign Up with',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      height: 50,
                      width: 200,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          // color: Colors.white,
                          gradient: gradient()),
                      child: Center(
                        child: Image.asset(
                          "assets/images/google.jpg",
                          height: 30,
                        ),
                      ),
                    ).onTap(() {
                      context.pushTransition(const SignUpScreen(isAgent: true));
                      ref
                          .read(authNotifierProvider.notifier)
                          .signInWithGoogle(context);
                    }),
                    const SizedBox(height: 10),
                    const Text("Note : You can only be signed up as a Buyer")
                  ],
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
