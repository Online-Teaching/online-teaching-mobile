import 'package:flutter/material.dart';
import 'package:online_teaching_mobile/app/model/quiz_model.dart';
import 'package:online_teaching_mobile/core/extension/context_extension.dart';

class MyStepper extends StatelessWidget {
  final int i;
  final MyQuiz myquiz;
  final int selectedradioTile;
  final Function onpressed;
  const MyStepper(
      {Key key, this.i, this.myquiz, this.onpressed, this.selectedradioTile})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Question question = new Question();
    question = myquiz.questionList[i];
    bool isAnswer1 = question.answer1 != null;
    bool isAnswer2 = question.answer2 != null;
    bool isAnswer3 = question.answer3 != null;
    bool isAnswer4 = question.answer4 != null;
    return Container(
      /// Container ı card ile sarmalayabilirsin !
      padding: EdgeInsets.all(13),
      child: Column(
        children: [
          Text(
            myquiz.questionList[i].question,
            style: context.textTheme.bodyText1.copyWith(color: Colors.black),
          ),
          isAnswer1 == false
              ? Text("")
              : eachRadioButton(myquiz.questionList[i].answer1, 1),
          isAnswer2 == false
              ? Text("")
              : eachRadioButton(myquiz.questionList[i].answer1, 2),
          isAnswer3 == false
              ? Text("")
              : eachRadioButton(myquiz.questionList[i].answer1, 3),
          isAnswer4 == false
              ? Text("")
              : eachRadioButton(myquiz.questionList[i].answer4, 4),
        ],
      ),
    );
  }

  RadioListTile eachRadioButton(String cevap, int i) {
    return RadioListTile(
      value: i,
      groupValue: selectedradioTile,
      title: Text(
        cevap,
        style: TextStyle(fontSize: 17),
      ),
      onChanged: onpressed,
      activeColor: Colors.black,
      selected: true,
    );
  }
}
