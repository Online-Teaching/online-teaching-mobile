import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:online_teaching_mobile/app/model/category_model.dart';
import 'package:online_teaching_mobile/app/service/category_page_service.dart';
import 'package:online_teaching_mobile/app/service/interfaces/ICategory.dart';
import 'package:online_teaching_mobile/app/view/sub_category_page/sub_category.dart';
import 'package:online_teaching_mobile/core/logger/logger.dart';
import 'package:online_teaching_mobile/core/init/navigation/navigation_service.dart';

abstract class SubCategoryViewModel extends State<SubCategory>
    with BaseViewModel {
  final logger =
      Logger(printer: SimpleLogPrinter('sub_category_view_model.dart'));
  bool isLoading = false;
  List<Category> categories;
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
    logger.i("getList | seçilen kategorinin konuları çekiliyor...");

    if (categories == null) {
      logger.i("getList | categories null");
      categories = [];
      return categories;
    } else {
      return categories;
    }
  }
}

abstract class BaseViewModel {
  NavigationService navigation = NavigationService.instance;
}
