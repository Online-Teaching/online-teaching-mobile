import 'package:flutter/material.dart';
import 'package:online_teaching_mobile/app/model/subject_model.dart';
import 'package:online_teaching_mobile/app/service/interfaces/ISubject.dart';
import 'package:online_teaching_mobile/app/service/subject_service.dart';
import 'package:online_teaching_mobile/app/view/profile_page/profile.dart';
import 'package:online_teaching_mobile/core/constant/app_constant.dart';
import 'package:online_teaching_mobile/core/init/navigation/navigation_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class ProfileViewModel extends State<Profile> with BaseViewModel {
  SharedPreferences preferences;
  List<String> myQuizIdList = [];
  List<String> myQuizNoteList = [];
  List<Subject> mySubjectList_service = [];
  double myAverage;

/////
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
    subjects = await subjecteService.getSubjectList();

    mySubjectList_service = [];
    preferences = await SharedPreferences.getInstance();
    myQuizIdList = preferences.getStringList("quizid");
    myQuizNoteList = preferences.getStringList("quizNote");
    for (var item in subjects) {
      if (myQuizIdList.contains(item.id)) {
        if (!mySubjectList_service.contains(item)) {
          mySubjectList_service.add(item);
        }
      }
    }
    for (var item in mySubjectList_service) {
      print("??????????????????????*" + item.title);
    }
    return mySubjectList_service;
  }

  Future<void> getAverage() async {
    print(myQuizIdList.length.toString() + "  quiz id uzunluk");
    print(myQuizNoteList.length.toString() + "  quiz note uzunluk");
    int sum = 0;
    int i = 0;
    for (i = 1; i < myQuizNoteList.length; i++) {
      sum += int.parse(myQuizNoteList[i]);
    }
    myAverage = sum / (myQuizNoteList.length - 1);

    return myAverage;
  }
}

abstract class BaseViewModel {
  NavigationService navigation = NavigationService.instance;
}
