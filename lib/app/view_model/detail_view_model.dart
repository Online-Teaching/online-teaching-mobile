import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:online_teaching_mobile/app/model/category_model.dart';
import 'package:online_teaching_mobile/app/model/quiz_model.dart';
import 'package:online_teaching_mobile/app/service/category_names_service.dart';
import 'package:online_teaching_mobile/app/service/interfaces/ICategoryName.dart';
import 'package:online_teaching_mobile/app/service/interfaces/IQuestion.dart';
import 'package:online_teaching_mobile/app/service/quiz_page_service.dart';
import 'package:online_teaching_mobile/app/view/detail_page/detail.dart';
import 'package:online_teaching_mobile/core/logger/logger.dart';
import 'package:online_teaching_mobile/core/init/navigation/navigation_service.dart';

abstract class DetailViewModel extends State<Detail> with BaseViewModel {
  final logger = Logger(printer: SimpleLogPrinter('detail_view_model.dart'));
  bool isLoading = false;

  /// sibgle category
  ICategoryNameService categoryService;
  Category category;

  @override
  void initState() {
    super.initState();
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

  Future<void> getSingleCategory() async {
    category = await categoryService.getSingleCategory();
    String title = category.title;
    logger.i("getSingleCategory | $title konusu çekildi(single)");
    return category;
  }
}

abstract class BaseViewModel {
  NavigationService navigation = NavigationService.instance;
}
