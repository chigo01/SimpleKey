import 'package:flutter/material.dart';
import 'package:simple_key/src/core/theme/theme.dart';
import 'package:simple_key/src/feautures/auth/choice.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: AppTheme.light,
      home: const SelectAuthType(),
    );
  }
}
