import 'dart:convert';

import 'package:online_teaching_mobile/app/model/bookmark_subcategory_model.dart';
import 'package:online_teaching_mobile/app/model/category_model.dart';
import 'package:online_teaching_mobile/app/service/api/apiUrl.dart';
import 'package:online_teaching_mobile/app/service/interfaces/ICategoryName.dart';

import 'api/API.dart';
import 'package:http/http.dart' as http;

class CategoryNameService implements ICategoryNameService {
  static List<String> categories_name = [];

  static CategoryNameService _instance;
  static CategoryNameService get instance {
    if (_instance == null) _instance = CategoryNameService._init();
    return _instance;
  }

  Category single_category;
  CategoryNameService._init();

  @override
  Future<List<String>> getCategoriesNameList() async {
    API api = new API();
    final baseUrl = api.getOnlineTeaching_2_Url();

    var _response = await http.get("$baseUrl/kategori_name_list.json");
    var jsonData = json.decode(_response.body);
    //https://online-teaching2.firebaseio.com/kategori_name_list.json

    if (categories_name.isEmpty) {
      for (var c in jsonData) {
        print(c);

        categories_name.add(c);
      }
    }

    for (var item in categories_name) {
      print(item);
      print("yok artık");
    }

    return categories_name;
  }

  @override
  Future<Category> getSingleCategory() async {
    API api = new API();
    final baseUrl = api.getOnlineTeaching_2_Url();

    var _response = await http.get(
        "$baseUrl/kategoriler/$api_category_url/$api_sub_category_index.json");
    var jsonData = json.decode(_response.body);
    single_category = Category.fromJson(jsonData);
    //  https://online-teaching2.firebaseio.com/kategoriler/kimya/0.json

    return single_category;
  }
}
