import 'package:flutter/material.dart';
import 'package:online_teaching_mobile/core/extension/context_extension.dart';

class AppSubCategoryCard extends StatelessWidget {
  final ListTile listTile;
  const AppSubCategoryCard({Key key, this.listTile}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(
            horizontal: context.mediumValue, vertical: context.lowValue * 0.5),
        decoration: BoxDecoration(
          color: Colors.blueGrey[100],
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(context.normalValue),
            bottomRight: Radius.circular(context.normalValue),
            topLeft: Radius.circular(context.normalValue),
            topRight: Radius.circular(context.normalValue),
          ),
        ),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(context.normalValue),
          ),
          child: listTile,
        ));
  }
}
