import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:online_teaching_mobile/app/view/bookmark_page/bookmark.dart';
import 'package:online_teaching_mobile/app/view/detail_page/detail.dart';
import 'package:online_teaching_mobile/app/view/home_page/home.dart';
import 'package:online_teaching_mobile/app/view/profile_page/profile.dart';
import 'package:online_teaching_mobile/app/view_model/bottom_navigation_view_model.dart';
import 'package:online_teaching_mobile/core/logger/logger.dart';

class BottomNavigationView extends BottomNavigationViewModel {
  final logger =
      Logger(printer: SimpleLogPrinter('bottom_navigation_view.dart'));
  int _currentindex = 1;

  @override
  Widget build(BuildContext context) {
    logger.i("build");
    getQuizIdandQuizNote();
    // List<String> sss = b_categories_name;
    final tabs = [Bookmark(), Home(), Profile()];
    return Scaffold(
      body: tabs[_currentindex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.red,
        showUnselectedLabels: false,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.black38,
        iconSize: 30,
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentindex,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.bookmark),
              title: Text('Kaydettiklerim'),
              backgroundColor: Colors.red),
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text('Ana sayfa'),
              backgroundColor: Colors.blue),
          BottomNavigationBarItem(
              icon: Icon(Icons.person),
              title: Text('Profil'),
              backgroundColor: Colors.green)
        ],
        onTap: (index) {
          setState(() {
            _currentindex = index;
          });
        },
      ),
    );
  }
}
