import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peeps/bloc/bloc.dart';
import 'package:peeps/enum/approval_enum.dart';
import 'package:peeps/models/task.dart';
import 'package:peeps/screens/common/withAvatar_dialog.dart';
import 'package:peeps/screens/groupwork/kanban/task_review.dart';
import 'package:peeps/screens/groupwork/task_form.dart';

import 'dialog_card_task.dart';

class CardTask extends StatelessWidget {
  final TaskModel task;

  const CardTask({Key key, this.task}) : super(key: key);

  Color _cardColorSwitch(int priority) {
    switch (priority) {
      case (1):
        return Colors.red[800];
      case (2):
        return Colors.amber;
      case (3):
        return Colors.yellow[700];
      default:
        return Colors.grey[700];
    }
  }

  @override
  Widget build(BuildContext context) {
    final _taskBloc = BlocProvider.of<TaskBloc>(context);
    final _membersBloc = BlocProvider.of<MembersBloc>(context);
    final _timelineBloc = BlocProvider.of<TimelineBloc>(context);

    Color _color = _cardColorSwitch(task.priority);

    void _showDialog(BuildContext context, TaskModel task, Color _headerColor) {
      showDialog(
          context: (context),
          builder: (BuildContext context) => BlocProvider.value(
                value: _taskBloc,
                child: BlocProvider.value(
                    value: _membersBloc,
                    child: BlocProvider.value(
                        value: _timelineBloc,
                        child: DialogTaskCard(
                            task: task, headerColor: _headerColor))),
              ));
    }

    return GestureDetector(
      onTap: () {
        _showDialog(context, task, _color);
      },
      child: Card(
        margin: EdgeInsets.all(2),
        color: _color,
        child: Padding(
          padding: EdgeInsets.all(3),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text(
                task.task,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Text(
                  '${task.assignTo.split("@")[0]}',
                  style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

