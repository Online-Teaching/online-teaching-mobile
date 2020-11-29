import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:online_teaching_mobile/app/view/category_page/category_page.dart';
import 'package:online_teaching_mobile/app/view/category_page/category_page_view.dart';
import 'package:online_teaching_mobile/app/view/detail_page/detail.dart';
import 'package:online_teaching_mobile/app/view/quiz_page/quiz.dart';
import 'package:online_teaching_mobile/app/view/quiz_page/quiz_view.dart';
import 'package:online_teaching_mobile/app/view/sub_category_page/sub_category.dart';

import 'app/view/bottom_navigation_page/bottom_navigation.dart';
import 'app/view/splash_screen/splash_screen.dart';
import 'core/init/navigation/navigation_service.dart';
import 'core/init/navigation/navigation_route.dart';

void main() => runApp(MyApp());

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
