import 'dart:async';
import 'package:http/http.dart' as http;

const baseUrl = "https://online-teaching-14e16.firebaseio.com/";

class API {
  static Future getUsers() {
    var url = baseUrl + ".json";
    return http.get(url);
  }
}

/// search bar ekle
/// core
/// giriş ekranı
/// navigation
