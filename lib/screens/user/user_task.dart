import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
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

    _datePicker(task) async {
      var data = await showDatePicker(
          context: context,
          firstDate: DateTime.now(),
          initialDate: DateTime.now(),
          lastDate: task.dueDate);

      if (data != null) {
        await _localNotifications.scheduleNotification(
            flutterLocalNotificationsPlugin, data, task);
      }
    }

    _buildTasksList(tasks) {
      return Container(
        child: ListView.builder(
            shrinkWrap: true,
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(tasks[index].task),
                subtitle: Text(DateFormat.yMd().format(tasks[index].dueDate)),
                trailing: InkWell(
                  child: Icon(Icons.notifications),
                  onTap: () {
                    _datePicker(tasks[index]);
                  },
                ),
              );
            }),
      );
    }

    _buildData(data) {
      return SizedBox(
        height: 250,
        child: GridView.builder(
          gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1,
          ),
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemCount: data.length,
          itemBuilder: (context, index) {
            if (!data.isEmpty) {
              return Container(
                decoration: BoxDecoration(),
                padding: EdgeInsets.all(9),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      '${data[index].groupName}',
                      style: TextStyle(fontSize: 18, color: Colors.indigo[200]),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Assignment: ${data[index].assignmentTitle}',
                      style: TextStyle(fontSize: 15, color: Colors.indigo[100]),
                    ),
                    Container(
                        height: 170, child: _buildTasksList(data[index].tasks)),
                  ],
                ),
              );
            } else {
              return Card(
                child: Column(
                  children: <Widget>[
                    Text("No Tasks Assigned to"),
                  ],
                ),
              );
            }
          },
        ),
      );
    }

    final size = MediaQuery.of(context).size;

    return BlocBuilder<UserTaskBloc, UserTaskState>(
      bloc: _bloc,
      builder: (context, state) {
        if (state is InitialUserTaskState) {
          _bloc.add(LoadUserTaskEvent());
          return Container();
        }
        if (state is LoadingUserTaskState) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is LoadedUserTaskState) {
          return Container(
            height: 350,
            padding: EdgeInsets.all(3.0),
            child: Card(
         
              child: Stack(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Keep Track With Your Tasks!",
                          style: TextStyle(fontSize: 20),
                        ),
                        Divider(
                          thickness: 2.0,
                          height: 15,
                          color: Colors.lightBlue[700],
                        ),
                          _buildData(state.data),
                      ],
                      
                    ),
                  ),
                
                  Positioned(
                    bottom: 0,
                    child: ClipPath(
                      clipper: WaveClipperOne(reverse: true),
                      child: Container(
                        width: size.width,
                        height: 80,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(colors: [
                          Colors.lightBlue[700],
                          Colors.lightBlue[800],
                          Colors.lightBlue[900],
                        ])),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
