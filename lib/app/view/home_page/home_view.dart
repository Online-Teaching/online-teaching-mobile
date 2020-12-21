import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:online_teaching_mobile/app/model/subject_model.dart';
import 'package:online_teaching_mobile/app/service/api/apiUrl.dart';
import 'package:online_teaching_mobile/app/view/home_page/data_search.dart';
import 'package:online_teaching_mobile/app/view_model/home_view_model.dart';
import 'package:online_teaching_mobile/app/component/appbar_with_stack.dart';
import 'package:online_teaching_mobile/app/component/category_card.dart';
import 'package:online_teaching_mobile/core/constant/navigation_constant.dart';
import 'package:online_teaching_mobile/core/logger/logger.dart';
import 'package:online_teaching_mobile/core/extension/context_extension.dart';

class HomeView extends HomeViewModel {
  final logger = Logger(printer: SimpleLogPrinter('home_view.dart'));
  @override
  Icon icon = Icon(Icons.bookmark_border);
  int _selectedIndex;
  @override
  Widget build(BuildContext context) {
    getSubjects();
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
          margin: EdgeInsets.only(
              top: context.lowValue,
              left: context.mediumValue * 1.1,
              right: context.mediumValue * 1.1),
          child: FutureBuilder(
              future: getCategoriesNameList(),
              builder: getCategoriesNameList() == null
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
          MyAppBarWithStack(
            text: "Kategoriler ",
            radius: context.highValue * 0.8,
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(horizontal: context.width * 0.07),
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
              child: InkWell(
                onTap: () {
                  this.setState(() {
                    showSearch(
                        context: context,
                        delegate:
                            DataSearch(subjects, subjects_string, navigation));
                  });
                },
                child: Container(
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(left: 10),
                          child: Text("Konu Ara"),
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.search),
                        color: Colors.black,
                        onPressed: () {
                          this.setState(() {
                            showSearch(
                                context: context,
                                delegate: DataSearch(
                                    subjects, subjects_string, navigation));
                          });
                        },
                      )
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Container categoryCard(String category, int index) => Container(
          child: AppCategoryCard(
        text: category,
        onpressed: () {
          setState(() {
            api_category_url = "";
            api_category_url = category;
            logger.i("$api_category_url konuları listelendi");
            _selectedIndex = index;
            navigation.navigateToPage(path: NavigationConstants.SUB_CATEGORY);
          });
        },
      ));
}
