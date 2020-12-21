import 'package:flutter/material.dart';
import 'package:online_teaching_mobile/core/extension/context_extension.dart';

class AppButton extends StatelessWidget {
  final String text;
  final Function onpressed;
  const AppButton({Key key, this.text, this.onpressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.8,
      height: context.highValue * 0.7,
      child: FlatButton(
        color: Colors.red,
        child: Text(
          this.text,
          style: context.textTheme.bodyText2.copyWith(color: Colors.white),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(context.highValue),
        ),
        onPressed: onpressed,
      ),
    );
  }
}
