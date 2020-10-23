import 'package:online_teaching_mobile/app/model/category_model.dart';

abstract class ICategoryService {
  Future<List<Category>> getCategoriesList();
}
