import 'package:flutter/material.dart';
import 'package:online_teaching_mobile/app/model/question_model.dart';
import 'package:online_teaching_mobile/app/view/quiz_page/quiz_view_model.dart';
import 'package:online_teaching_mobile/core/constant/navigation_constant.dart';
import 'package:online_teaching_mobile/core/extension/context_extension.dart';

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

  @override
  void initState() {
    super.initState();
    selectedRadio = 0;
    selectedRadioTile = 0;
  }

  @override
  Widget build(BuildContext context) {
    build_stapper();

    return new Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
            onPressed: () {
              //  navigation.navigateToPage(path: NavigationConstants.SUMMARY_VIEW);
            },
          ),
          title: Text(
            "Quiz",
            style: context.textTheme.headline5.copyWith(color: Colors.black),
          ),
        ),
        body: Column(children: <Widget>[
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
                            complete = false;
                            navigation.navigateToPage(
                                path: NavigationConstants.CATEGORY_VIEW);
                          },
                        ),
                      ],
                    ),
                  ),
                )
              : Expanded(
                  child: Stepper(
                    steps: steps,
                    type: stepperType,
                    currentStep: currentStep,
                    //  onStepTapped: (step) => setState(() => currentStep = step),
                    onStepContinue: true
                        ? () => setState(() {
                              calculate_points(currentStep);
                              if (currentStep != 9)
                                ++currentStep;
                              else if (currentStep == 9) {
                                print("test bitti başka sayfaya geç");
                                complete = true;
                              }
                            })
                        : null,
                    /*
                    onStepCancel: true
                        ? () => setState(() {
                            if (currentStep == 0) {
                              print("geri gidiliyor..");
                            } else {
                              --currentStep;
                            }
                          })
                      : null,
                      */
                  ),
                ),
        ]));
  }

  void calculate_points(int index) {
    if (soruList10[index].correct == selectedRadioTile) {
      correct_answer++;
      print(soruList10[index].correct.toString() +
          "            " +
          selectedRadioTile.toString());
      print(correct_answer);
    } else {
      wrong_answer++;
      print(soruList10[index].correct.toString() +
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
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Container(
            padding: EdgeInsets.all(13),
            child: Column(
              children: [
                Text(
                  soruList10[i].question,
                  style:
                      context.textTheme.bodyText1.copyWith(color: Colors.black),
                ),
                eachRadioButton(soruList10[i].answer1, 1),
                eachRadioButton(soruList10[i].answer2, 2),
                eachRadioButton(soruList10[i].answer3, 3),
                eachRadioButton(soruList10[i].answer4, 4),
              ],
            ),
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
}
