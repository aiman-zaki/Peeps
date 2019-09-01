import 'package:flutter/material.dart';

class CustomMilestoneIcon extends StatelessWidget {
  final IconData icon;
  final Color backgroundColor;
  final String label;
  final Color iconColor;


  const CustomMilestoneIcon({Key key, this.icon, this.backgroundColor, this.label, this.iconColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){

      },
      child: CircleAvatar(
        backgroundColor: backgroundColor,
        radius: 15,
        child: Icon(icon,color: iconColor),
      ),
    );
  }
}