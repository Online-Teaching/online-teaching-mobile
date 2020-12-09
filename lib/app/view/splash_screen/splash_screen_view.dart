import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logger/logger.dart';
import 'package:lottie/lottie.dart';
import 'package:online_teaching_mobile/app/view_model/splash_screen_view_model.dart';
import 'package:online_teaching_mobile/core/component/round_button.dart';
import 'package:online_teaching_mobile/core/constant/app_constant.dart';
import 'package:online_teaching_mobile/core/constant/navigation_constant.dart';
import 'package:online_teaching_mobile/core/extension/context_extension.dart';
import 'package:online_teaching_mobile/core/logger/logger.dart';

List<String> isBookmarkList = [""];

class SplashView extends SplashViewModel {
  final logger = Logger(printer: SimpleLogPrinter('splash_screen_view.dart'));
  @override
  Widget build(BuildContext context) {
    logger.i("build");
    // getQuizIdandQuizNote();
    return WillPopScope(
        child: myScaffoldWidget(context),
        onWillPop: () {
          return showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text("Confirm Exit"),
                  content: Text("Are you sure you want to exit?"),
                  actions: <Widget>[
                    FlatButton(
                      child: Text("YES"),
                      onPressed: () {
                        SystemNavigator.pop();
                      },
                    ),
                    FlatButton(
                      child: Text("NO"),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    )
                  ],
                );
              });
          return Future.value(true);
        });
  }

  Scaffold myScaffoldWidget(BuildContext context) {
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
                  style: context.textTheme.headline4
                      .copyWith(color: Colors.red, fontWeight: FontWeight.bold),
                ),
                Lottie.asset('assets/lottie_json/student1.json'),
                round_button(context)
              ],
            )),
          ],
        ),
      ),
    );
  }

  Container round_button(BuildContext context) {
    return Container(
      child: AppButton(
        text: "Başla",
        onpressed: () {
          navigation.navigateToPage(path: NavigationConstants.LOGIN);
        },
      ),
    );
  }
}
