import 'package:meta/meta.dart';
import 'package:peeps/models/question.dart';
import 'package:peeps/resources/base_respository.dart';
import 'package:peeps/resources/common_repo.dart';

class QuestionsRepository extends BaseRepository{
  QuestionsRepository(
  ):super(baseUrl:questionsUrl);

  readQuestions() async {
    var data = await super.read();
    List<QuestionModel> questions = [];
    for(Map<String,dynamic> question in data){
      questions.add(QuestionModel.fromJson(question));
    }

    return questions;
  }

}