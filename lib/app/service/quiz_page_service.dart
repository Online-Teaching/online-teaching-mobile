import 'package:online_teaching_mobile/app/model/quiz_model.dart';
import 'package:online_teaching_mobile/app/service/api/API.dart';
import 'package:online_teaching_mobile/app/service/interfaces/IQuestion.dart';
import 'package:online_teaching_mobile/app/view/quiz_page/quiz.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'api/apiUrl.dart';

class QuizService implements IQuestionService {
  static MyQuiz quiz_data = new MyQuiz();
  static QuizService _instance;
  static QuizService get instance {
    if (_instance == null) _instance = QuizService._init();
    return _instance;
  }

  QuizService._init();

  Future<MyQuiz> getQuestionList([String id]) async {
    try {
      API api = new API();
      final baseUrl = api.getOnlineTeaching_2_Url();
      String ss = "$baseUrl/quiz/$api_category_url$api_sub_category_index.json";
      print(ss);
      var _response = await http
          .get("$baseUrl/quiz/$api_category_url$api_sub_category_index.json");
      var jsonData = json.decode(_response.body);
      quiz_data = MyQuiz.fromJson(jsonData);
      return quiz_data;
    } on Exception catch (_) {}
  }
}
