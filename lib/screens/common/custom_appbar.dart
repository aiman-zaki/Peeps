import 'package:flutter/material.dart';


class CustomAppBar extends StatefulWidget {
  final String title;
  final BoxDecoration decoration;
  final double barHeight = 50.0;

  CustomAppBar({Key key,this.title,this.decoration}) : super(key: key);
  _CustomAppBarState createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    final double statusbarHeight = MediaQuery.of(context).padding.top;
    
    return Container(
       padding: EdgeInsets.only(top: statusbarHeight),
       height: statusbarHeight+widget.barHeight,
       decoration: widget.decoration != null ? widget.decoration : null,
       child: Text(
         widget.title,
         style: TextStyle(fontSize: 20.0,color: Colors.white,fontWeight: FontWeight.bold),
       ),
    );
  }
}