import 'package:flutter/material.dart';

class CustomGradientButton extends StatelessWidget {
  final List<Color> colors;
  final Widget child;
  final Function onPressed;
  const CustomGradientButton({
    Key key,
    this.colors,
    this.child,
    this.onPressed,
    }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
  
      onPressed: onPressed,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(80))),
      child: Container(
    
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: colors,
          ),
          borderRadius: BorderRadius.all(Radius.circular(60))
        ),
        padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        child: child,
      ),
    );
  }
}