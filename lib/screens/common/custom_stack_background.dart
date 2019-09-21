import 'package:flutter/material.dart';

class CustomStackBackground extends StatelessWidget {
  final width;
  final height;
  final Widget child;
  final Color color;
  const CustomStackBackground({
    Key key,
    this.width,
    this.height,
    @required this.child,
    @required this.color,
    }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          color: color,
          elevation: 0.00,
          child: child,
        ),
      );
  }
}