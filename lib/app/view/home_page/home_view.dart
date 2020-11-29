import 'package:flutter/material.dart';
import 'package:online_teaching_mobile/app/view_model/home_view_model.dart';
import 'package:online_teaching_mobile/core/constant/navigation_constant.dart';

class HomeView extends HomeViewModel {
  Icon icon = Icon(Icons.bookmark_border);
  String ww = "Kategoriler";
  List<int> categories = [9, 2, 3, 4, 5, 6, 7, 8, 3, 4, 5, 6, 3, 4, 5, 3];
  @override
  Widget build(BuildContext context) {
    setState(() {});
    Size size = MediaQuery.of(context).size;
    // it enable scrolling on small device
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

          child: ListView.builder(
              itemCount: categories.length,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) =>
                  categoryCard(categories[index], index)),
        ));
  }

  Expanded appbar(Size size, BuildContext context) {
    return Expanded(
      flex: 2,
      child: Container(
        margin: EdgeInsets.only(bottom: 4),

        /// searchin altındaki margin
        // It will cover 20% of our total height

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
                            color: Colors.green.withOpacity(0.5),
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
      ),
    );
  }

  Container categoryCard(int category, int index) => Container(
          child: Card(
        child: ListTile(
          title: Text(category.toString()),
          leading: icon,
          onTap: () {
            setState(() {
              icon = Icon(Icons.bookmark);
              navigation.navigateToPage(path: NavigationConstants.DETAIL_VIEW);
            });
          },
        ),
      ));
}
