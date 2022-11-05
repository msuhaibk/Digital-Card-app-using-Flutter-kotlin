class SharedCards {
  String id;
  String userId;
  String myId;
  String name;
  String email;
  String status;
  String created_at;

  SharedCards(
      {this.id,
      this.userId,
      this.myId,
      this.name,
      this.email,
      this.status,
      this.created_at});

  SharedCards.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    myId = json['my_id'];
    name = json['name'];
    email = json['email'];
    status = json['status'];
    created_at = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['my_id'] = this.myId;
    data['name'] = this.name;
    data['email'] = this.email;
    data['status'] = this.status;
    data['created_at'] = this.created_at;
    return data;
  }
}
