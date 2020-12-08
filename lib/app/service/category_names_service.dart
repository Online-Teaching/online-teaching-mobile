import 'dart:convert';

import 'package:logger/logger.dart';
import 'package:online_teaching_mobile/app/model/bookmark_subcategory_model.dart';
import 'package:online_teaching_mobile/app/model/category_model.dart';
import 'package:online_teaching_mobile/app/service/api/apiUrl.dart';
import 'package:online_teaching_mobile/app/service/interfaces/ICategoryName.dart';
import 'package:online_teaching_mobile/core/logger/logger.dart';

import 'api/API.dart';
import 'package:http/http.dart' as http;

class CategoryNameService implements ICategoryNameService {
  final logger =
      Logger(printer: SimpleLogPrinter('category_name_service.dart'));
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

    if (categories_name.isEmpty) {
      logger.i("getCategoriesNameList | kategori isimleri çekildi");
      for (var c in jsonData) {
        categories_name.add(c);
      }
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
    logger.i("getSingleCategory | tıklanan konu çekildi(sub category)");
    return single_category;
  }
}
