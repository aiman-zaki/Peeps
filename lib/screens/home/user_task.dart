import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:meta/meta.dart';
import 'package:peeps/bloc/user/task/bloc.dart';
import 'package:peeps/configs/notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserTasks extends StatefulWidget {
  UserTasks({Key key}) : super(key: key);

  _UserTasksState createState() => _UserTasksState();
}

class _UserTasksState extends State<UserTasks> {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  LocalNotifications _localNotifications = LocalNotifications();

  @override
  void initState() {
    super.initState();
    var initializationSettingsAndroid = AndroidInitializationSettings('logo');

    var initializationSettings =
        InitializationSettings(initializationSettingsAndroid, null);

    flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  @override
  Widget build(BuildContext context) {
    final _bloc = BlocProvider.of<UserTaskBloc>(context);

    _checkButtonNotifyPressed() async {
      SharedPreferences _pref = await SharedPreferences.getInstance();
      var data = _pref.getBool("as");
      return data;
    }

    _buildTasksList(tasks) {
      return ListView.builder(
        shrinkWrap: true,
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          return FutureBuilder(
            future: _checkButtonNotifyPressed(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                print(snapshot.data);
                return Column(children: <Widget>[
                  Text(tasks[index].task),
                  Text(tasks[index].dueDate.toString()),
                  RaisedButton(
                    child: Text("Notifications"),
                    onPressed: () async {
                      await _localNotifications.scheduleNotification(
                          flutterLocalNotificationsPlugin,
                          tasks[index].dueDate,
                          tasks[index].id);
                    },
                  )
                ]);
              }
              return Container();
            },
          );
        },
      );
    }

    _buildData(data) {
      return SizedBox(
        height: 200,
        child: GridView.builder(
          gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1,
          ),
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemCount: data.length,
          itemBuilder: (context, index) {
            if (!data.isEmpty) {
              return Card(
                child: Container(
                  padding: EdgeInsets.all(9),
                  height: 150,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('From Group : ${data[index].groupName}'),
                      Text('From Assignment: ${data[index].assignmentTitle}'),
                      _buildTasksList(data[index].tasks),
                    ],
                  ),
                ),
              );
            }
            return Container();
          },
        ),
      );
    }

    return BlocBuilder<UserTaskBloc, UserTaskState>(
      bloc: _bloc,
      builder: (context, state) {
        if (state is InitialUserTaskState) {
          _bloc.dispatch(LoadUserTaskEvent());
          return Container();
        }
        if (state is LoadingUserTaskState) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is LoadedUserTaskState) {
          return Container(
            padding: EdgeInsets.all(9),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text("Keep Track on Your Latest Task!"),
                SizedBox(
                  height: 15,
                ),
                _buildData(state.data),
              ],
            ),
          );
        }
      },
    );
  }
}
