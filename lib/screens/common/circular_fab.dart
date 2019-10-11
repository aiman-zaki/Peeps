import 'dart:math';

import 'package:flutter/material.dart';
import 'package:vector_math/vector_math.dart' show radians;

class CircularFab extends StatefulWidget {

  _CircularFabState createState() => _CircularFabState();
}

class _CircularFabState extends State<CircularFab> with SingleTickerProviderStateMixin{
  AnimationController controller;

  @override
  void initState() {

    super.initState();
    controller = AnimationController(duration: Duration(milliseconds: 400),vsync: this);
  }
  
  @override
  Widget build(BuildContext context) {
    return CustomAnimation(controller: controller);
  }


  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

class CustomAnimation extends StatelessWidget{
  final AnimationController controller;
  final Animation<double> scale;
  final Animation<double> translation;
  final Animation<double> rotation;
  CustomAnimation({Key key,this.controller}) : 
      translation = Tween<double>(
      begin: 0.0,
      end: 70.0,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.easeInCubic
      ),
    ),
    scale = Tween<double>(
      begin: 1.0,
      end: 0.0,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.fastOutSlowIn, 
      ),
    ),


    rotation = Tween<double>(
      begin: 0.0,
      end: 360.0
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(
          0.0,0.7,
          curve: Curves.linear,
        )
      ),
    ),
  super(key:key);

  
  _open() {
    controller.forward();
  }

  _close() {
    controller.reverse();
  }
   
  _buildButton(double height, {Color color, IconData icon}){
    final double rad = radians(height);
    return Transform(
    transform: Matrix4.identity()..translate((translation.value) * cos(rad),(translation.value) * sin(rad)),
      child: FloatingActionButton(
        heroTag: null,
        child: Icon(icon),
        onPressed: _close,
        elevation: 0,
      )
    );
  }


  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context,widget){
        return Transform.rotate(
          angle: radians(rotation.value),
          
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
      
            _buildButton(170, color: Colors.black, icon:Icons.add),
            _buildButton(225, color: Colors.indigo, icon:Icons.add),
            _buildButton(280, color: Colors.pink, icon: Icons.add),
       
              Transform.scale(
                scale: scale.value -1.0,
                child: FloatingActionButton(
                  mini: true,
                  heroTag: null,
                  child: Icon(Icons.add),
                  onPressed: _close,
                ),
              ),
               Transform.scale(
                  scale: scale.value,
                  child: FloatingActionButton(
                    heroTag: null,
                    child: 
                    Icon(Icons.add), 
                    onPressed: _open
                  ),
                )
              
            ],
          ),
        );
      }
    );
  }

 


}