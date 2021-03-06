import 'package:logger/logger.dart';
import 'package:online_teaching_mobile/app/model/quiz_model.dart';
import 'package:online_teaching_mobile/app/service/api/API.dart';
import 'package:online_teaching_mobile/app/service/interfaces/IQuestion.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:online_teaching_mobile/core/logger/logger.dart';

import 'api/apiUrl.dart';

class QuizService implements IQuestionService {
  final logger = Logger(printer: SimpleLogPrinter('quiz_page_service.dart'));
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

      var _response = await http
          .get("$baseUrl/quiz/$api_category_url$api_sub_category_index.json");
      var jsonData = json.decode(_response.body);
      quiz_data = MyQuiz.fromJson(jsonData);
      logger.i(
          "getQuestionList | $api_category_url$api_sub_category_index\'in quizi çekildi");
      return quiz_data;
    } on Exception catch (_) {
      logger.e("getQuestionList | quiz çekilemedi");
    }
  }
}
