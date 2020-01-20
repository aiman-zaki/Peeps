import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peeps/bloc/bloc.dart';
import 'package:peeps/resources/assignment_repository.dart';
import 'package:peeps/resources/questions_repository.dart';
import 'package:peeps/screens/groupwork/review/peer_reviewed_score.dart';

import 'peer_review.dart';


class PeerReviewBase extends StatefulWidget {
  final assignment;
  PeerReviewBase({Key key,@required this.assignment}) : super(key: key);

  @override
  _PeerReviewBaseState createState() => _PeerReviewBaseState();
}

class _PeerReviewBaseState extends State<PeerReviewBase> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Peers Review"),
          bottom: TabBar(
            tabs: <Widget>[
              Tab(child: Text("Peer Review"),),
              Tab(child: Text("Your Score"),)
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            PeersReviewView(assignment: widget.assignment,),
            BlocProvider<PeersReviewsQuestionsBloc>(
              create: (context) => PeersReviewsQuestionsBloc(assignmentRepository: AssignmentRepository(data: widget.assignment.id),repository: QuestionsRepository())..add(ReadPeersReviewsScoredWithQuestion()),
              child: PeerReviewedScoreView(assignment: widget.assignment,)
            ),
          ],
        ),
      ),
    );
  }
}