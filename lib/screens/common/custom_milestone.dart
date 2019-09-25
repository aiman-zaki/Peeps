import 'package:flutter/material.dart';
import 'package:peeps/screens/common/custom_mileston_icon.dart';

class CustomMilestone extends StatelessWidget {
  final int totalGoals;
  final int completedGoals;
  final IconData completedIcon;
  final IconData icon;

  const CustomMilestone({
    Key key, 
    @required this.totalGoals, 
    @required this.completedGoals, 
    @required this.completedIcon, 
    @required this.icon}): 
    super(key: key);


  List<Widget> _buildGoals(){
    List<Widget> totalGoalsIcon = [];
    for(int i = 0 ; i<totalGoals; i++){
      if(i < completedGoals){
        totalGoalsIcon.add(CustomMilestoneIcon(icon: completedIcon,backgroundColor: Colors.green,iconColor: Colors.white70,));
      } else {
        totalGoalsIcon.add(
        CustomMilestoneIcon(icon: icon,backgroundColor: Colors.grey,),
        );
      } 
      if(i != totalGoals-1)
        totalGoalsIcon.add(Expanded(child: Divider(),));
    }
    return totalGoalsIcon;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: _buildGoals(),
      ),
    );
  }
}