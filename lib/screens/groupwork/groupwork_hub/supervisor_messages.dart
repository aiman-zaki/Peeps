import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:peeps/bloc/bloc.dart';
import 'package:peeps/models/bulletin.dart';
import 'package:peeps/screens/splash_page.dart';


class SupervisorMessagesView extends StatefulWidget {
  SupervisorMessagesView({Key key}) : super(key: key);

  @override
  _SupervisorMessagesViewState createState() => _SupervisorMessagesViewState();
}

class _SupervisorMessagesViewState extends State<SupervisorMessagesView> {
  @override
  Widget build(BuildContext context) {
    final _bloc = BlocProvider.of<SupervisorMessagesBloc>(context);

    _buildMessageList(List<BulletinModel> data){
      return Container(
        padding: EdgeInsets.all(9),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("Lecturer's",style: TextStyle(fontSize: 18),),
            SizedBox(height: 10,),
            data.isEmpty? Center(child: Text("No Lecturer's message"),)  :ListView.builder(
              shrinkWrap: true,
              itemCount: data.length,
              itemBuilder: (context,index){
                return ListTile(
                  title: Text(data[index].title,),
                  trailing: Text(DateFormat.yMd().add_jm().format(data[index].createdDate)),
                );
              },
            ),
          ],
        ),
      );
    }


    return Card(
      child: Container(
        height: 100,
        child: BlocBuilder(
          bloc: _bloc,
          builder: (context,state){
            if(state is InitialSupervisorMessagesState){
              return SplashScreen();
            }
            if(state is LoadingSupervisorMessagesState){
              return Center(child: CircularProgressIndicator(),);
            }
            if(state is LoadedSupervisorMessagesState){
              return _buildMessageList(state.data);
            }
          },
        ),
      ),
    );
  }
}