import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:online_teaching_mobile/app/model/category_model.dart';
import 'package:http/http.dart' as http;

import '../../view_model/category_page_view_model.dart';

class CategoryView extends CategoryViewModel {
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
          style: TextStyle(color: Colors.black, fontSize: 21),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            color: Colors.black,
            onPressed: () {
              showSearch(context: context, delegate: DataSearch());
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
        future: getData(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            return Container(child: Center(child: Text("Loading...")));
          } else {
            return ListView.builder(
                itemCount: categories.length,
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) =>
                    categoryCard(categories[index]));
          }
        },
      ),
    );
  }

  Container categoryCard(Category category) => Container(
          child: Card(
        child: ListTile(title: Text(category.title)),
      ));
}

class DataSearch extends SearchDelegate<String> {
  final categoriesList = [
    "elma",
    "armut",
    "muz",
    "kayısı",
    "çilek",
    "kavun",
    "ananas"
  ];
  final recentCategories = [
    "çilek",
    "elma",
    "muz",
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
    return Text(query);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList = query.isEmpty
        ? recentCategories
        : categoriesList.where((p) => p.contains(query)).toList();
    return ListView.builder(
      itemBuilder: (context, index) => ListTile(
          onTap: () {
            showResults(context);
          },
          leading: Icon(Icons.adjust),
          title: RichText(
              text: TextSpan(
                  text: suggestionList[index].substring(0, query.length),
                  style: TextStyle(
                      fontSize: 17,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                  children: [
                TextSpan(
                    text: suggestionList[index].substring(query.length),
                    style: TextStyle(fontSize: 17, color: Colors.grey))
              ]))),
      itemCount: suggestionList.length,
    );
  }
}
