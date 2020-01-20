import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peeps/bloc/bloc.dart';
import 'package:peeps/enum/status_enum.dart';
import 'package:peeps/screens/splash_page.dart';


class PeerReviewedScoreView extends StatefulWidget {
  final assignment;
  PeerReviewedScoreView({Key key,@required this.assignment}) : super(key: key);

  @override
  _PeerReviewedScoreViewState createState() => _PeerReviewedScoreViewState();
}

class _PeerReviewedScoreViewState extends State<PeerReviewedScoreView> {

  bool pass = true;
  @override
  void initState() { 
    super.initState();
    int days = widget.assignment.dueDate.difference(DateTime.now()).inDays;
    if (days > 0 && widget.assignment.status != Status.done) pass = false;
  }


  @override
  Widget build(BuildContext context) {
    final _bloc = BlocProvider.of<PeersReviewsQuestionsBloc>(context);

    _buildScoredList(data){
      return ListView.builder(
        itemCount: data['questions'].length,
        itemBuilder: (context,index){
          return Card(
            child: ListTile(
              title: Text(data['questions'][index].question),
              trailing: Text("${data['score'][data['questions'][index].id]}"),
            ),
          );
        },
      );
    }

    if(!pass){
      return Center(child: Text("Assignment is still ongoing"));
    }

    return Container(
      child: BlocBuilder(
        bloc:_bloc,
        builder: (context,state){
          if(state is InitialPeersReviewsQuestionsState){
            return SplashScreen();
          }
          if(state is LoadingPeersReviewsQuestionsState){
            return Center(child: CircularProgressIndicator(),);
          }
          if(state is LoadedPeersReviewsQuestionsState){
            return _buildScoredList(state.data);
          }
        },
      )
    );
  }
}