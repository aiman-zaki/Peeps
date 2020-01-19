import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peeps/bloc/groupwork/bloc.dart';
import 'package:peeps/bloc/user/bloc.dart';
import 'package:peeps/models/peer_review.dart';
import 'package:peeps/models/question.dart';
import 'package:peeps/screens/common/withAvatar_dialog.dart';
import 'package:peeps/screens/groupwork/review/peer_review_answers.dart';
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
  List<Map<String,dynamic>> usersAnwsers = [];
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

    /*_buildTableHeaders(){
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
    */

    _buildStar(int star){
      List<Widget> stars = [];
      for(int i =0 ; i<4 ; i++){
        if(i<=star){
          stars.add(Icon(Icons.star,color: Colors.green,));
        } else {
          stars.add(Icon(Icons.star,color:Colors.grey));
        }
      }

      return Row(
        children: stars
      );
    }

    _buildQuestionsList(questions){
      return ListView.builder(
        itemCount: questions.length,
        itemBuilder: (context,index){
          return Card(
            child: ListTile(
              title: Row(
                children: <Widget>[
                  Expanded(flex:3,child: Text(questions[index].question)),
                  Expanded(
                    flex: 2,
                    child: _buildStar(questions[index].star),
                  ),
                  Expanded(
                    flex:1,
                    child: InkWell(
                      onTap: () async {
                        final result = await Navigator.of(context).push(
                          CupertinoPageRoute(
                            fullscreenDialog: true,
                            builder: (context) => 
                              PeerReviewAnswers(answers: questions[index].answers,)
                          )
                        );
                        setState(() {
                          if(result != null){
                            questions[index].star = result['star'];
                            usersAnwsers.add(
                              {
                                "question_id":questions[index].id,
                                "answer_index":result["index"],
                              }
                            );
                          }
                        });
                      },
                      child: Icon(Icons.arrow_right)),
                  ),
                ],
                
              ),
              subtitle: Row(
                children: <Widget>[
                ],
              ),
            ),
          );
        },
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
                  answers: usersAnwsers
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