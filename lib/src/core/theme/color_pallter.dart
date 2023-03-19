import 'package:flutter/material.dart';

class AppColor {
  static const Color primaryColor = Color(0xff2c325b);
  static const Color scaFoldBackgroundColor = Color(0xffe5e4e9);
  static const Color secondaryColor = Color(0xff291949);
  static const Color tertiaryColor = Color(0xffB83943);
  static const Color quaternaryColor = Color(0xffFDB18B);
}

LinearGradient gradient() {
  return const LinearGradient(
    colors: [
      Color(0xff35275C),
      Color(0xff291949),
      Color(0xffB83943),
      Color(0xffFDB18B),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    stops: [0.0, 0.1, 0.5, 1.0],
  );
}
