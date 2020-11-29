import 'package:online_teaching_mobile/app/model/quiz_model.dart';
import 'package:online_teaching_mobile/app/view/quiz_page/quiz.dart';

abstract class IQuestionService {
  Future<MyQuiz> getQuestionList(String id);
}
