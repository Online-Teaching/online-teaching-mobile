class Category {
  String id;
  String title;
  String summary;

  Category({this.id, this.title});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    summary = json['summary'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['summary'] = this.summary;
    return data;
  }

  Map toJson2() {
    return {
      'id': id,
      'title': title,
      'summary': summary,
    };
  }
}
