import 'package:meta/meta.dart';
import 'package:peeps/models/task.dart';
import 'package:peeps/resources/base_respository.dart';
import 'package:peeps/resources/common_repo.dart';

class TasksRepository extends BaseRepository{

  TasksRepository({
    @required data,
  }):super(baseUrl:groupworksUrl,data:data);

  readTasks() async {
    var data = await super.read(namespace: "tasks");
    List<TaskModel> tasks = [];
    for(Map<String,dynamic> task in data){
      tasks.add(TaskModel.fromJson(task));
    }
    return tasks;
  }

  readTask() async {
    var data = super.read(namespace: "");
  }

  createTask({@required data}) async {
    await super.create(data: data,namespace: "tasks");
  }

  updateTask({@required data}) async {
    await super.update(data: data,namespace: "${data['_id']}/task");
  }

  deleteTask({@required id}) async {
    await super.delete(namespace: "$id/task");
  }

  updateTaskStatus({@required data}) async {
    await super.update(data: {
      "tasks":data,
    },namespace: "tasks/status");
  }

  readRequests() async {
    var data = await super.read(namespace: "tasks/requests");
    return data.map((request){
      return TaskRequestModel.fromJson(request);
    }).toList().cast<TaskRequestModel>();
    
  }

  createRequest({@required data}) async {
    await super.create(data: data,namespace: "tasks/requests");
  }

  updateRequest({@required data}) async {
    await super.update(data: data,namespace: "tasks/requests");
  }

}