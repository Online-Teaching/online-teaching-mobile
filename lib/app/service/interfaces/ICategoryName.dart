import 'package:online_teaching_mobile/app/model/bookmark_subcategory_model.dart';
import 'package:online_teaching_mobile/app/model/category_model.dart';

abstract class ICategoryNameService {
  Future<List<String>> getCategoriesNameList();
  Future<Category> getSingleCategory();
}
