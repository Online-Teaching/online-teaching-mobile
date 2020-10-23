import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:online_teaching_mobile/app/model/category_model.dart';
import 'package:online_teaching_mobile/app/service/category_page_service.dart';
import 'package:online_teaching_mobile/app/service/interfaces/ICategoryService.dart';
import 'category_page.dart';
import 'package:http/http.dart' as http;

abstract class CategoryViewModel extends State<CategoryScreen> {
  final baseUrl = "https://online-teaching-14e16.firebaseio.com";
  bool isLoading = false;
  List<Category> categories = [];
  ICategoryService notificationService;

  @override
  void initState() {
    super.initState();
    notificationService = CategoryService.instance;
    getList();
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

/*
  Future<void> getNotificationsLists() async {
    var _response = await http.get("$baseUrl/.json");
    var jsonData = json.decode(_response.body);

    for (var c in jsonData) {
      categories.add(Category.fromJson(c));
    }

    return categories;
  }
*/
  Future<void> getList() async {
    if (categories.isEmpty) {
      categories = await notificationService.getCategoriesList();
    }

    return categories;
  }
}
