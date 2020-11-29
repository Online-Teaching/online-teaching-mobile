import 'package:flutter/material.dart';
import 'package:online_teaching_mobile/app/service/category_names_service.dart';
import 'package:online_teaching_mobile/app/service/interfaces/ICategoryName.dart';
import 'package:online_teaching_mobile/app/view/bottom_navigation_page/bottom_navigation.dart';
import 'package:online_teaching_mobile/core/init/navigation/navigation_service.dart';

abstract class BottomNavigationViewModel extends State<BottomNavigation>
    with BaseViewModel {
  bool isLoading = false;
  List<String> b_categories_name = [];
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
    b_categories_name = await categoryservice.getCategoriesNameList();
    return b_categories_name;
  }

  List<String> getNames() {
    return b_categories_name;
  }
}

abstract class BaseViewModel {
  NavigationService navigation = NavigationService.instance;
}
