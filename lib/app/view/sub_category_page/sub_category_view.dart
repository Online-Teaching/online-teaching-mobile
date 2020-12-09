import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:online_teaching_mobile/app/model/category_model.dart';
import 'package:online_teaching_mobile/app/service/api/apiUrl.dart';
import 'package:online_teaching_mobile/app/view_model/sub_category_view_model.dart';
import 'package:online_teaching_mobile/core/component/appbar.dart';
import 'package:online_teaching_mobile/core/component/sub_category.dart';
import 'package:online_teaching_mobile/core/extension/context_extension.dart';
import 'package:online_teaching_mobile/core/constant/navigation_constant.dart';
import 'package:online_teaching_mobile/core/logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SubCategoryView extends SubCategoryViewModel {
  final logger = Logger(printer: SimpleLogPrinter('sub_category_view.dart'));

  /// genel değişmez bir liste olmalı shared preferences
  SharedPreferences preferences;
  List<String> bookmark_data = [];
  @override
  void initState() {
    super.initState();
    getLocalData();
  }

  @override
  Widget build(BuildContext context) {
    logger.i("build");
    Size size = MediaQuery.of(context).size;
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          MyAppBar(
            flex: 2,
            text: "Konular",
            radius: 30,
          ),
          body()
        ],
      ),
    );
  }

  Future getLocalData() async {
    preferences = await SharedPreferences.getInstance();

    bookmark_data = preferences.getStringList("konuid");
    preferences.setStringList("konuid", bookmark_data);

    logger.i("getLocalData | bookmark_data -> $bookmark_data");
  }

  isBookmark(String id) {
    if (bookmark_data == null) {
      return false;
    } else if (bookmark_data.contains(id)) {
      return true;
    } else if (!bookmark_data.contains(id)) {
      return false;
    }
  }

  Expanded body() {
    return Expanded(
      flex: 13,
      child: Container(
        margin: EdgeInsets.only(top: 5),
        child: FutureBuilder(
            future: getList(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                logger.i("body | getList  snapshot.hasData true");
                if (snapshot.hasData != null) {
                  logger.i("body | getList  snapshot.hasData null değil");
                  if (categories.length == 0) {
                    logger.i(
                        "body | getList categories.length=0 (sun categorysi yok)");
                    return Scaffold(
                        body: Container(
                      margin: EdgeInsets.symmetric(horizontal: 50),
                      child: Center(
                          child: Text(
                        "Bu kategorinin konusu bulunmuyor.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 17,
                          color: Colors.black,
                        ),
                      )),
                    ));
                  } else {
                    return ListView.builder(
                        itemCount: categories.length,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) =>
                            categoryCard(categories[index], index));
                  }
                }
              }
              logger.i("body | data bekleniyor... ");
              return Center(child: CircularProgressIndicator());
            }),
      ),
    );
  }

  Container categoryCard(Category category, int index) => Container(
        child: AppSubCategoryCard(
          listTile: ListTile(
            leading: iconButtonBookmarkLogic(category),
            title: Text(category.title.toUpperCase()),
            onTap: () {
              setState(() {
                api_sub_category_index = index.toString();
                navigation.navigateToPage(
                    path: NavigationConstants.DETAIL_VIEW, data: category);
              });
            },
          ),
        ),
      );

  IconButton iconButtonBookmarkLogic(Category category) {
    return IconButton(
      icon: isBookmark(category.id)
          ? Icon(Icons.bookmark)
          : Icon(Icons.bookmark_border),
      onPressed: () {
        setState(() {
          bookmark_data = preferences.getStringList("konuid");
          logger.i("body | bookmark_data -> $bookmark_data ");

          try {
            if (bookmark_data.contains(category.id)) {
              bookmark_data.remove(category.id);
            } else {
              bookmark_data.add(category.id);
            }
          } catch (e) {
            logger.e("body | bookmark_data'ya ulaşılamadı ");
            preferences.setStringList("konuid", [""]);
            bookmark_data = preferences.getStringList("konuid");
            bookmark_data.add(category.id);
            logger.e("body | bookmark_data oluşturuldu");
          }

          preferences.setStringList("konuid", bookmark_data);
        });
      },
    );
  }
}
