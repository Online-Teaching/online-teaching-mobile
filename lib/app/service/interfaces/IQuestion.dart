import 'package:online_teaching_mobile/app/model/quiz_model.dart';

abstract class IQuestionService {
  Future<MyQuiz> getQuestionList();
}
