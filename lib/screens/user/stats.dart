import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peeps/bloc/bloc.dart';
import 'package:peeps/screens/common/tag.dart';
import 'package:peeps/screens/splash_page.dart';

class UserStatsView extends StatefulWidget {
  UserStatsView({Key key}) : super(key: key);

  @override
  _UserStatsViewState createState() => _UserStatsViewState();
}

class _UserStatsViewState extends State<UserStatsView> {
  @override
  Widget build(BuildContext context) {
    final _bloc = BlocProvider.of<StatsBloc>(context);

    _buildStatsData(Map<String,dynamic> data){
      List<Widget> widgets = [];
      List<Widget> peersScore = [];

      widgets.add(
        CustomTag(
          color: Colors.blue,
          text: Text("Groupworks Stats"),
          padding: EdgeInsets.all(12),
        )
      );
      
      data.forEach((k,v){
        if (k != "score"){
          widgets.add(Card(
            child: ListTile(
              title: Text(k),
              trailing: Text(v.toString()),
            ),
          ));
        }
      });
      widgets.add(
        CustomTag(
          color: Colors.blue,
          text: Text("Peers Review"),
          padding: EdgeInsets.all(12),
        )
      );

      data['score'].forEach((k,v){
        widgets.add(Card(
          child: ListTile(
            title: Text(k),
            trailing: Text(v.toString()),
          ),
        ));
      });

      return ListView(
        children: widgets,
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Stats"),
      ),
      body: BlocBuilder(
        bloc: _bloc,
        builder: (context,state){
          if(state is InitialStatsState){
            return SplashScreen();
          }
          if(state is LoadingStatsState){
            return Center(child: CircularProgressIndicator(),);
          }
          if(state is LoadedStatsState){
            return _buildStatsData(state.data);
          }
        },
      ),
    );
  }
}