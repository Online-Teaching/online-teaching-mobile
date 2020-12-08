import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:online_teaching_mobile/app/model/category_model.dart';
import 'package:online_teaching_mobile/app/service/api/apiUrl.dart';
import 'package:online_teaching_mobile/app/view_model/home_view_model.dart';
import 'package:online_teaching_mobile/core/constant/navigation_constant.dart';
import 'package:online_teaching_mobile/core/extension/future_builder.dart';
import 'package:online_teaching_mobile/core/logger/logger.dart';

class HomeView extends HomeViewModel {
  final logger = Logger(printer: SimpleLogPrinter('home_view.dart'));
  @override
  Icon icon = Icon(Icons.bookmark_border);
  int _selectedIndex;
  @override
  Widget build(BuildContext context) {
    logger.i("build");
    Size size = MediaQuery.of(context).size;
    return Container(
      child: Column(
        children: [
          appbar(size, context),
          body(),
        ],
      ),
    );
  }

  Expanded body() {
    return Expanded(
        flex: 6,
        child: Container(
          //margin: EdgeInsets.all(10),
          //padding: EdgeInsets.all(10),
          margin: EdgeInsets.only(top: 5),
          child: FutureBuilder(
              future: getList2(),
              builder: getList2() == null
                  ? Center(child: CircularProgressIndicator())
                  : (BuildContext context, AsyncSnapshot snapshot) {
                      return ListView.builder(
                          itemCount: categories_name.length,
                          scrollDirection: Axis.vertical,
                          itemBuilder: (context, index) =>
                              categoryCard(categories_name[index], index));
                    }),
        ));
  }

  Expanded appbar(Size size, BuildContext context) {
    return Expanded(
      flex: 2,
      child: Stack(
        children: <Widget>[
          Container(
            alignment: Alignment.topCenter,
            padding: EdgeInsets.only(
              top: 30,
              left: 20,
              right: 20,
            ),
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(36),
                bottomRight: Radius.circular(36),
              ),
            ),
            child: Text(
              "Kategoriler",
              style: Theme.of(context)
                  .textTheme
                  .headline5
                  .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(horizontal: 15),
              padding: EdgeInsets.symmetric(horizontal: 10),
              height: 54,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    //offset: Offset(0, 1),
                    blurRadius: 20,
                    //  color: Colors.blue.withOpacity(0.23),
                  ),
                ],
              ),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      onChanged: (value) {},
                      decoration: InputDecoration(
                        hintText: "Search",
                        hintStyle: TextStyle(
                          color: Colors.black.withOpacity(0.5),
                        ),
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        // surffix isn't working properly  with SVG
                        // thats why we use row
                        // suffixIcon: SvgPicture.asset("assets/icons/search.svg"),
                      ),
                      onTap: () {
                        setState(() {});
                      },
                    ),
                  ),
                  Icon(Icons.search)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container categoryCard(String category, int index) => Container(
      height: 80,
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(15),
          bottomRight: Radius.circular(15),
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
        boxShadow: [
          BoxShadow(
            spreadRadius: 1,
            //offset: Offset(0, 1),
            blurRadius: 7,
            color: Colors.blueGrey.withOpacity(0.25),
          ),
        ],
      ),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        color: Colors.red[200],
        child: ListTile(
          title: Center(
              child: Text(
            category.toUpperCase(),
            style:
                TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
          )),
          onTap: () {
            setState(() {
              api_category_url = "";
              api_category_url = category;
              logger.i("$api_category_url konuları listelendi");
              _selectedIndex = index;
              navigation.navigateToPage(path: NavigationConstants.SUB_CATEGORY);
            });
          },
        ),
      ));
}
