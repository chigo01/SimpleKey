import 'package:flutter/material.dart';
import 'package:simple_key/src/core/route/route.dart';

extension RouteContext on BuildContext {
  Future<T?> push<T>(Widget page) =>
      Navigator.push<T>(this, PageRouter.fadeTransition(page));

  Future<bool> maybePop<T>([T? result]) {
    return Navigator.maybePop(this, result);
  }

  Future<T?> pushTransition<T>(Widget page) =>
      Navigator.push<T>(this, PageRouter.slideTransition(page));
}
