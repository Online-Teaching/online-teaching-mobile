import 'package:flutter/material.dart';
import 'package:online_teaching_mobile/app/model/category_model.dart';
import 'package:online_teaching_mobile/app/service/api/apiUrl.dart';
import 'package:online_teaching_mobile/app/view/splash_screen/splash_screen_view.dart';
import 'package:online_teaching_mobile/app/view_model/sub_category_view_model.dart';
import 'package:online_teaching_mobile/core/constant/app_constant.dart';
import 'package:online_teaching_mobile/core/constant/navigation_constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SubCategoryView extends SubCategoryViewModel {
  /// genel değişmez bir liste olmalı shared preferences
  SharedPreferences preferences;
  List<String> bookmark_data = [];
  @override
  void initState() {
    super.initState();
    getLocalData();
  }

  Future getLocalData() async {
    preferences = await SharedPreferences.getInstance();

    bookmark_data = preferences.getStringList("konuid");
    preferences.setStringList("konuid", bookmark_data);

    print("//shared preferences");
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

  @override
  Widget build(BuildContext context) {
    print("//// sub category"); // mat kim gibi
    Size size = MediaQuery.of(context).size;
    return Container(
      color: Colors.white,
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
            future: getList(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              return ListView.builder(
                  itemCount: categories.length,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) =>
                      categoryCard(categories[index], index));
            }),
      ),
    );
  }

  Container categoryCard(
    Category category,
    int index,
  ) =>
      Container(
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
                icon: isBookmark(category.id)
                    ? Icon(Icons.bookmark)
                    : Icon(Icons.bookmark_border),
                onPressed: () {
                  setState(() {
                    bookmark_data = preferences.getStringList("konuid");

                    try {
                      if (bookmark_data.contains(category.id)) {
                        bookmark_data.remove(category.id);
                      } else {
                        bookmark_data.add(category.id);
                      }
                    } catch (e) {
                      preferences.setStringList("konuid", [""]);
                      bookmark_data = preferences.getStringList("konuid");
                      bookmark_data.add(category.id);
                    }

                    preferences.setStringList("konuid", bookmark_data);
                  });
                  print("dataaa" + bookmark_data.toString());

                  /// her basıldığında set state yapmalı
                },
              ),
              title: Text(category.title.toUpperCase()),
              onTap: () {
                setState(() {
                  api_sub_category_index = index.toString();

                  /// go to detail view
                  navigation.navigateToPage(
                      path: NavigationConstants.DETAIL_VIEW, data: category);
                });
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
          "Alt kategoriler",
          style: Theme.of(context)
              .textTheme
              .headline5
              .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
