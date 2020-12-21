import 'package:flutter/material.dart';
import 'package:online_teaching_mobile/app/model/subject_model.dart';
import 'package:online_teaching_mobile/app/service/api/apiUrl.dart';
import 'package:online_teaching_mobile/app/view_model/home_view_model.dart';
import 'package:online_teaching_mobile/core/constant/navigation_constant.dart';
import 'package:online_teaching_mobile/core/extension/context_extension.dart';

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
  Widget buildResults(BuildContext context) {
    return Center(
      child: Text("Lütfen konu seçiniz"),
    );
  }

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
    GetCategoryClass category = new GetCategoryClass();
    category.getSingleCategory();
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

class GetCategoryClass extends HomeViewModel {
  @override
  Future<void> getSingleCategory() {
    // TODO: implement getSingleCategory
    return super.getSingleCategory();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
