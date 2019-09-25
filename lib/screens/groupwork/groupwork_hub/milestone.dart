import 'package:flutter/material.dart';
import 'package:peeps/screens/common/custom_milestone.dart';

class HubMilestone extends StatelessWidget {
  const HubMilestone({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(9.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                flex: 3,
                child: Text(
                  'Milestone',
                  style: TextStyle(color: Colors.green, fontSize: 16),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(9.0),
            child: CustomMilestone(
              totalGoals: 5,
              completedGoals: 2,
              icon: Icons.check_circle_outline,
              completedIcon: Icons.check,
            ),
          ),
        ],
      ),
    );
  }
}
