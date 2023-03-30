import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Spinner extends StatelessWidget {
  const Spinner({
    super.key,
    this.size = 80,
  });

  final double size;

  @override
  Widget build(BuildContext context) {
    return SpinKitFadingCircle(
      size: size,
      itemBuilder: (BuildContext context, int index) {
        return DecoratedBox(
          decoration: BoxDecoration(
            color: index.isEven ? Colors.white : Theme.of(context).primaryColor,
          ),
        );
      },
    );
  }
}
