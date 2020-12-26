class Subject {
  String id;
  String title;
  String length;

  Subject({this.id, this.title, this.length});

  Subject.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    length = json['length'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['length'] = this.length;
    return data;
  }
}
