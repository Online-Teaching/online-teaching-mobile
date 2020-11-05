import 'package:online_teaching_mobile/app/model/quiz_model.dart';
import 'package:online_teaching_mobile/app/service/api/API.dart';
import 'package:online_teaching_mobile/app/service/interfaces/IQuestion.dart';
import 'package:online_teaching_mobile/app/view/quiz_page/quiz.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class QuizService implements IQuestionService {
  static MyQuiz quiz_data = new MyQuiz();
  static QuizService _instance;
  static QuizService get instance {
    if (_instance == null) _instance = QuizService._init();
    return _instance;
  }

  QuizService._init();

  Future<MyQuiz> getQuestionList(int id) async {
    API api = new API();
    final baseUrl = api.getQuizUrl();
    var _response = await http.get("$baseUrl/quiz/$id.json");
    var jsonData = json.decode(_response.body);
    quiz_data = MyQuiz.fromJson(jsonData);
    return quiz_data;
  }
}
