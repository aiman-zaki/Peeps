import 'package:flutter/material.dart';

class CustomLinearProgressBar extends StatefulWidget {
  final createdDate;
  final dueDate;

  CustomLinearProgressBar({
    Key key, 
    this.createdDate, 
    this.dueDate}) : super(key: key);

  _CustomLinearProgressBarState createState() => _CustomLinearProgressBarState();
}

class _CustomLinearProgressBarState extends State<CustomLinearProgressBar> {
  @override
  Widget build(BuildContext context) {
    
    
    final size = MediaQuery.of(context).size;
    
    
    
    
    return Container(
      width: double.infinity,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[

        ],
      ),
    );
  }
}