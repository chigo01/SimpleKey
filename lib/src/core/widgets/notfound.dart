
import 'package:flutter/material.dart';

class NotFoundWidget extends StatefulWidget {
  const NotFoundWidget({super.key, required this.getNotFound});
  final String getNotFound;

  @override
  State<NotFoundWidget> createState() => _NotFoundWidgetState();
}

class _NotFoundWidgetState extends State<NotFoundWidget>
    with TickerProviderStateMixin {
  late AnimationController _controller;

  late Animation<double> _animation;
  late CurvedAnimation _curve;

  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    _curve = CurvedAnimation(parent: _controller, curve: Curves.slowMiddle);

    _animation = Tween<double>(begin: 1, end: 3).animate(_curve)
      ..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 129,
      child: Column(
        children: [
          Expanded(
            child: AnimatedBuilder(
              animation: _animation,
              builder: (BuildContext context, Widget? child) {
                return Transform.scale(
                  scale: _curve.value,
                  child: child,
                );
              },
              child: Image.asset(
                'assets/images/notfound.png',
                height: 120,
                width: 200,
              ),
            ),
          ),
          Expanded(
            child: Text(
              widget.getNotFound,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
