import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peeps/bloc/groupwork/bloc.dart';
import 'package:peeps/bloc/user/bloc.dart';
import 'package:peeps/models/peer_review.dart';
import 'package:peeps/models/question.dart';
import 'package:peeps/screens/common/withAvatar_dialog.dart';
import 'package:peeps/screens/groupwork/review/rate_enum.dart';
import 'package:peeps/screens/splash_page.dart';



Map<Rate,dynamic> rateName = {
    Rate.lowest:"Lowest",
    Rate.low:"Low",
    Rate.normal:"Normal",
    Rate.high:"High",
    Rate.highest:"Highest"
};



class PeerReviewQuestionsView extends StatefulWidget {
  final bool reviewed;
  final assignmentId;
  final String reviewee;
  PeerReviewQuestionsView(
    {Key key,
    @required this.reviewed,
    @required this.assignmentId,
    @required this.reviewee}) : super(key: key);

  @override
  _PeerReviewQuestionsViewState createState() => _PeerReviewQuestionsViewState();
}

class _PeerReviewQuestionsViewState extends State<PeerReviewQuestionsView> {
  
  List<QuestionModel> answers;

  Map<String,dynamic> rates = {};
  @override
  void initState() {
    super.initState();
    
  }
  
  @override
  Widget build(BuildContext context) {
    final _bloc = BlocProvider.of<PeersReviewsQuestionsBloc>(context);
    final ProfileLoaded _profileBloc = BlocProvider.of<ProfileBloc>(context).state;

    _buildTableHeaders(){
      List<Widget> headers = [];
      headers.add(
        Expanded(
          child: Text("Question"),
        )
      );
      for(int i = Rate.lowest.index ; i <= Rate.highest.index ; i++){
        Rate cuurrentEnum = Rate.values.elementAt(i);
        headers.add(
          Expanded(
            child: Text(rateName[cuurrentEnum],textAlign: TextAlign.center,),
          )
        );
      }
      return headers;
    }

    _buildRadioButton(index,question){
      List<Widget> radio = [];
      radio.add(
        Expanded(
          child: Text(question.question),
        )
      );
       for(int i = Rate.lowest.index ; i <= Rate.highest.index ; i++){
         Rate cuurrentEnum = Rate.values.elementAt(i);
         radio.add(
           Expanded(
             child: Radio(
               groupValue: question.answer,
               value: cuurrentEnum,
               onChanged: (values){
                 setState(() {
                   question.answer = values;
                 });
               },
             ),
           )
         );
       }
       return radio;
    }
    


    _buildQuestionsList(questions){
      return Container(
        padding: EdgeInsets.all(9),
        child: Column(
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: _buildTableHeaders(),),
            Expanded(
              child: ListView.builder(
                itemCount: questions.length,
                itemBuilder: (context,index){
                  return Column(
                    children: <Widget>[
                      Row(
                        children:_buildRadioButton(index,questions[index]),
                      )
                    ],
                  );
                }
              ),
            ),
          ],
        ),
      );
    }

    _showConfirmationDialog(){
      showDialog(
        context: context,
        builder: (context){
          return DialogWithAvatar(
            avatarIcon: Icon(Icons.check),
            width: 300,
            height: 200,
            title: Text("Confirmation"),
            description: "Are you sure breo",
            bottomRight: FlatButton(
              child: Text("Confirm"),
              onPressed: (){
                  _bloc.add(SubmitPeersReviewQustionsWithAnswers(data: PeerReviewModel(
                    reviewer: _profileBloc.data.email,
                    reviewee: widget.reviewee,
                    answers: answers
                  )));
                  Navigator.of(context).pop();
              },
            ),
          );
        }
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Questions"),
      ),
      body: Container(
        child: Form(
          child: BlocBuilder(
            bloc: _bloc,
            builder: (context,state){
              if(state is InitialPeersReviewsQuestionsState){
                return SplashScreen();
              }
              if(state is LoadingPeersReviewsQuestionsState){
                return Center(child: CircularProgressIndicator(),);
              }
              if(state is LoadedPeersReviewsQuestionsState){
                answers = state.data;
                return _buildQuestionsList(answers);
              }
            },
          )
        ),
      ),
      floatingActionButton: new FloatingActionButton(
        child: Icon(Icons.check),
        onPressed: _showConfirmationDialog,
      ),
    );
  }
}