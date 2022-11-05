class FollowupListParser {
  String id;
  String userId;
  String name;
  String email;
  String phone;
  String createdAt;
  String about;
  String status;

  FollowupListParser(
      {this.id,
        this.userId,
        this.name,
        this.email,
        this.phone,
        this.createdAt,
        this.about,
        this.status});

  FollowupListParser.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    createdAt = json['created_at'];
    about = json['about'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['created_at'] = this.createdAt;
    data['about'] = this.about;
    data['status'] = this.status;
    return data;
  }
}
