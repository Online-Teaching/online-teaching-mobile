import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:online_teaching_mobile/core/logger/logger.dart';
import 'app/view/bottom_navigation_page/bottom_navigation.dart';
import 'app/view/splash_screen/splash_screen.dart';
import 'core/constant/locale_keys.dart';
import 'core/init/cache/local_manager.dart';
import 'core/init/navigation/navigation_service.dart';
import 'core/init/navigation/navigation_route.dart';

void main() => runApp(MyApp());

int initScreen;
final logger = Logger(printer: SimpleLogPrinter('main.dart'));

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    logger.i("build");
    return new MaterialApp(
      home: Splash(),
      onGenerateRoute: NavigationRoute.instance.generateRoute,
      navigatorKey: NavigationService.instance.navigatorKey,
    );
  }
}

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
