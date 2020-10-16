import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:online_teaching_mobile/app/model/category_model.dart';
import '../view/category_page/category_page.dart';
import 'package:http/http.dart' as http;

abstract class CategoryViewModel extends State<CategoryScreen> {
  final baseUrl = "https://online-teaching-14e16.firebaseio.com";
  bool isLoading = false;
  List<Category> categories = [];

  @override
  void initState() {
    super.initState();
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

  Future<List<Category>> getData() async {
    var _response = await http.get("$baseUrl/.json");
    var jsonData = json.decode(_response.body);

    for (var c in jsonData) {
      categories.add(Category.fromJson(c));
    }

    return categories;
  }
}
