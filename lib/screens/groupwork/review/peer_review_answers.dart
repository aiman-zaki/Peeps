import 'package:flutter/material.dart';
import 'package:peeps/models/question.dart';


class PeerReviewAnswers extends StatelessWidget {

  final List<AnswerModel> answers;
  
  const PeerReviewAnswers({Key key,@required this.answers}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Answerrs"),
      ),
      body: Container(
        padding: EdgeInsets.all(9),
        child: Column(
          children: <Widget>[
            Expanded(child: 
            ListView.builder(
              itemCount: answers.length,
              itemBuilder: (context,index){
                return Card(
                  child: ListTile(
                    leading: Text((index+1).toString()),
                    onTap: (){
                      Navigator.of(context).pop(
                        {
                          "star":index,
                          "index":index,
                        }
                      );
                    },
                    title: Text(answers[index].answer),
                  ),
                );
              },
            ),)
          ],
        ),
      ),
    );
  }
}