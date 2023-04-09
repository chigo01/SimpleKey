import 'package:device_preview/device_preview.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:simple_key/src/core/theme/theme.dart';
import 'package:simple_key/src/feautures/Home%20Screen/presentation/views/app.dart';
import 'package:simple_key/src/feautures/auth/choice.dart';
import 'package:stack_trace/stack_trace.dart' as stack_trace;

import 'firebase_options.dart';

void main() async {
  FlutterError.demangleStackTrace = (StackTrace stack) {
    if (stack is stack_trace.Trace) return stack.vmTrace;
    if (stack is stack_trace.Chain) return stack.toTrace().vmTrace;
    return stack;
  };
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
      //const MyApp()
      const ProviderScope(
    // child: DevicePreview(
    //   enabled: !kReleaseMode,
    //   builder: (context) => const MyApp(),
    // ),
    child: MyApp(),
  ));
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // FirebaseAuth auth = FirebaseAuth.instance;
    // User? user = auth.authStateChanges();

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        scrollBehavior: MyCustomScrollBehavior(),
        useInheritedMediaQuery: true,
        locale: DevicePreview.locale(context),
        builder: DevicePreview.appBuilder,
        title: 'Flutter Demo',
        theme: AppTheme.light,
        home:
            const AuthStateListener() //user != null ? const App() : const SelectAuthType(),
        );
  }
}

class AuthStateListener extends StatefulWidget {
  const AuthStateListener({super.key});

  @override
  State<AuthStateListener> createState() => _AuthStateListenerState();
}

class _AuthStateListenerState extends State<AuthStateListener> {
  late Stream<User?> _authStateChangesStream;

  @override
  void initState() {
    super.initState();
    _authStateChangesStream = FirebaseAuth.instance.authStateChanges();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: _authStateChangesStream,
      builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          User? user = snapshot.data;
          if (user == null) {
            // User is not logged in
            return const SelectAuthType();
          } else {
            // User is logged in
            return const App();
          }
        } else {
          // Connection state is not yet known, return a loading spinner
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}
