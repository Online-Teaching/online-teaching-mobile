import 'package:flutter/material.dart';
import 'package:online_teaching_mobile/app/view/splash_screen/splash_screen.dart';

abstract class SplashViewModel extends State<Splash> {
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
