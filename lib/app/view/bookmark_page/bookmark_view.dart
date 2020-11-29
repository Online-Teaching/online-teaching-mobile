import 'package:flutter/material.dart';
import 'package:online_teaching_mobile/app/view_model/bookmark_view_model.dart';

class BookmarkView extends BookmarkViewModel {
  List<int> categories = [9, 2, 3, 4, 5, 6, 7, 8, 3, 4, 5, 6, 3, 4, 5, 3];
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
        child: ListView.builder(
            itemCount: categories.length,
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) =>
                categoryCard(categories[index], index)),
      ),
    );
  }

  Container categoryCard(int category, int index) => Container(
          child: Card(
        child: ListTile(
          title: Text(category.toString()),
          onTap: () {
            setState(() {});
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
}
