import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:online_teaching_mobile/app/model/category_model.dart';
import 'package:online_teaching_mobile/app/view_model/detail_view_model.dart';
import 'package:online_teaching_mobile/core/component/appbar.dart';
import 'package:online_teaching_mobile/core/constant/navigation_constant.dart';
import 'package:online_teaching_mobile/core/logger/logger.dart';
import 'package:online_teaching_mobile/main.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:toast/toast.dart';

//Category category = new Category();

class DetailView extends DetailViewModel {
  final logger = Logger(printer: SimpleLogPrinter('detail_view.dart'));
  Size size;
  @override
  Widget build(BuildContext context) {
    logger.i("build");
    size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        children: [
          MyAppBar(
            flex: 2,
            radius: 30,
            f: FutureBuilder(
              future: getSingleCategory(),
              builder: getSingleCategory() == null
                  ? (context, snapshot) {
                      return Text('-');
                    }
                  : (context, snapshot) {
                      if (snapshot.hasData) {
                        return Text(
                          category.title.toUpperCase(),
                          style: Theme.of(context).textTheme.headline5.copyWith(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        );
                      } else {
                        return Text('-');
                      }
                    },
            ),
          ),
          body()
        ],
      ),
    );
  }

  Expanded body() {
    return Expanded(
      flex: 13,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Container(
                margin: EdgeInsets.all(10),
                padding: EdgeInsets.all(20),
                height: size.height,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      //offset: Offset(0, 1),
                      blurRadius: 20,
                      //  color: Colors.blue.withOpacity(0.23),
                    ),
                  ],
                ),
                child: Container(
                  child: SizedBox(
                    width: size.width,
                    child: FutureBuilder(
                        future: getSingleCategory(),
                        builder: getSingleCategory() != null
                            ? (BuildContext context, AsyncSnapshot snapshot) {
                                logger.i("getSingleCategory null değil");
                                if (!snapshot.hasData) {
                                  logger.i(
                                      "getSingleCategory | snapshot.hasData null değil");
                                  return Center(
                                      child: CircularProgressIndicator());
                                } //CIRCULAR INDICATOR
                                else {
                                  return Text(category.summary != null
                                      ? category.summary
                                      : "");
                                }
                              }
                            : (BuildContext context, AsyncSnapshot snapshot) {
                                logger.i("getSingleCategory null geliyor");
                                return Center(
                                    child: CircularProgressIndicator());
                              }),
                  ),
                )),
            SizedBox(
              width: size.width,
              height: size.height * 0.08,
              child: FlatButton(
                color: Colors.red,
                child: Text(
                  "Quiz çöz",
                  style: TextStyle(color: Colors.white),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                onPressed: () {
                  navigation.navigateToPageClear(
                      path: NavigationConstants.QUIZ_VIEW);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
