import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:online_teaching_mobile/app/model/category_model.dart';
import 'package:http/http.dart' as http;
import 'package:online_teaching_mobile/core/constant/navigation_constant.dart';
import 'package:online_teaching_mobile/core/extension/context_extension.dart';
import 'category_page_view_model.dart';

class CategoryView extends CategoryViewModel {
  int _selectedIndex;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<String> categories_name = new List<String>();
    for (var item in categories) {
      categories_name.add(item.title);
    }
    return Scaffold(
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
          "Categories",
          style: context.textTheme.headline5.copyWith(color: Colors.black),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            color: Colors.black,
            onPressed: () {
              this.setState(() {
                showSearch(
                    context: context,
                    delegate:
                        DataSearch(categories_name, navigation, categories));
              });
            },
          )
        ],
      ),
      drawer: Drawer(),
      body: futureBuilderCategories(categories),
    );
  }

  Container futureBuilderCategories(List<Category> c) {
    return Container(
      child: FutureBuilder(
        future: getList(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            return Container(child: Center(child: Text("Loading...")));
          } else {
            return ListView.builder(
                itemCount: categories.length,
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) =>
                    categoryCard(categories[index], index));
          }
        },
      ),
    );
  }

  Container categoryCard(Category category, int index) => Container(
          child: Card(
        child: ListTile(
          selected: index == _selectedIndex,
          title: Text(category.title),
          onTap: () {
            setState(() {
              _selectedIndex = index;
              selecaItem(navigation, categories[index]);
            });
          },
        ),
      ));
}

class DataSearch extends SearchDelegate<String> {
  final List<String> categories_name_list;
  var navigation;
  final List<Category> categoryList;
  DataSearch(this.categories_name_list, this.navigation, this.categoryList);

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
        : categories_name_list
            .where((p) => p.toUpperCase().contains(query.toUpperCase()))
            .toList();

    return ListView.builder(
      itemBuilder: (context, index) => ListTile(
          onTap: () {
            close(context, null);
            findItem(navigation, suggestionList[index]);
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

  void findItem(navigation, String category_name) {
    print(category_name);
    for (var item in categoryList) {
      if (category_name == item.title) {
        selecaItem(navigation, item);
      }
    }
  }
}

void selecaItem(navigation, Category selected_category) {
  navigation.navigateToPage(
      path: NavigationConstants.SUMMARY_VIEW, data: selected_category);
}
