import 'package:flutter/material.dart';
import 'package:online_teaching_mobile/app/model/category_model.dart';
import 'package:online_teaching_mobile/app/service/api/apiUrl.dart';
import 'package:online_teaching_mobile/app/view_model/sub_category_view_model.dart';
import 'package:online_teaching_mobile/core/constant/navigation_constant.dart';

class SubCategoryView extends SubCategoryViewModel {
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
          child: Card(
        child: ListTile(
          leading: IconButton(
            icon: category.isBookmark == 1
                ? Icon(Icons.bookmark)
                : Icon(Icons.bookmark_border),
            onPressed: () {
              setState(() {
                if (category.isBookmark == 0) {
                  category.isBookmark = 1;
                } else if (category.isBookmark == 1) {
                  category.isBookmark = 0;
                }

                /// her basıldığında set state yapmalı
              });
            },
          ),
          title: Text(category.title.toString()),
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
