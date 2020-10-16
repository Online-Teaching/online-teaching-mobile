import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:online_teaching_mobile/app/model/category_model.dart';
import 'package:http/http.dart' as http;

import '../../view_model/category_page_view_model.dart';

class CategoryView extends CategoryViewModel {
  int _selectedIndex;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<String> kategori = new List<String>();
    for (var c in categories) {
      kategori.add(c.title);
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
          style: TextStyle(color: Colors.black, fontSize: 21),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            color: Colors.black,
            onPressed: () {
              showSearch(context: context, delegate: DataSearch(kategori));
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
              selecaItem(category.title);
            });
          },
        ),
      ));
}

class DataSearch extends SearchDelegate<String> {
  final List<String> categories;

  DataSearch(this.categories);

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
            selecaItem(suggestionList[index]);
          },
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

void selecaItem(String category_name) {
  print(category_name); //// bu name ile özet sayfasına gidilir.
}
