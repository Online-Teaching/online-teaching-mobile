import 'package:flutter/material.dart';
import 'package:online_teaching_mobile/app/model/subject_model.dart';
import 'package:online_teaching_mobile/app/service/interfaces/ISubject.dart';
import 'package:online_teaching_mobile/app/service/subject_service.dart';
import 'package:online_teaching_mobile/app/view/splash_screen/splash_screen.dart';
import 'package:online_teaching_mobile/core/constant/app_constant.dart';
import 'package:online_teaching_mobile/core/init/navigation/navigation_service.dart';

abstract class SplashViewModel extends State<Splash> with BaseViewModel {
  @override
  void initState() {
    super.initState();
    Future.delayed(
        Duration(
          seconds: 3,
        ), () {
      print("splash");
    });
  }
}

/// categories ı çekip const a at
abstract class BaseViewModel {
  NavigationService navigation = NavigationService.instance;
}
