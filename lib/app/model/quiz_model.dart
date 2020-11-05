class MyQuiz {
  int id;
  List<Question> questionList;

  MyQuiz({this.id, this.questionList});

  MyQuiz.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['questionList'] != null) {
      questionList = new List<Question>();
      json['questionList'].forEach((v) {
        questionList.add(new Question.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.questionList != null) {
      data['questionList'] = this.questionList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Question {
  String answer1;
  String answer2;
  String answer3;
  String answer4;
  int correct;
  String question;

  Question(
      {this.answer1,
      this.answer2,
      this.answer3,
      this.answer4,
      this.correct,
      this.question});

  Question.fromJson(Map<String, dynamic> json) {
    answer1 = json['answer1'];
    answer2 = json['answer2'];
    answer3 = json['answer3'];
    answer4 = json['answer4'];
    correct = json['correct'];
    question = json['question'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['answer1'] = this.answer1;
    data['answer2'] = this.answer2;
    data['answer3'] = this.answer3;
    data['answer4'] = this.answer4;
    data['correct'] = this.correct;
    data['question'] = this.question;
    return data;
  }
}
