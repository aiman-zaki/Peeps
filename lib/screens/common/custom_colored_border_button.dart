import 'package:flutter/material.dart';

class CustomColoredBorderButton extends StatelessWidget {
  final Function onPressed;
  final Color borderColor;
  final Widget child;
  
  const CustomColoredBorderButton({
    Key key,
    this.onPressed,
    this.borderColor,
    this.child,
    }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: Colors.blueAccent[500],
          border: Border.all(color: borderColor,width: 2.0),
          borderRadius: BorderRadius.circular(10.0)
        ),
        child: Center(child: child)),
    );
  }
}