class SharedParser {
  String id;
  String tags;
  String notes;
  String category;
  String nameFQ;
  String emailFQ;
  String phoneFQ;
  String companyFQ;
  String userId;
  String updated_at;
  String viewed;

  SharedParser(
      {this.id,
      this.tags,
      this.notes,
      this.category,
      this.nameFQ,
      this.emailFQ,
      this.phoneFQ,
      this.companyFQ,
      this.userId,
      this.updated_at,
      this.viewed});

  SharedParser.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    tags = json['tags'];
    notes = json['notes'];
    category = json['category'];
    nameFQ = json['nameFQ'];
    emailFQ = json['emailFQ'];
    phoneFQ = json['phoneFQ'];
    companyFQ = json['companyFQ'];
    userId = json['user_id'];
    updated_at = json['updated_at'];
    viewed = json['viewed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['tags'] = this.tags;
    data['notes'] = this.notes;
    data['category'] = this.category;
    data['nameFQ'] = this.nameFQ;
    data['emailFQ'] = this.emailFQ;
    data['phoneFQ'] = this.phoneFQ;
    data['companyFQ'] = this.companyFQ;
    data['user_id'] = this.userId;
    data['updated_at'] = this.updated_at;
    data['viewed'] = this.viewed;
    return data;
  }
}
