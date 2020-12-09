import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:online_teaching_mobile/app/model/category_model.dart';
import 'package:online_teaching_mobile/app/model/subject_model.dart';
import 'package:online_teaching_mobile/app/service/category_names_service.dart';
import 'package:online_teaching_mobile/app/service/interfaces/ICategoryName.dart';
import 'package:online_teaching_mobile/app/service/interfaces/ISubject.dart';
import 'package:online_teaching_mobile/app/service/subject_service.dart';
import 'package:online_teaching_mobile/app/view/bookmark_page/bookmark.dart';
import 'package:online_teaching_mobile/core/logger/logger.dart';
import 'package:online_teaching_mobile/core/init/navigation/navigation_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class BookmarkViewModel extends State<Bookmark> with BaseViewModel {
  final logger = Logger(printer: SimpleLogPrinter('bookmark_view_model.dart'));

  /// shared preferences
  SharedPreferences preferences;
  List<String> myBookMarkList = [];
  List<Subject> mySubjectList_service = [];

  ///// subjects
  bool isLoading = false;
  List<Subject> subjects = [];
  ISubjecteService subjecteService;

  /// single category
  ICategoryNameService categoryService;
  Category category;

  @override
  void initState() {
    super.initState();
    subjecteService = SubjectService.instance;
    categoryService = CategoryNameService.instance;
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

  Future<void> getSubjects() async {
    try {
      subjects = await subjecteService.getSubjectList();
      logger.i("getSubjects | bookmarklı konular çekildi");
      mySubjectList_service = [];
      preferences = await SharedPreferences.getInstance();
      myBookMarkList = preferences.getStringList("konuid");
      for (var item in subjects) {
        if (myBookMarkList.contains(item.id)) {
          if (!mySubjectList_service.contains(item)) {
            mySubjectList_service.add(item);
          }
        }
      }

      return mySubjectList_service;
    } catch (e) {
      logger.e("getSubjects | error");
      mySubjectList_service = [];
      return mySubjectList_service;
    }
  }

  Future<void> getSingleCategory() async {
    category = await categoryService.getSingleCategory();
    String name = category.title;
    logger.i("getSingleCategory | $name konusuna gidiliyor");
    return category;
  }
}

abstract class BaseViewModel {
  NavigationService navigation = NavigationService.instance;
}
