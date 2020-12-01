import 'dart:io';

import 'package:flutter/material.dart';
import 'package:online_teaching_mobile/app/model/bookmark_subcategory_model.dart';
import 'package:online_teaching_mobile/app/model/category_model.dart';
import 'package:online_teaching_mobile/app/model/subject_model.dart';
import 'package:online_teaching_mobile/app/service/api/apiUrl.dart';
import 'package:online_teaching_mobile/app/view_model/bookmark_view_model.dart';
import 'package:online_teaching_mobile/core/constant/app_constant.dart';
import 'package:online_teaching_mobile/core/constant/navigation_constant.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

class BookmarkView extends BookmarkViewModel {
  SharedPreferences preferences;
  List<String> myBookMarkList = [];
  List<Subject> mySubjectList = [];
  BookMarkSubCategory g_category;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
            future: getSubjects(myBookMarkList),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              return ListView.builder(
                  itemCount: mySubjectList_service.length,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) =>
                      categoryCard(mySubjectList_service[index], index));
            }),
      ),
    );
  }

  Container categoryCard(Subject subject, int index) => Container(
          child: Card(
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
          title: Text(subject.title.toString()),
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
    getSingleCategory();

    Toast.show(api_category_url + " ve " + api_sub_category_index, context,
        duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
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
