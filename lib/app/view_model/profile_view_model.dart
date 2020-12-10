import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:online_teaching_mobile/app/model/subject_model.dart';
import 'package:online_teaching_mobile/app/service/interfaces/ISubject.dart';
import 'package:online_teaching_mobile/app/service/subject_service.dart';
import 'package:online_teaching_mobile/app/view/profile_page/profile.dart';
import 'package:online_teaching_mobile/core/constant/app_constant.dart';
import 'package:online_teaching_mobile/core/logger/logger.dart';
import 'package:online_teaching_mobile/core/init/navigation/navigation_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class ProfileViewModel extends State<Profile> with BaseViewModel {
  final logger = Logger(printer: SimpleLogPrinter('profile_view_model.dart'));
  SharedPreferences preferences;
  List<String> myQuizIdList = [];
  List<String> myQuizNoteList = [];
  List<Subject> mySubjectList_service = [];
  double myort;
  int isExistQuiz;

  ///// subjects
  bool isLoading = false;
  List<Subject> subjects = [];
  ISubjecteService subjecteService;

  @override
  void initState() {
    super.initState();
    subjecteService = SubjectService.instance;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void changeLoading() {
    setState(() {
      isLoading = !isLoading;
    });
  }

  Future<void> getSubjects() async {
    try {
      subjects = await subjecteService.getSubjectList();

      mySubjectList_service = [];
      preferences = await SharedPreferences.getInstance();
      myQuizIdList = preferences.getStringList("quizid");
      logger.i("getSubjects | quizid -> $myQuizIdList");

      for (var item in myQuizIdList) {
        int i = 0;
        for (i = 0; i < subjects.length; i++) {
          if (item == subjects[i].id) {
            mySubjectList_service.add(subjects[i]);
          }
        }
      }

      return mySubjectList_service;
    } catch (e) {
      logger.e("getSubjects | error");
      return mySubjectList_service;
    }
  }

  Future<void> getAverage() async {
    try {
      preferences = await SharedPreferences.getInstance();
      myQuizNoteList = preferences.getStringList("quizNote");

      int sum = 0;
      int i = 0;
      for (i = 1; i < myQuizNoteList.length; i++) {
        sum += int.parse(myQuizNoteList[i]);
      }
      if (myQuizIdList.length == 0) {
        logger.i("listelenecek quiz yok");
        isExistQuiz = 0;
      } else if (myQuizIdList.length >= 1) {
        logger.i("listelenecek quiz var");
        isExistQuiz = 1;
      }

      star = myort / 20;
      myort = sum / (myQuizNoteList.length - 1);

      return star;
    } catch (e) {
      return 0;
    }
  }
}

abstract class BaseViewModel {
  NavigationService navigation = NavigationService.instance;
}
