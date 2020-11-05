import 'package:flutter/material.dart';
import 'package:online_teaching_mobile/app/model/quiz_model.dart';
import 'package:online_teaching_mobile/app/service/interfaces/IQuestion.dart';
import 'package:online_teaching_mobile/app/service/quiz_page_service.dart';
import 'package:online_teaching_mobile/app/view/summary_page/summary.dart';
import 'package:online_teaching_mobile/core/init/navigation/INavigationService.dart';

abstract class SummaryViewModel extends State<Summary> with BaseViewModel {
  bool quiz_control = false;
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
    try {
      quiz_for_current_category = await questionService.getQuestionList(id);
      quiz_control = true;
      return quiz_for_current_category;
    } on Exception catch (_) {
      quiz_control = false;
    } finally {
      return Center();
    }
  }
}

abstract class BaseViewModel {
  NavigationService navigation = NavigationService.instance;
}
