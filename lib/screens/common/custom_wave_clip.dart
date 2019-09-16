import 'package:flutter/material.dart';

class CustomWaveClipper extends CustomClipper<Path>{
  CustomWaveClipper();

  @override
  Path getClip(Size size){
    Offset firstCycleStart = Offset(size.width/4,0.0);
    Offset firstCycleEnd = Offset(size.width/2.25,30.0);
    Offset secondCycleStart = Offset(size.width-(size.width/4.25),size.height-65);
    Offset secondCycleEnd = Offset(size.width,size.height-40);
  
    final path = Path()
      ..lineTo(0.0, size.height)
      ..quadraticBezierTo(firstCycleStart.dx,firstCycleStart.dy, firstCycleEnd.dx, firstCycleEnd.dy)
      ..quadraticBezierTo(secondCycleStart.dx, secondCycleStart.dy, secondCycleEnd.dx, secondCycleEnd.dy)
      ..lineTo(size.width, size.height-40)
      ..lineTo(size.width, 0.0)
      ..close();
      return path;
  }


  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return true;
  }}