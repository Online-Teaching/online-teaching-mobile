import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:online_teaching_mobile/app/model/category_model.dart';
import 'package:online_teaching_mobile/app/service/category_page_service.dart';
import 'package:online_teaching_mobile/app/service/interfaces/ICategoryService.dart';
import 'package:online_teaching_mobile/core/init/navigation/INavigationService.dart';
import 'category_page.dart';
import 'package:http/http.dart' as http;

abstract class CategoryViewModel extends State<CategoryScreen>
    with BaseViewModel {
  final baseUrl = "https://online-teaching-14e16.firebaseio.com";
  bool isLoading = false;
  List<Category> categories = [];
  ICategoryService categoryservice;

  @override
  void initState() {
    super.initState();
    categoryservice = CategoryService.instance;
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

  Future<void> getList() async {
    categories = await categoryservice.getCategoriesList();
    return categories;
  }
}

abstract class BaseViewModel {
  NavigationService navigation = NavigationService.instance;
}
