import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:online_teaching_mobile/app/model/bookmark_subcategory_model.dart';
import 'package:online_teaching_mobile/app/model/subject_model.dart';
import 'package:online_teaching_mobile/app/service/api/apiUrl.dart';
import 'package:online_teaching_mobile/app/view_model/bookmark_view_model.dart';
import 'package:online_teaching_mobile/core/component/appbar.dart';
import 'package:online_teaching_mobile/core/component/sub_category.dart';
import 'package:online_teaching_mobile/core/constant/navigation_constant.dart';
import 'package:online_teaching_mobile/core/logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:online_teaching_mobile/core/extension/context_extension.dart';

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
    return Container(
      child: Column(
        children: [
          MyAppBar(
            text: "Kaydettiklerim",
            flex: 2,
            radius: 30.0,
          ),
          body()
        ],
      ),
    );
  }

  Expanded body() {
    return Expanded(
      flex: 13,
      child: Container(
        margin: EdgeInsets.only(top: context.lowValue),
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
                      margin:
                          EdgeInsets.symmetric(horizontal: context.mediumValue),
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
        child: AppSubCategoryCard(
          listTile: ListTile(
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
        ),
      );

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
