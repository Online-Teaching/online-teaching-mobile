import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:online_teaching_mobile/app/model/category_model.dart';
import 'package:online_teaching_mobile/app/view/bottom_navigation_page/bottom_navigation.dart';
import 'package:online_teaching_mobile/app/view/category_page/category_page.dart';
import 'package:online_teaching_mobile/app/view/category_page/category_page_view.dart';
import 'package:online_teaching_mobile/app/view/detail_page/detail.dart';
import 'package:online_teaching_mobile/app/view/home_page/home.dart';
import 'package:online_teaching_mobile/app/view/quiz_page/quiz.dart';
import 'package:online_teaching_mobile/app/view/splash_screen/splash_screen.dart';
import 'package:online_teaching_mobile/app/view/summary_page/summary.dart';
import 'package:online_teaching_mobile/app/view/summary_page/summary_view.dart';
import 'package:online_teaching_mobile/core/constant/navigation_constant.dart';

class NavigationRoute {
  static NavigationRoute _instance = NavigationRoute._init();
  static NavigationRoute get instance => _instance;

  NavigationRoute._init();

  Route<dynamic> generateRoute(RouteSettings args) {
    // args.arguments
    switch (args.name) {
      case NavigationConstants.SPLASH_VIEW:
        return normalNavigate(Splash(), args.arguments);
        break;
      case NavigationConstants.CATEGORY_VIEW:
        return normalNavigate(CategoryScreen(), args.arguments);
        break;
      case NavigationConstants.SUMMARY_VIEW:
        return normalNavigate(Summary(), args.arguments);
        break;
      case NavigationConstants.QUIZ_VIEW:
        return normalNavigate(Quiz(), args.arguments);
        break;
      case NavigationConstants.DETAIL_VIEW:
        return normalNavigate(Detail(), args.arguments);
        break;
      case NavigationConstants.BOTTOM_NAVIGATION:
        return normalNavigate(BottomNavigation(), args.arguments);
        break;
      case NavigationConstants.HOME:
        return normalNavigate(Home(), args.arguments);
        break;
      default:
        return MaterialPageRoute(
          builder: (context) => Scaffold(
            appBar: AppBar(),
            body: Container(child: Text("ERROR 101")),
          ),
        );
        break;
    }
  }

  MaterialPageRoute normalNavigate(Widget widget, Object id) {
    return MaterialPageRoute(
      builder: (context) => widget,
      settings: RouteSettings(
        arguments: id,
      ),
    );
  }
}
