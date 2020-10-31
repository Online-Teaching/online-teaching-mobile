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
              showSearch(
                  context: context,
                  delegate: DataSearch(categories_name, navigation));
            },
          )
        ],
      ),
      drawer: Drawer(),
      body: futureBuilderCategories(),
    );
  }

  Container futureBuilderCategories() {
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
              selecaItem(category.title, navigation);
            });
          },
        ),
      ));
}

class DataSearch extends SearchDelegate<String> {
  final List<String> categories;
  var navigation;

  DataSearch(this.categories, this.navigation);

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
        : categories.where((p) => p.contains(query)).toList();

    return ListView.builder(
      itemBuilder: (context, index) => ListTile(
          onTap: () {
            close(context, null);
            selecaItem(suggestionList[index], navigation);
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
}

void selecaItem(String category_name, navigation) {
  print(category_name); //// bu name ile özet sayfasına gidilir.
  navigation.navigateToPage(path: NavigationConstants.SPLASH_VIEW, data: 20);
}
