import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:online_teaching_mobile/app/view/splash_screen/splash_screen_view_model.dart';
import 'package:online_teaching_mobile/core/constant/app_constant.dart';
import 'package:online_teaching_mobile/core/extension/context_extension.dart';

class SplashView extends SplashViewModel {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
                child: Column(
              children: [
                Text(
                  "Online Teaching",
                  style: context.textTheme.headline4.copyWith(
                      color: Colors.green, fontWeight: FontWeight.bold),
                ),
                Lottie.asset('assets/lottie_json/student1.json'),
                SizedBox(
                  width: context.width * 0.8,
                  height: context.height * 0.08,
                  child: FlatButton(
                    color: Colors.green,
                    child: Text(
                      "Başla",
                      style: TextStyle(
                          fontSize: context.normalValue, color: Colors.white),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(context.mediumValue),
                    ),
                    onPressed: () {},
                  ),
                )
              ],
            )),
          ],
        ),
      ),
    );
  }
}
