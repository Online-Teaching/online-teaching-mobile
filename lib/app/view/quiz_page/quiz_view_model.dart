import 'package:flutter/material.dart';
import 'package:online_teaching_mobile/app/model/quiz_model.dart';
import 'package:online_teaching_mobile/app/service/interfaces/IQuestion.dart';
import 'package:online_teaching_mobile/app/service/quiz_page_service.dart';
import 'package:online_teaching_mobile/app/view/quiz_page/quiz.dart';
import 'package:online_teaching_mobile/core/init/navigation/navigation_service.dart';

abstract class QuizViewModel extends State<Quiz> with BaseViewModel {
  bool isLoading = false;
  MyQuiz quiz_for_current_category;
  IQuestionService questionService;

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

  Future<void> getquiz(int id) async {
    quiz_for_current_category = await questionService.getQuestionList(id);
    return quiz_for_current_category;
  }
}

abstract class BaseViewModel {
  NavigationService navigation = NavigationService.instance;
}
