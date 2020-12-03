import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:online_teaching_mobile/app/model/category_model.dart';
import 'package:online_teaching_mobile/app/model/quiz_model.dart';
import 'package:online_teaching_mobile/app/service/api/apiUrl.dart';
import 'package:online_teaching_mobile/app/view_model/quiz_view_model.dart';
import 'package:online_teaching_mobile/core/constant/navigation_constant.dart';
import 'package:online_teaching_mobile/core/extension/context_extension.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

class QuizView extends QuizViewModel {
  //radiobutton
  int selectedRadioTile;
  int correct_answer = 0;
  int wrong_answer = 0;
  int selectedRadio;
  //stepper
  List<Step> steps = List<Step>(10);
  int currentStep = 0;
  bool complete = false;
  StepperType stepperType = StepperType.vertical;
  switchStepType() {
    setState(() => stepperType == StepperType.horizontal
        ? stepperType = StepperType.vertical
        : stepperType = StepperType.horizontal);
  }

  /// quiz not with shared preferences
  List<String> quizNote = [];
  List<String> quizid = [];

  SharedPreferences preferences;

  @override
  void initState() {
    super.initState();
    selectedRadio = 0;
    selectedRadioTile = 0;
    getLocalData();
  }

  Future getLocalData() async {
    preferences = await SharedPreferences.getInstance();
    quizid = preferences.getStringList("quizid");
    quizNote = preferences.getStringList("quizNote");

    preferences.setStringList("quizid", quizid);
    preferences.setStringList("quizNote", quizNote);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: scaffoldWidget(context),
        onWillPop: () {
          return showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text("Confirm Exit"),
                  content: Text("Are you sure you want to exit?"),
                  actions: <Widget>[
                    FlatButton(
                      child: Text("YES"),
                      onPressed: () {
                        SystemNavigator.pop();
                      },
                    ),
                    FlatButton(
                      child: Text("NO"),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    )
                  ],
                );
              });
          return Future.value(true);
        });
  }

  Scaffold scaffoldWidget(BuildContext context) {
    return new Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: Icon(
              Icons.close,
              color: Colors.black,
            ),
            onPressed: () {
              navigation.navigateToPage(
                  path: NavigationConstants.BOTTOM_NAVIGATION);
            },
          ),
          title: Text(
            "Quiz",
            style: context.textTheme.headline5.copyWith(color: Colors.black),
          ),
        ),
        body: quizViewWidget());
  }

  Column quizViewWidget() {
    return Column(children: <Widget>[
      complete
          ? Expanded(
              child: Center(
                child: AlertDialog(
                  title: new Text("Puanınız"),
                  content: new Text(
                    "${correct_answer * 10}",
                    style: TextStyle(fontSize: 30),
                  ),
                  actions: <Widget>[
                    new FlatButton(
                      child: new Text("Close"),
                      onPressed: () {
                        setQuizNote_SP(correct_answer * 10, myquiz.id);
                        complete = false;
                        navigation.navigateToPageClear(
                            path: NavigationConstants.BOTTOM_NAVIGATION);
                      },
                    ),
                  ],
                ),
              ),
            )
          : Expanded(
              child: Theme(
              data: ThemeData(
                  accentColor: Colors.red,
                  primarySwatch: Colors.red, //stepper rengi
                  colorScheme: ColorScheme.light(primary: Colors.orange)),
              child: FutureBuilder(
                  future: getquiz(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      print("logquiz 1 " + myquiz.toString());
                      if (snapshot.data != null) {
                        print("logquiz 2 " + myquiz.toString());
                        if (myquiz.questionList.length == 0) {
                          print("logquiz 3 " + myquiz.toString());
                          return Center(
                              child: Text("Bu konunun quizi bulunmuyor."));
                        } else {
                          print("logquiz 4 " + myquiz.toString());
                          build_stapper();
                          return Stepper(
                            steps: steps,
                            type: stepperType,
                            currentStep: currentStep,
                            onStepTapped: (step) =>
                                setState(() => currentStep = step),
                            onStepContinue: true
                                ? () => setState(() {
                                      calculate_points(currentStep);
                                      if (currentStep != 9)
                                        ++currentStep;
                                      else if (currentStep == 9) {
                                        complete = true;
                                      }
                                    })
                                : null,
                          );
                        }
                      }
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  }),

              /*Stepper(
                                        steps: steps,
                                        type: stepperType,
                                        currentStep: currentStep,
                                        onStepTapped: (step) => setState(() => currentStep = step),
                                        onStepContinue: true
                                            ? () => setState(() {
                                                  print("heyyyyy nuuuuuuuuuuulllllllllllll");
                        
                                                  calculate_points(currentStep);
                                                  if (currentStep != 9)
                                                    ++currentStep;
                                                  else if (currentStep == 9) {
                                                    print("test bitti başka sayfaya geç");
                                                    complete = true;
                                                  }
                                                })
                                            : null,
                                      ),
                                      */
            )),
    ]);
  }

  void calculate_points(int index) {
    if (myquiz.questionList[index].correct == selectedRadioTile) {
      correct_answer++;
      print(myquiz.questionList[index].correct.toString() +
          "            " +
          selectedRadioTile.toString());
      print(correct_answer);
    } else {
      wrong_answer++;
      print(myquiz.questionList[index].correct.toString() +
          "            " +
          selectedRadioTile.toString());
      print(wrong_answer);
    }
    selectedRadioTile = 0;
  }

  void build_stapper() {
    for (var i = 0; i < 10; i++) {
      steps[i] = Step(
          isActive: true,
          title: Text(
            '${i + 1}. Question',
            style: context.textTheme.headline6,
          ),
          content: Column(
            children: questionCard(i),
          ),
          state: i == currentStep
              ? StepState.editing
              : i < currentStep ? StepState.complete : StepState.indexed);
    }
  }

  List<Widget> questionCard(int i) => <Widget>[
        Container(
          /// Container ı card ile sarmalayabilirsin !
          padding: EdgeInsets.all(13),
          child: Column(
            children: [
              Text(
                myquiz.questionList[i].question,
                style:
                    context.textTheme.bodyText1.copyWith(color: Colors.black),
              ),
              eachRadioButton(myquiz.questionList[i].answer1, 1),
              eachRadioButton(myquiz.questionList[i].answer2, 2),
              eachRadioButton(myquiz.questionList[i].answer3, 3),
              eachRadioButton(myquiz.questionList[i].answer4, 4),
            ],
          ),
        )
      ];

  RadioListTile eachRadioButton(String cevap, int i) {
    return RadioListTile(
      value: i,
      groupValue: selectedRadioTile,
      title: Text(
        cevap,
        style: TextStyle(fontSize: context.normalValue),
      ),
      onChanged: (val) {
        print("Radio Tile pressed $val");
        setSelectedRadioTile(val);
      },
      activeColor: Colors.black,
      selected: true,
    );
  }

  setSelectedRadioTile(int val) {
    setState(() {
      selectedRadioTile = val;
    });
  }

  Future<void> setQuizNote_SP(int note, String id) async {
    // shared preferences ile quizid ve quiz not kaydet

    int index;

    quizid = preferences.getStringList("quizid");
    quizNote = preferences.getStringList("quizNote");

    try {
      if (quizid.contains(id)) {
        index = quizid.indexOf(id);
        quizid.remove(id);
        quizNote.removeAt(index);
      }
      quizid.add(id);
      quizNote.add(note.toString());
    } catch (e) {
      preferences.setStringList("quizid", [""]);
      preferences.setStringList("quizNote", [""]);
      quizid = preferences.getStringList("quizid");
      quizNote = preferences.getStringList("quizNote");
      quizid.add(id);
      quizNote.add(note.toString());
    }

    preferences.setStringList("quizid", quizid);
    preferences.setStringList("quizNote", quizNote);

    print("quiznotesıralaması log/quiz view close butonu " + quizid.toString());
    print(
        "quiznotesıralaması log/quiz view close butonu " + quizNote.toString());

    print(quizNote.length.toString() + "note uzunluğuu");
  }
}
