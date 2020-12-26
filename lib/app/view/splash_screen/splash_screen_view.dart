import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:logger/logger.dart';
import 'package:lottie/lottie.dart';
import 'package:online_teaching_mobile/app/view_model/splash_screen_view_model.dart';
import 'package:online_teaching_mobile/app/component/round_button.dart';
import 'package:online_teaching_mobile/core/constant/user.dart';
import 'package:online_teaching_mobile/core/extension/context_extension.dart';
import 'package:online_teaching_mobile/core/constant/navigation_constant.dart';
import 'package:online_teaching_mobile/core/logger/logger.dart';

List<String> isBookmarkList = [""];

class SplashView extends SplashViewModel {
  final logger = Logger(printer: SimpleLogPrinter('splash_screen_view.dart'));
  bool login = true;
  GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: <String>[
      'email',
    ],
  );
  GoogleSignInAccount _currentUser;

  @override
  void initState() {
    super.initState();
    try {
      if (_googleSignIn != null) {
        _googleSignIn.onCurrentUserChanged
            .listen((GoogleSignInAccount account) {
          setState(() {
            _currentUser = account;
          });
          if (_currentUser != null) {
            //_handleGetContact();
            login = false;
          } else {
            login = true;
          }
        });
        _googleSignIn.signInSilently();
      }
    } catch (e) {}
  }

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
        text: "Öğrenmeye Başla",
        onpressed: () {
          if (login) {
            navigation.navigateToPageClear(path: NavigationConstants.LOGIN);
          } else {
            userdisplayname = _currentUser.displayName;
            userphotourl = _currentUser.photoUrl;
            navigation.navigateToPageClear(
                path: NavigationConstants.BOTTOM_NAVIGATION);
          }
        },
      ),
    );
  }
}
