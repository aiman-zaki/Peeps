import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peeps/bloc/bloc.dart';


class PeerReviewedScoreView extends StatefulWidget {
  PeerReviewedScoreView({Key key}) : super(key: key);

  @override
  _PeerReviewedScoreViewState createState() => _PeerReviewedScoreViewState();
}

class _PeerReviewedScoreViewState extends State<PeerReviewedScoreView> {
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

    return Container(
      child: BlocBuilder(
        bloc:_bloc,
        builder: (context,state){
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