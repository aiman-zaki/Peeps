import 'package:meta/meta.dart';
import 'package:peeps/models/notification.dart';
import 'package:peeps/models/question.dart';
import 'package:peeps/resources/base_respository.dart';
import 'package:peeps/resources/common_repo.dart';

class NotifyRepository extends BaseRepository{
  NotifyRepository(
  ):super(baseUrl:notifyUrl);

  readSupervisorNonNotified() async {
    var data = await super.read(namespace: 'supervisor/notified');
    print(data);
    return data.map((notify){
       return NotificationModel.fromJson(notify);
    }).toList().cast<NotificationModel>();
  }

}