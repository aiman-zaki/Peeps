import 'package:flutter/material.dart';

class CustomCaptions extends StatelessWidget {

  final text;
  final Color color;

  const CustomCaptions({Key key, this.text, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color _color = Colors.white30;
    if(color != null){
      _color = color;
    }

    return Text(
      "$text",
      style: TextStyle(color: _color),
    );
  }
}