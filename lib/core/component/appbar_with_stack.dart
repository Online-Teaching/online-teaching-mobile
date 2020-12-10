import 'package:flutter/material.dart';
import 'package:online_teaching_mobile/core/extension/context_extension.dart';

class MyAppBarWithStack extends StatelessWidget {
  final String text;
  final double radius;
  const MyAppBarWithStack({Key key, this.text, this.radius}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      padding: EdgeInsets.only(
          top: context.mediumValue * 1.3,
          left: context.mediumValue,
          right: context.mediumValue),
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(radius),
          bottomRight: Radius.circular(radius),
        ),
        boxShadow: [
          BoxShadow(
            //offset: Offset(0, 1),
            blurRadius: 10,
            //  color: Colors.blue.withOpacity(0.23),
          ),
        ],
      ),
      child: Text(
        this.text,
        style: Theme.of(context)
            .textTheme
            .headline5
            .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
      ),
    );
  }
}
