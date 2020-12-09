import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:online_teaching_mobile/app/service/category_names_service.dart';
import 'package:online_teaching_mobile/app/service/interfaces/ICategoryName.dart';
import 'package:online_teaching_mobile/app/view/bottom_navigation_page/bottom_navigation.dart';
import 'package:online_teaching_mobile/core/constant/app_constant.dart';
import 'package:online_teaching_mobile/core/logger/logger.dart';
import 'package:online_teaching_mobile/core/init/navigation/navigation_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class BottomNavigationViewModel extends State<BottomNavigation>
    with BaseViewModel {
  final logger =
      Logger(printer: SimpleLogPrinter('bottom_navigation_view_model.dart'));
  bool isLoading = false;
  //category
  List<String> b_categories_name = [];
  ICategoryNameService categoryservice;

  /// shared preferences
  SharedPreferences preferences;
  // quiz
  List<String> myQuizIdList = [];
  List<String> myQuizNoteList = [];
  double ort;
  @override
  void initState() {
    super.initState();
    categoryservice = CategoryNameService.instance;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void changeLoading() {
    setState(() {
      isLoading = !isLoading;
    });
  }

  Future<void> getNameList() async {
    b_categories_name = await categoryservice.getCategoriesNameList();
    logger.i("getNameList | kategori isimleri döndürüldü");
    return b_categories_name;
  }

  Future<void> getQuizIdandQuizNote() async {
    try {
      preferences = await SharedPreferences.getInstance();
      myQuizNoteList = preferences.getStringList("quizNote");
      int sum = 0;
      int i = 0;
      for (i = 1; i < myQuizNoteList.length; i++) {
        sum += int.parse(myQuizNoteList[i]);
      }
      ort = sum / (myQuizNoteList.length - 1);
      star = (ort / 20);
      logger.i("getQuizIdandQuizNote | user star -> $star");
      return ort;
    } catch (e) {}
    star = 0;
  }
}

abstract class BaseViewModel {
  NavigationService navigation = NavigationService.instance;
}
