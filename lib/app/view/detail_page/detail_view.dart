import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:online_teaching_mobile/app/view_model/detail_view_model.dart';
import 'package:online_teaching_mobile/app/component/appbar.dart';
import 'package:online_teaching_mobile/core/constant/navigation_constant.dart';
import 'package:online_teaching_mobile/core/logger/logger.dart';
import 'package:online_teaching_mobile/core/extension/context_extension.dart';

//Category category = new Category();

class DetailView extends DetailViewModel {
  final logger = Logger(printer: SimpleLogPrinter('detail_view.dart'));
  @override
  Widget build(BuildContext context) {
    logger.i("build");
    return Scaffold(
      body: Column(
        children: [
          MyAppBar(
            flex: 2,
            radius: context.mediumValue,
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
      child: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            bottom: context.width * 0.15,
            child: Container(
                margin: EdgeInsets.all(context.normalValue),
                padding: EdgeInsets.all(context.normalValue),
                height: context.height,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(context.mediumValue),
                  boxShadow: [
                    BoxShadow(
                      //offset: Offset(0, 1),
                      blurRadius: context.normalValue,
                      //  color: Colors.blue.withOpacity(0.23),
                    ),
                  ],
                ),
                child: SingleChildScrollView(
                  child: Container(
                    child: SizedBox(
                      width: context.width,
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
                                    return Text(
                                        category.summary != null
                                            ? category.summary
                                            : "",
                                        style: TextStyle(fontSize: 17));
                                  }
                                }
                              : (BuildContext context, AsyncSnapshot snapshot) {
                                  logger.i("getSingleCategory null geliyor");
                                  return Center(
                                      child: CircularProgressIndicator());
                                }),
                    ),
                  ),
                )),
          ),

          /// button
          ///
          Positioned(
            bottom: 0,
            child: SizedBox(
              width: context.width,
              height: context.width * 0.15,
              child: FlatButton(
                color: Colors.red,
                child: Text(
                  "Quiz çöz",
                  style: TextStyle(color: Colors.white),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(context.mediumValue),
                    topRight: Radius.circular(context.mediumValue),
                  ),
                ),
                onPressed: () {
                  navigation.navigateToPage(
                      path: NavigationConstants.QUIZ_VIEW);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
