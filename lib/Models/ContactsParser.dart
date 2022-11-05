class ContactsParser {
  String id;
  String name;
  String email;
  String phone;
  String company;
  String tags;
  String notes;
  String category;
  String userId;
  String updated_at;
  String viewed;

  ContactsParser(
      {this.id,
      this.name,
      this.email,
      this.phone,
      this.company,
      this.tags,
      this.notes,
      this.category,
      this.userId,
      this.updated_at,
      this.viewed});

  ContactsParser.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    company = json['company'];
    tags = json['tags'];
    notes = json['notes'];
    category = json['category'];
    userId = json['user_id'];
    updated_at = json['updated_at'];
    viewed = json['viewed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['company'] = this.company;
    data['tags'] = this.tags;
    data['notes'] = this.notes;
    data['category'] = this.category;
    data['user_id'] = this.userId;
    data['updated_at'] = this.updated_at;
    data['viewed'] = this.viewed;
    return data;
  }
}
