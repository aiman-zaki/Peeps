import 'package:flutter/material.dart';

class CustomStackFrontBody extends StatelessWidget {
  final double width;
  final double height;
  final Widget child;
  final Color color;

  const CustomStackFrontBody({
    Key key,
    this.width,
    this.height,
    @required this.child,
    @required this.color,
    }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: const EdgeInsets.all(6.0),
      child: Card(
        elevation: 0.00,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
        color: color,
        child: child,
      ),
    );
  }
}