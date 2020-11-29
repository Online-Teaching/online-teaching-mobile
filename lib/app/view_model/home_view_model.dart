import 'package:flutter/material.dart';
import 'package:online_teaching_mobile/app/model/category_model.dart';
import 'package:online_teaching_mobile/app/service/category_names_service.dart';
import 'package:online_teaching_mobile/app/service/category_page_service.dart';
import 'package:online_teaching_mobile/app/service/interfaces/ICategory.dart';
import 'package:online_teaching_mobile/app/service/interfaces/ICategoryName.dart';
import 'package:online_teaching_mobile/app/view/home_page/home.dart';
import 'package:online_teaching_mobile/core/init/navigation/navigation_service.dart';

abstract class HomeViewModel extends State<Home> with BaseViewModel {
  bool isLoading = false;
  List<String> categories_name = [];
  ICategoryNameService categoryservice;

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

  Future<void> getList2() async {
    categories_name = await categoryservice.getCategoriesNameList();
    return categories_name;
  }

  List<String> getNames() {
    return categories_name;
  }
}

abstract class BaseViewModel {
  NavigationService navigation = NavigationService.instance;
}
