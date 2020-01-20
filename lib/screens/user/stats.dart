import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peeps/bloc/bloc.dart';
import 'package:peeps/models/question.dart';
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
    final _questionBloc = BlocProvider.of<PeersReviewsQuestionsBloc>(context);

    _buildStatsData(Map<String,dynamic> data,List<QuestionModel> questions){
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
        String questionTitle = "Total you have been reviewed";
        for (QuestionModel question in questions){
          if(question.id.contains(k)){
            questionTitle = question.question;
          }
        }

        widgets.add(Card(
          child: ListTile(
            title: Text(questionTitle),
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
            return BlocBuilder(
              bloc: _questionBloc,
              builder: (context,state2){
                if(state2 is InitialPeersReviewsQuestionsState){
                  return SplashScreen();
                }
                if(state2 is LoadingPeersReviewsQuestionsState){
                  return Center(child: CircularProgressIndicator(),);
                }
                if(state2 is LoadedPeersReviewsQuestionsState){
                  return _buildStatsData(state.data,state2.data);
                }
              },
            );
          }
        },
      ),
    );
  }
}