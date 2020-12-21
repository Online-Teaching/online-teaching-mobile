import 'package:flutter/material.dart';
import 'package:online_teaching_mobile/core/extension/context_extension.dart';

class AppCategoryCard extends StatelessWidget {
  final String text;
  final Function onpressed;
  const AppCategoryCard({Key key, this.text, this.onpressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: context.highValue * 1.15,
        margin: EdgeInsets.symmetric(
            horizontal: context.lowValue, vertical: context.lowValue * 0.3),
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(context.normalValue),
            bottomRight: Radius.circular(context.normalValue),
            topLeft: Radius.circular(context.normalValue),
            topRight: Radius.circular(context.normalValue),
          ),
          boxShadow: [
            BoxShadow(
              spreadRadius: 1,
              //offset: Offset(0, 1),
              blurRadius: 7,
              color: Colors.blueGrey.withOpacity(0.25),
            ),
          ],
        ),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(context.normalValue),
          ),
          color: Colors.red[200],
          child: ListTile(
              title: Center(
                  child: Text(
                text.toUpperCase(),
                style: context.textTheme.bodyText2.copyWith(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: context.normalValue),
              )),
              onTap: onpressed),
        ));
  }
}
