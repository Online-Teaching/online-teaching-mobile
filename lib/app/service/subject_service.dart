import 'dart:convert';

import 'package:online_teaching_mobile/app/model/subject_model.dart';
import 'package:online_teaching_mobile/app/service/interfaces/ISubject.dart';
import 'package:online_teaching_mobile/core/constant/app_constant.dart';

import 'api/API.dart';
import 'package:http/http.dart' as http;

class SubjectService implements ISubjecteService {
  static List<Subject> subjects = [];
  static SubjectService _instance;
  static SubjectService get instance {
    if (_instance == null) _instance = SubjectService._init();
    return _instance;
  }

  SubjectService._init();

  Future<List<Subject>> getSubjectList() async {
    API api = new API();
    final baseUrl = api.getOnlineTeaching_2_Url();
    var _response = await http.get("$baseUrl/konuid_title_list.json");
    var jsonData = json.decode(_response.body);
    //https://online-teaching2.firebaseio.com/kategoriler/mat.json
    subjects = [];
    for (var c in jsonData) {
      print("service // subjects");
      subjects.add(Subject.fromJson(c));
    }
    return subjects;
  }
}
