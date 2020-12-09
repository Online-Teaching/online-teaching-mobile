import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:online_teaching_mobile/app/view/splash_screen/splash_screen.dart';
import 'package:online_teaching_mobile/core/logger/logger.dart';
import 'package:online_teaching_mobile/core/init/navigation/navigation_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class SplashViewModel extends State<Splash> with BaseViewModel {
  final logger =
      Logger(printer: SimpleLogPrinter('splash_screen_view_model.dart'));
  SharedPreferences preferences;

  List<String> myQuizIdList = [];
  List<String> myQuizNoteList = [];
  double ort;
  @override
  void initState() {
    super.initState();

    Future.delayed(
        Duration(
          seconds: 3,
        ), () {
      logger.i("splash");
    });
  }
}

abstract class BaseViewModel {
  NavigationService navigation = NavigationService.instance;
}
