import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:online_teaching_mobile/app/model/subject_model.dart';
import 'package:online_teaching_mobile/app/service/api/apiUrl.dart';
import 'package:online_teaching_mobile/app/view_model/home_view_model.dart';
import 'package:online_teaching_mobile/core/component/appbar_with_stack.dart';
import 'package:online_teaching_mobile/core/component/category_card.dart';
import 'package:online_teaching_mobile/core/constant/navigation_constant.dart';
import 'package:online_teaching_mobile/core/logger/logger.dart';
import 'package:online_teaching_mobile/core/extension/context_extension.dart';

class HomeView extends HomeViewModel {
  final logger = Logger(printer: SimpleLogPrinter('home_view.dart'));
  @override
  Icon icon = Icon(Icons.bookmark_border);
  int _selectedIndex;
  Subject gotothisSubject;
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
              left: context.normalValue,
              right: context.normalValue),
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
                    child: Container(
                      child: Text("ffff"),
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

class DataSearch extends SearchDelegate<String> {
  final List<Subject> subjects_list;
  final List<String> subjects_name_list;
  var navigation;

  DataSearch(this.subjects_list, this.subjects_name_list, this.navigation);

  final recentCategories = [
    "",
  ];
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = "";
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow, progress: transitionAnimation),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {}

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList = query.isEmpty
        ? recentCategories
        : subjects_name_list
            .where((p) => p.toUpperCase().contains(query.toUpperCase()))
            .toList();

    return ListView.builder(
      itemBuilder: (context, index) => ListTile(
          onTap: () {
            close(context, null);
            findkonuid(suggestionList[index]);
          },
          title: RichText(
              text: TextSpan(
                  text: suggestionList[index].substring(0, query.length),
                  style:
                      context.textTheme.headline6.copyWith(color: Colors.black),
                  children: [
                TextSpan(
                  text: suggestionList[index].substring(query.length),
                  style:
                      context.textTheme.headline6.copyWith(color: Colors.grey),
                )
              ]))),
      itemCount: suggestionList.length,
    );
  }

  findkonuid(String id) {
    Subject gotothisSubject;
    for (var item in subjects_list) {
      if (id == item.title) {
        gotothisSubject = item;
        create_Url(item.id);
        navigation.navigateToPage(path: NavigationConstants.DETAIL_VIEW);
      }
    }
  }

  void create_Url(String id) {
    String category_url = "";
    String sub_category_url = "";
    id.runes.forEach((int rune) {
      if (isIntNumber(String.fromCharCode(rune))) {
        sub_category_url += String.fromCharCode(rune);
      } else {
        category_url += String.fromCharCode(rune);
      }
    });

    api_category_url = category_url;
    api_sub_category_index = sub_category_url;
    //  getSingleCategory();
  }
}

isIntNumber(String char) {
  List<String> numberList = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"];
  if (numberList.contains(char)) {
    return true;
  } else {
    return false;
  }
}
