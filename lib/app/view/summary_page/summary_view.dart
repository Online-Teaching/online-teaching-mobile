import 'package:flutter/material.dart';
import 'package:online_teaching_mobile/app/model/category_model.dart';
import 'package:online_teaching_mobile/app/view/summary_page/summary_view_model.dart';
import 'package:online_teaching_mobile/core/constant/navigation_constant.dart';
import 'package:online_teaching_mobile/core/extension/context_extension.dart';

class SummaryView extends SummaryViewModel {
  @override
  Widget build(BuildContext context) {
    final Category category = ModalRoute.of(context).settings.arguments;
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
          onPressed: () {},
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
                      "Anladım",
                      style: TextStyle(
                          fontSize: context.normalValue, color: Colors.white),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(context.mediumValue),
                    ),
                    onPressed: () {
                      navigation.navigateToPage(
                          path: NavigationConstants.CATEGORY_VIEW, data: 10);
                    },
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
}
