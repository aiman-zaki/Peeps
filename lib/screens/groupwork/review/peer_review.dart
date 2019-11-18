import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peeps/bloc/groupwork/bloc.dart';
import 'package:peeps/enum/status_enum.dart';
import 'package:peeps/models/assignment.dart';
import 'package:peeps/models/member.dart';
import 'package:peeps/models/peer_reviews.dart';
import 'package:peeps/models/peer_review.dart';
import 'package:peeps/resources/assignment_repository.dart';
import 'package:peeps/resources/questions_repository.dart';
import 'package:peeps/screens/groupwork/review/peer_review_question.dart';
import 'package:peeps/screens/splash_page.dart';

class PeersReviewView extends StatefulWidget {
  final AssignmentModel assignment;

  PeersReviewView({Key key, @required this.assignment}) : super(key: key);

  @override
  _PeersReviewViewState createState() => _PeersReviewViewState();
}

class _PeersReviewViewState extends State<PeersReviewView> {
  bool pass = true;

  @override
  void initState() {
    super.initState();
    int days = widget.assignment.dueDate.difference(DateTime.now()).inDays;
    if (days > 0 && widget.assignment.status != Status.done) pass = false;
  }

  @override
  Widget build(BuildContext context) {
    final _membersBloc = BlocProvider.of<MembersBloc>(context);
    final _bloc = BlocProvider.of<PeerReviewBloc>(context);

    _buildMembers({@required PeerReviewsModel data, @required MemberModel member}) {
      bool reviewed = false;
      PeerReviewModel reviewedAnswer;
      for(PeerReviewModel review in data.peerReviews){
        if(review.reviewee == member.email)
          reviewed = true;
          reviewedAnswer = review;
      }
      return ListTile(
        title: Text(member.email),
        trailing: reviewed? Text("Reviewed"):Text("Nope"),
        onTap: () {
          if(!reviewed){
            Navigator.of(context).push(CupertinoPageRoute(
              builder: (context) => BlocProvider(
                  builder: (context) => PeersReviewsQuestionsBloc(
                      assignmentRepository:
                          AssignmentRepository(data: widget.assignment.id),
                      repository: QuestionsRepository())
                    ..add(ReadPeersReviewsQuestions()),
                  child: PeerReviewQuestionsView(
                    reviewed: reviewed,
                    assignmentId: widget.assignment.id,
                    reviewee: member.email,
                  ))));
          }
        },
      );
    }

    return Scaffold(
        appBar: AppBar(
          title: Text("Peers Reviews"),
        ),
        body: BlocBuilder(
          bloc: _membersBloc,
          builder: (context, memberState) {
            if (memberState is LoadedMembersState) {
              return Container(
                  child: !pass
                      ? Center(
                          child: Text("Asessment Still Ongoing"),
                        )
                      : BlocBuilder(
                          bloc: _bloc,
                          builder: (context, state) {
                            if (state is InitialPeerReviewState) {
                              return SplashScreen();
                            }
                            if (state is LoadingPeerReviewState) {
                              return CircularProgressIndicator();
                            }
                            if (state is LoadedPeerReviewState) {
                              return Column(
                                children: <Widget>[
                                  Expanded(
                                    child: ListView.builder(
                                      itemCount: memberState.data.length,
                                      itemBuilder: (context, index) {
                                        return _buildMembers(
                                            member: memberState.data[index],
                                            data: state.data);
                                      },
                                    ),
                                  ),
                                ],
                              );
                            }
                          },
                        ));
            }
          },
        ));
  }
}
