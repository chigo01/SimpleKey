import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:simple_key/src/core/route/route_navigation.dart';
import 'package:simple_key/src/core/theme/color_pallter.dart';
import 'package:simple_key/src/core/utils/extension.dart';
import 'package:simple_key/src/core/widgets/loading_indicator.dart';
import 'package:simple_key/src/feautures/Home%20Screen/presentation/views/app.dart';
import 'package:simple_key/src/feautures/auth/choice.dart';
import 'package:simple_key/src/feautures/auth/data/controller/provider/provider.dart';
import 'package:simple_key/src/feautures/auth/model/authmodel.dart';
import 'package:simple_key/src/feautures/auth/presentation/widget/text_field.dart';

final _obscureText = StateProvider<bool>((ref) => false);

class LoginScreen extends HookConsumerWidget {
  const LoginScreen({super.key});
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();
    FocusNode emailFocusNode = useFocusNode();
    FocusNode passwordFocusNode = useFocusNode();
    final passwordVisibility = ref.watch(_obscureText);
    final authRepo = ref.watch(authNotifierProvider);
    // authRepo = false;

    return Scaffold(
      body: SafeArea(
        child: authRepo
            ? const Spinner()
            : SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Login',
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge
                              ?.copyWith(
                                  fontSize: 40, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 30),
                        SizedBox(
                          child: Text.rich(
                            TextSpan(
                              text: 'Don\'t have an account? ',
                              children: [
                                TextSpan(
                                  text: "Register",
                                  style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      fontSize: 15),
                                ),
                              ],
                            ),
                          ).onTap(
                            () => context.push(
                              const SelectAuthType(),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: context.height * 0.5, //height,
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
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
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
                                          .requestFocus(passwordFocusNode);
                                    },
                                  ),
                                  TextFieldColumn(
                                    headerText: 'Password',
                                    hintText: "Input Password",
                                    maxLines: 1,
                                    controller: passwordController,
                                    obscureText: passwordVisibility,
                                    focusNode: passwordFocusNode,
                                    obscuringCharacter:
                                        !passwordVisibility ? '.' : '◉',
                                    suffixIcon: IconButton(
                                      onPressed: () => ref
                                          .read(_obscureText.notifier)
                                          .update((state) => !state),
                                      icon: Icon(
                                        passwordVisibility
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                        color: Theme.of(context).primaryColor,
                                      ),
                                    ),
                                    onFieldSubmitted: (value) {
                                      passwordFocusNode.unfocus();
                                    },
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Please enter your password';
                                      }
                                      if (value.length < 6) {
                                        return 'Password must be at least 6 characters';
                                      }
                                      return null;
                                    },
                                  ),
                                  const SizedBox(height: 10),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(30.0),
                          child: Container(
                            height: context.height * 0.06,
                            width: context.width * 0.7,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                //color: Theme.of(context).primaryColor,
                                gradient: gradient()),
                            child: const Center(
                              child: Text(
                                'Sign In',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                          ).onTap(() {
                            if (_formKey.currentState!.validate()) {
                              // _formKey.currentState!.save();
                              ref
                                  .read(authNotifierProvider.notifier)
                                  .signInWithEmailAndPassword(
                                      email: emailController.text,
                                      password: passwordController.text,
                                      context: context,
                                      ref: ref);

                              if (ref.watch(authStateProvider) ==
                                  AuthState.successful) {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const App(),
                                  ),
                                );
                              }
                            }
                            // ref.watch(authStateProvider.notifier).update((state) => )
                          }),
                        )
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
