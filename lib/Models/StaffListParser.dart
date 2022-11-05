class StaffListParser {
  String id;
  String fullname;
  String email;
  String password;
  String createdAt;
  String updatedAt;
  String isStaff;
  String parentId;
  String department;
  String phone;

  StaffListParser(
      {this.id,
      this.fullname,
      this.email,
      this.password,
      this.createdAt,
      this.updatedAt,
      this.isStaff,
      this.parentId,
      this.department,
      this.phone});

  StaffListParser.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullname = json['fullname'];
    email = json['email'];
    password = json['password'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    isStaff = json['is_staff'];
    parentId = json['parent_id'];
    department = json['department'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['fullname'] = this.fullname;
    data['email'] = this.email;
    data['password'] = this.password;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['is_staff'] = this.isStaff;
    data['parent_id'] = this.parentId;
    data['department'] = this.department;
    data['phone'] = this.phone;
    return data;
  }
}
