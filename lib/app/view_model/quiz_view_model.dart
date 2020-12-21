import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:online_teaching_mobile/app/model/quiz_model.dart';
import 'package:online_teaching_mobile/app/service/interfaces/IQuestion.dart';
import 'package:online_teaching_mobile/app/service/quiz_page_service.dart';
import 'package:online_teaching_mobile/app/view/quiz_page/quiz.dart';
import 'package:online_teaching_mobile/core/logger/logger.dart';
import 'package:online_teaching_mobile/core/init/navigation/navigation_service.dart';

abstract class QuizViewModel extends State<Quiz> with BaseViewModel {
  final logger = Logger(printer: SimpleLogPrinter('quiz_view_model.dart'));
  bool isLoading = false;
  MyQuiz myquiz = new MyQuiz();
  IQuestionService questionService;
  int hello = 1;

  @override
  void initState() {
    super.initState();
    questionService = QuizService.instance;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void changeLoading() {
    setState(() {
      isLoading = !isLoading;
    });
  }

  Future<void> getquiz() async {
    try {
      myquiz = await questionService.getQuestionList();
      logger.i("getquiz | quiz çekildi");
    } catch (e) {
      logger.i("getquiz | error");
      myquiz.questionList = [];
    }

    return myquiz;
  }
}

abstract class BaseViewModel {
  NavigationService navigation = NavigationService.instance;
}
