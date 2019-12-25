import 'package:meta/meta.dart';
import 'package:peeps/models/task.dart';
import 'package:peeps/resources/base_respository.dart';
import 'package:peeps/resources/common_repo.dart';

class TaskRepository extends BaseRepository{
  final String data;
  final String data2;
  
  TaskRepository({
    @required this.data,
    @required this.data2
  }):super(baseUrl:groupworksUrl,data:data,data2:data2);

  readTaskItems() async {
    var data =  await super.read(namespace: 'task/items');
    return data.map((value){
      return TaskItemsModel.fromJson(value);
    }).toList().cast<TaskItemsModel>();
  }

  readTaskReviews() async {
    var data =  await super.read(namespace: 'task/reviews');
    return data.map((value){
      return TaskReviewsModel.fromJson(value);
    }).toList().cast<TaskReviewsModel>();
  }
 
  updateTaskItems({@required data}) async{
    await super.create(data: data,namespace: "task/items");
  }

  updateTaskReview({@required data}) async{
    await super.create(data: data,namespace: "task/reviews");
  }

  updateTaskReviewApproval({@required data}) async {
    await super.update(data: data,namespace: "task/reviews/approval");
  }

  updateAcceptTaskSolution({@required data}) async {
    await super.update(data: data,namespace: "task/accepted_date");
  }


}