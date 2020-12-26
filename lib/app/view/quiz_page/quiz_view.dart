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
  String totalquestionlength;
  //stepper

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
    return Scaffold(
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

  Future getLocalData() async {
    preferences = await SharedPreferences.getInstance();
    quizid = preferences.getStringList("quizid");
    quizNote = preferences.getStringList("quizNote");

    preferences.setStringList("quizid", quizid);
    preferences.setStringList("quizNote", quizNote);

    logger.i("getLocalData | quizid -> $quizid");
    logger.i("getLocalData | quizNote -> $quizNote");
  }

  Column quizViewWidget() {
    return Column(children: <Widget>[
      complete
          ? Expanded(
              child: Center(
                child: AlertDialog(
                  title: new Text("Toplam soru sayısı: ${totalquestionlength}"),
                  content: new Text(
                    "Doğru cevap sayısı : ${correct_answer} ",
                    style: TextStyle(fontSize: 30),
                  ),
                  actions: <Widget>[
                    new FlatButton(
                      child: new Text("Kapat"),
                      onPressed: () {
                        int x = (100 * correct_answer);
                        int y = myquiz.questionList.length;
                        setQuizNote_SP(
                            (x / y).toInt(), myquiz.id); // not kaydet
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
                        List<Step> steps =
                            List<Step>(myquiz.questionList.length);
                        if (myquiz.questionList.length == 0) {
                          return Center(
                              child: Text("Bu konunun quizi bulunmuyor."));
                        } else {
                          build_stapper(steps, myquiz.questionList.length);
                          int length = myquiz.questionList.length;
                          return Stepper(
                            steps: steps,
                            type: stepperType,
                            currentStep: currentStep,
                            //onStepTapped: (step) =>setState(() => currentStep = step),
                            onStepContinue: true
                                ? () => setState(() {
                                      int length = myquiz.questionList.length;
                                      totalquestionlength = length.toString();
                                      calculate_points(currentStep);
                                      if (currentStep != length - 1)
                                        ++currentStep;
                                      else if (currentStep == length - 1) {
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

  void build_stapper(List<Step> steps, int length) {
    logger.i("build_stepper | each step");
    for (var i = 0; i < length; i++) {
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
