import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:logger/logger.dart';
import 'package:online_teaching_mobile/app/view/splash_screen/splash_screen.dart';
import 'package:online_teaching_mobile/core/constant/navigation_constant.dart';
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

  /// sign in
  GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: <String>[
      'email',
    ],
  );
  GoogleSignInAccount _currentUser;
  @override
  void initState() {
    super.initState();

    Future.delayed(
        Duration(
          seconds: 12,
        ), () {
      logger.i("splash");
      // login veya bottom
    });
  }
}

abstract class BaseViewModel {
  NavigationService navigation = NavigationService.instance;
}
