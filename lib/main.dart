import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:online_teaching_mobile/app/view/category_page/category_page.dart';
import 'package:online_teaching_mobile/app/view/category_page/category_page_view.dart';
import 'package:online_teaching_mobile/app/view/detail_page/detail.dart';
import 'package:online_teaching_mobile/app/view/quiz_page/quiz.dart';
import 'package:online_teaching_mobile/app/view/quiz_page/quiz_view.dart';
import 'package:online_teaching_mobile/app/view/sub_category_page/sub_category.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app/view/bottom_navigation_page/bottom_navigation.dart';
import 'app/view/login_page/login.dart';
import 'app/view/splash_screen/splash_screen.dart';
import 'core/constant/locale_keys.dart';
import 'core/init/cache/local_manager.dart';
import 'core/init/navigation/navigation_service.dart';
import 'core/init/navigation/navigation_route.dart';

void main() => runApp(MyApp());

int initScreen;

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: Splash(),
      onGenerateRoute: NavigationRoute.instance.generateRoute,
      navigatorKey: NavigationService.instance.navigatorKey,
    );
  }
}

/*
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Splash(),
      onGenerateRoute: NavigationRoute.instance.generateRoute,
      navigatorKey: NavigationService.instance.navigatorKey,
    );
  }
}


*/

Widget getView() {
  String data = LocaleManager.instance.getStringValue(PreferencesKeys.TOKEN);
  if (data == "") {
    if (LocaleManager.instance.getStringValue(PreferencesKeys.SPLASH) == "") {
      LocaleManager.instance.setStringValue(PreferencesKeys.SPLASH, 'splash');
    } else {
      return Splash();
    }
  } else {
    return BottomNavigation();
  }
}
