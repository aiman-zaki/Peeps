import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
class CustomTag extends StatelessWidget {
  final Text text;
  final Color color;
  final EdgeInsetsGeometry padding;
  const CustomTag(
    {
      Key key,
      @required this.text,
      @required this.color,
      @required this.padding
    }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 1.00,
        color: color,
        child: Padding(
          padding: padding,
          child: text,
        ),
    );
  }
}