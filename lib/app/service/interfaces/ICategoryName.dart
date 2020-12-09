import 'package:online_teaching_mobile/app/model/category_model.dart';

abstract class ICategoryNameService {
  Future<List<String>> getCategoriesNameList();
  Future<Category> getSingleCategory();
}
