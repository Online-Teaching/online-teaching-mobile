import 'package:flutter/material.dart';
import 'package:online_teaching_mobile/app/view/quiz_page/quiz.dart';
import 'package:online_teaching_mobile/core/init/navigation/INavigationService.dart';

abstract class QuizViewModel extends State<Quiz> with BaseViewModel {}

abstract class BaseViewModel {
  NavigationService navigation = NavigationService.instance;
}
