import 'package:flutter/material.dart';
import 'package:online_teaching_mobile/app/model/category_model.dart';
import 'package:online_teaching_mobile/app/view_model/summary_view_model.dart';
import 'package:online_teaching_mobile/core/constant/navigation_constant.dart';
import 'package:online_teaching_mobile/core/extension/context_extension.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:toast/toast.dart';

int id = id != null ? id : 0;

class SummaryView extends SummaryViewModel {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Category category = ModalRoute.of(context).settings.arguments;
    id = category.id;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onPressed: () {
            navigation.navigateToPage(path: NavigationConstants.CATEGORY_VIEW);
          },
        ),
        title: Text(
          "Subject Summary",
          style: context.textTheme.headline5.copyWith(color: Colors.black),
        ),
      ),
      body: Container(
        child: Column(
          children: [
            Spacer(flex: 1),
            Expanded(
              flex: 36,
              child: Container(
                decoration: BoxDecoration(boxShadow: [
                  BoxShadow(
                      color: Colors.blueGrey[600].withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 40,
                      offset: Offset(0, 2))
                ]),
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Text(category.title,
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green)),
                          SizedBox(
                            height: 10,
                          ),
                          Text(category.summary,
                              style: TextStyle(fontSize: 18)),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Spacer(flex: 1),
            Expanded(
              flex: 4,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: SizedBox(
                  width: context.width,
                  height: context.height * 0.08,
                  child: FlatButton(
                    color: Colors.green,
                    child: Text(
                      "Solve Quiz",
                      style: TextStyle(
                          fontSize: context.mediumValue, color: Colors.white),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(context.mediumValue),
                    ),
                    onPressed: () => showDialog(
                      context: context,
                      builder: (context) => buildProgressBar(),
                    ),
                  ),
                ),
              ),
            ),
            Spacer(flex: 1),
          ],
        ),
      ),
    );
  }

  CircularPercentIndicator buildProgressBar() {
    getquiz(id);
    getquizlist();
    return CircularPercentIndicator(
      radius: 60.0,
      lineWidth: 5.0,
      percent: 1.0,
      center: new Text("100%"),
      progressColor: Colors.green,
    );
  }

  void getquizlist() {
    Future.delayed(Duration(milliseconds: 1300), () {
      if (quiz_control == true) {
        navigation.navigateToPage(
            path: NavigationConstants.QUIZ_VIEW,
            data: quiz_for_current_category);
      } else {
        Toast.show("Bu konunun Quiz'i bulunmamaktadır.", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
        navigation.navigateToPageClear(path: NavigationConstants.CATEGORY_VIEW);
      }
    });
  }
}
