import 'package:peeps/configs/notifications.dart';
import 'package:peeps/models/notification.dart';
import 'package:peeps/resources/notify_repository.dart';
class NotificationManager{

  final repository = NotifyRepository();

  void pollingSupervisorNotification(flutterLocalNotificationsPlugin) async {
    
    List<NotificationModel> data = await repository.readSupervisorNonNotified();
    if(data.isNotEmpty){
      LocalNotifications.showNotification(
        flutterLocalNotificationsPlugin,
        body: "Someone submitted Assignment",
        title: "Assignment Done!",
        channelId: "1",
        channelDescription: "haha",
        channelName: "Peeps"
        );
    }
  
  }
}