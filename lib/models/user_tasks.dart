import 'package:meta/meta.dart';
import 'package:peeps/models/task.dart';

class UserTasksModel{
  String groupId;
  String groupName;
  String assignmentId;
  String assignmentTitle;
  List tasks;

  UserTasksModel({
    @required this.groupId,
    @required this.groupName,
    @required this.assignmentId,
    @required this.assignmentTitle,
    @required this.tasks,
  });

  static UserTasksModel fromJson(Map<String,dynamic> data){

    List tasks = data['tasks'].map((task){
      return TaskModel.fromJson(task);
    }).toList();

    return UserTasksModel(
      groupId: data['group_id']['\$oid'],
      groupName: data['group_name'],
      assignmentId: data['assignment_id']['\$oid'],
      assignmentTitle: data['assignment_title'],
      tasks: tasks
    );
  }

}