import 'package:flutter/material.dart';
import 'package:online_teaching_mobile/app/view/splash_screen/splash_screen.dart';
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

abstract class BaseViewModel {
  NavigationService navigation = NavigationService.instance;
}
