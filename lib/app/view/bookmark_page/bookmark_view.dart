import 'dart:io';

import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:online_teaching_mobile/app/model/bookmark_subcategory_model.dart';
import 'package:online_teaching_mobile/app/model/category_model.dart';
import 'package:online_teaching_mobile/app/model/subject_model.dart';
import 'package:online_teaching_mobile/app/service/api/apiUrl.dart';
import 'package:online_teaching_mobile/app/view_model/bookmark_view_model.dart';
import 'package:online_teaching_mobile/core/constant/app_constant.dart';
import 'package:online_teaching_mobile/core/constant/navigation_constant.dart';
import 'package:online_teaching_mobile/core/logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

class BookmarkView extends BookmarkViewModel {
  final logger = Logger(printer: SimpleLogPrinter('bookmark_view.dart'));
  SharedPreferences preferences;
  List<String> myBookMarkList = [];
  List<Subject> mySubjectList = [];
  BookMarkSubCategory g_category;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    logger.i("build");
    Size size = MediaQuery.of(context).size;
    return Container(
      child: Column(
        children: [appbar(size, context), body()],
      ),
    );
  }

  Expanded body() {
    return Expanded(
      flex: 11,
      child: Container(
        margin: EdgeInsets.only(top: 5),
        child: FutureBuilder(
            future: getSubjects(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                logger.i("build | getSubjects.hasData true ");
                if (snapshot.hasData != null) {
                  logger.i("build | getSubjects.hasData null değil ");
                  if (mySubjectList_service.length == 0) {
                    logger.i("build | listelenecek konu yok ");
                    return Scaffold(
                        body: Container(
                      margin: EdgeInsets.symmetric(horizontal: 50),
                      child: Center(
                          child: Text(
                        "Kaydedilen konu bulunmuyor.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 17,
                          color: Colors.black,
                        ),
                      )),
                    ));
                  } else {
                    return ListView.builder(
                        itemCount: mySubjectList_service.length,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) =>
                            categoryCard(mySubjectList_service[index], index));
                  }
                }
              } else {
                logger.i("build | getSubjects.hasData false geliyor ");
                return Center(child: CircularProgressIndicator());
              }
            }),
      ),
    );
  }

  Container categoryCard(Subject subject, int index) => Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
      decoration: BoxDecoration(
        color: Colors.blueGrey[100],
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(15),
          bottomRight: Radius.circular(15),
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
      ),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: ListTile(
          leading: IconButton(
            icon: Icon(Icons.bookmark),
            onPressed: () {
              setState(() {
                myBookMarkList.remove(subject.id);
                preferences.setStringList("konuid", myBookMarkList);
              });
            },
          ),
          title: Text(subject.title.toUpperCase()),
          onTap: () {
            create_Url(subject.id, context);
            navigation.navigateToPage(path: NavigationConstants.DETAIL_VIEW);
          },
        ),
      ));

  Expanded appbar(Size size, BuildContext context) {
    return Expanded(
      flex: 2,
      child: Container(
        alignment: Alignment.topCenter,
        padding: EdgeInsets.only(top: 30, left: 20, right: 20),
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(30),
            bottomRight: Radius.circular(30),
          ),
          boxShadow: [
            BoxShadow(
              //offset: Offset(0, 1),
              blurRadius: 10,
              //  color: Colors.blue.withOpacity(0.23),
            ),
          ],
        ),
        child: Text(
          "Kaydettiklerim",
          style: Theme.of(context)
              .textTheme
              .headline5
              .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  void create_Url(String id, context) {
    String category_url = "";
    String sub_category_url = "";
    id.runes.forEach((int rune) {
      if (isIntNumber(String.fromCharCode(rune))) {
        sub_category_url += String.fromCharCode(rune);
      } else {
        category_url += String.fromCharCode(rune);
      }
    });

    api_category_url = category_url;
    api_sub_category_index = sub_category_url;
    logger.i("create_url | $id konusuna gidiliyor.");
    getSingleCategory();
  }
}

isIntNumber(String char) {
  List<String> numberList = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"];
  if (numberList.contains(char)) {
    return true;
  } else {
    return false;
  }
}
