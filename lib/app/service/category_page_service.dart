import 'package:online_teaching_mobile/app/model/category_model.dart';
import 'package:online_teaching_mobile/app/service/api/API.dart';
import 'package:online_teaching_mobile/core/constant/app_constant.dart';
import 'dart:convert';
import 'api/apiUrl.dart';
import 'interfaces/ICategory.dart';
import 'package:http/http.dart' as http;

class CategoryService implements ICategoryService {
  static List<Category> categories = [];
  static CategoryService _instance;
  static CategoryService get instance {
    if (_instance == null) _instance = CategoryService._init();
    return _instance;
  }

  CategoryService._init();

  Future<List<Category>> getCategoriesList() async {
    try {
      API api = new API();
      final baseUrl = api.getOnlineTeaching_2_Url();
      var _response =
          await http.get("$baseUrl/kategoriler/$api_category_url.json");
      var jsonData = json.decode(_response.body);
      //https://online-teaching2.firebaseio.com/kategoriler/mat.json
      categories = [];
      for (var c in jsonData) {
        categories.add(Category.fromJson(c));
      }

      return categories;
    } catch (e) {}
  }
}
