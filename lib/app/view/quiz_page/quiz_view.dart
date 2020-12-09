import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logger/logger.dart';
import 'package:online_teaching_mobile/app/view/quiz_page/build_stepper.dart';
import 'package:online_teaching_mobile/app/view_model/quiz_view_model.dart';
import 'package:online_teaching_mobile/core/constant/navigation_constant.dart';
import 'package:online_teaching_mobile/core/extension/context_extension.dart';
import 'package:online_teaching_mobile/core/logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:online_teaching_mobile/core/extension/context_extension.dart';

class QuizView extends QuizViewModel {
  final logger = Logger(printer: SimpleLogPrinter('quiz_view.dart'));
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

  Future getLocalData() async {
    preferences = await SharedPreferences.getInstance();
    quizid = preferences.getStringList("quizid");
    quizNote = preferences.getStringList("quizNote");

    preferences.setStringList("quizid", quizid);
    preferences.setStringList("quizNote", quizNote);

    logger.i("getLocalData | quizid -> $quizid");
    logger.i("getLocalData | quizNote -> $quizNote");
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
                      child: new Text("Kapat"),
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
                      if (snapshot.data != null) {
                        if (myquiz.questionList.length == 0) {
                          return Center(
                              child: Text("Bu konunun quizi bulunmuyor."));
                        } else {
                          build_stapper();
                          return Stepper(
                            steps: steps,
                            type: stepperType,
                            currentStep: currentStep,
                            //onStepTapped: (step) =>setState(() => currentStep = step),
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
            )),
    ]);
  }

  void calculate_points(int index) {
    if (myquiz.questionList[index].correct == selectedRadioTile) {
      correct_answer++;

      logger.i("calculate_points | $correct_answer doğru cevap verildi.");
    } else {
      wrong_answer++;
      logger.i("calculate_points | $wrong_answer yanlış cevap verildi.");
    }
    selectedRadioTile = 0;
  }

  void build_stapper() {
    logger.i("build_stepper | each step");
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
        MyStepper(
          i: i,
          myquiz: myquiz,
          onpressed: (val) {
            setState(() {
              selectedRadioTile = val;
            });
          },
          selectedradioTile: selectedRadioTile,
        )
      ];

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
      logger.e("setQuizNote_SP | quizid ye ulaşılamadı");
      preferences.setStringList("quizid", [""]);
      preferences.setStringList("quizNote", [""]);
      quizid = preferences.getStringList("quizid");
      quizNote = preferences.getStringList("quizNote");
      quizid.add(id);
      quizNote.add(note.toString());
      logger.e("setQuizNote_SP | quizid ve quizNote oluşturuldu");
    }

    preferences.setStringList("quizid", quizid);
    preferences.setStringList("quizNote", quizNote);

    logger.i("setQuizNote_SP | yeni quizid -> $quizid");
    logger.i("setQuizNote_SP | yeni quizNote -> $quizNote");
  }
}
