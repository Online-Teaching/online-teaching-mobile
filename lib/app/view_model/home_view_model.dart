import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:online_teaching_mobile/app/model/category_model.dart';
import 'package:online_teaching_mobile/app/model/subject_model.dart';
import 'package:online_teaching_mobile/app/service/category_names_service.dart';
import 'package:online_teaching_mobile/app/service/category_page_service.dart';
import 'package:online_teaching_mobile/app/service/interfaces/ICategory.dart';
import 'package:online_teaching_mobile/app/service/interfaces/ICategoryName.dart';
import 'package:online_teaching_mobile/app/service/interfaces/ISubject.dart';
import 'package:online_teaching_mobile/app/service/subject_service.dart';
import 'package:online_teaching_mobile/app/view/home_page/home.dart';
import 'package:online_teaching_mobile/core/logger/logger.dart';
import 'package:online_teaching_mobile/core/init/navigation/navigation_service.dart';

abstract class HomeViewModel extends State<Home> with BaseViewModel {
  final logger = Logger(printer: SimpleLogPrinter('home_view_model.dart'));
  bool isLoading = false;
  List<String> categories_name = [];
  ICategoryNameService categoryservice;

  //subjects
  List<Subject> subjects = [];
  List<String> subjects_string = [];
  ISubjecteService subjecteService;

  // single category
  ICategoryNameService singlecategoryService;
  Category category;

  @override
  void initState() {
    super.initState();
    subjecteService = SubjectService.instance;
    categoryservice = CategoryNameService.instance;
    singlecategoryService = CategoryNameService.instance;
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
    subjects_string = [];
    subjects = [];
    try {
      subjects = await subjecteService.getSubjectList();
      logger.i("getSubjects | tüm konular çekildi");
      for (var item in subjects) {
        subjects_string.add(item.title);
      }

      return subjects;
    } catch (e) {
      logger.e("hata");
    }
  }

  Future<void> getCategoriesNameList() async {
    categories_name = await categoryservice.getCategoriesNameList();
    logger.i("getCategoriesNameList | kategori isimleri çekildi");
    return categories_name;
  }

  List<String> getNames() {
    return categories_name;
  }

  Future<void> getSingleCategory() async {
    category = await singlecategoryService.getSingleCategory();
    String name = category.title;
    logger.i("getSingleCategory | $name konusuna gidiliyor");
    return category;
  }
}

abstract class BaseViewModel {
  NavigationService navigation = NavigationService.instance;
}
