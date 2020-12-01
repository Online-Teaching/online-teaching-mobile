class BookMarkSubCategory {
  String id;
  String summary;
  String title;

  BookMarkSubCategory({this.id, this.summary, this.title});

  BookMarkSubCategory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    summary = json['summary'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['summary'] = this.summary;
    data['title'] = this.title;
    return data;
  }
}
