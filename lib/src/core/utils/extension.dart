import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

extension ContextExtension on BuildContext {
  double getHeight([double height = 1]) {
    assert(height != 0);
    return MediaQuery.of(this).size.height * height;
  }

  double getWidth([double width = 1]) {
    assert(width != 0);
    return MediaQuery.of(this).size.width * width;
  }

  double get height => getHeight();
  double get width => getWidth();
}

extension WidgetExtension on Widget {
  GestureDetector onTap(VoidCallback action) {
    return GestureDetector(
      onTap: action,
      child: this,
    );
  }
}

extension Validation on String {
  bool get validatePassword {
    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{6,}$';
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(this);
  }

  bool get isValidEmail {
    return RegExp(
            r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
        .hasMatch(this);
  }

  double get toDouble {
    if (isNotEmpty) {
      return double.parse(this);
    }
    return 0.0;
  }

  int get toInt {
    if (isNotEmpty) {
      return int.parse(this);
    }
    return 0;
  }

  DateTime get toDate {
    if (isNotEmpty) {
      return DateTime.parse(this);
    }
    return DateTime.now();
  }
}

extension TimeStampExtension on Timestamp {
  DateTime get toDateTimeString =>
      DateTime.fromMillisecondsSinceEpoch(millisecondsSinceEpoch);
}

extension FieldValueExtension on FieldValue {
  String get convertToString => '$this';
}

extension NotNullExtension<T> on T? {
  bool get isNotNull => this != null;
  bool get isNull => this == null;
}
