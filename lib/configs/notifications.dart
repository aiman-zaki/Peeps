import 'dart:typed_data';


import 'package:flutter/rendering.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:meta/meta.dart';

class LocalNotifications {

  Future<int> _notificationsId()  async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    int ids = preferences.getInt("tasks");
    if(ids == null){
      ids = 0;
    }
    return ids;
  }

  _incrementId(id) async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setInt("tasks", (id+1));
    
  }

  static Future<void> showNotification(flutterLocalNotificationsPlugin,{@required channelId,@required channelName,@required channelDescription,@required title,@required body}) async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        '$channelId', '$channelName', '$channelDescription',
        importance: Importance.Max, priority: Priority.High, ticker: 'ticker');
    //var iOSPlatformChannelSpecifics = IOSNotificationDetails();

    var platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, null);
    await flutterLocalNotificationsPlugin.show(
        0, '$title', '$body', platformChannelSpecifics,
        payload: 'item x');
  }

  Future<void> scheduleNotification(
    flutterLocalNotificationsPlugin, DateTime datetime,task) async {
    
    var scheduledNotificationDateTime =
      datetime;
    var vibrationPattern = Int64List(4);
    vibrationPattern[0] = 0;
    vibrationPattern[1] = 1000;
    vibrationPattern[2] = 5000;
    vibrationPattern[3] = 2000;

    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        '', 'Peeps', 'your channel description',
        importance: Importance.Max, priority: Priority.High, ticker: 'ticker');
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.schedule(
      task.seq,
      'Task : ${task.task}',
      'Due Date : ${task.dueDate}',
      scheduledNotificationDateTime,
      platformChannelSpecifics);
  }


  Future<void> checkPendingNotificationRequests(flutterLocalNotificationsPlugin) async {
    var pendingNotificationRequests =
        await flutterLocalNotificationsPlugin.pendingNotificationRequests();

        
    for (var pendingNotificationRequest in pendingNotificationRequests) {
      debugPrint(
          'pending notification: [id: ${pendingNotificationRequest.id}, title: ${pendingNotificationRequest.title}, body: ${pendingNotificationRequest.body}, payload: ${pendingNotificationRequest.payload}]');
    }
  }
}

  