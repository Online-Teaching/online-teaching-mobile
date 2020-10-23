import 'package:online_teaching_mobile/app/model/category_model.dart';
import 'package:online_teaching_mobile/app/service/api/API.dart';
import 'dart:convert';
import 'interfaces/ICategoryService.dart';
import 'package:http/http.dart' as http;

class CategoryService implements ICategoryService {
  List<Category> categories = [];
  static CategoryService _instance;
  static CategoryService get instance {
    if (_instance == null) _instance = CategoryService._init();
    return _instance;
  }

  CategoryService._init();

  Future<List<Category>> getCategoriesList() async {
    API api = new API();
    final baseUrl = api.baseurl();
    var _response = await http.get("$baseUrl/.json");
    var jsonData = json.decode(_response.body);

    for (var c in jsonData) {
      categories.add(Category.fromJson(c));
    }

    return categories;
  }
}
