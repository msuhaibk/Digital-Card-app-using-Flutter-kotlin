class CommentsListParser {
  String id;
  String email;
  String description;
  String createdAt;

  CommentsListParser({this.id, this.email, this.description, this.createdAt});

  CommentsListParser.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    description = json['description'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['email'] = this.email;
    data['description'] = this.description;
    data['created_at'] = this.createdAt;
    return data;
  }
}
