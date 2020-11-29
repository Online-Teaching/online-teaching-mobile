import 'dart:convert';

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
}
