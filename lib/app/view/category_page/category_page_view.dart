import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:online_teaching_mobile/app/api/API.dart';
import 'package:online_teaching_mobile/app/model/category_model.dart';
import 'package:http/http.dart' as http;

import 'category_page_view_model.dart';

class CategoryView extends CategoryViewModel {
  List<Category> categories = [];
  var users = new List<Category>();

  @override
  void initState() {
    super.initState();
  }

  Future<List<Category>> getData() async {
    var _response =
        await http.get("https://online-teaching-14e16.firebaseio.com/.json");
    var jsonData = json.decode(_response.body);

    for (var c in jsonData) {
      categories.add(Category.fromJson(c));
    }

    return categories;
  }

  _getUsers() {
    API.getUsers().then((response) {
      setState(() {
        Iterable list = json.decode(response.body);
        users = list.map((model) => Category.fromJson(model)).toList();
      });
    });
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
            icon: Icon(Icons.sort),
            color: Colors.black,
            onPressed: () {},
          )
        ],
      ),
      body: Container(
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
      ),
    );
  }

  Container categoryCard(Category category) => Container(
          child: Card(
        child: ListTile(title: Text(category.title)),
      ));
}
