import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:online_teaching_mobile/app/view/category_page/category_page.dart';
import 'package:online_teaching_mobile/app/view/category_page/category_page_view.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Material App', home: CategoryScreen());
  }
}
