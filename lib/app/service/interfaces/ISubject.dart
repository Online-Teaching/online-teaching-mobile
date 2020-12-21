import 'package:online_teaching_mobile/app/model/subject_model.dart';

abstract class ISubjecteService {
  Future<List<Subject>> getSubjectList();
}
