class AnalyticsParser {
  String id;
  String userId;
  String scanCount;
  String saveCount;
  String createdAt;

  AnalyticsParser(
      {this.id, this.userId, this.scanCount, this.saveCount, this.createdAt});

  AnalyticsParser.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    scanCount = json['scan_count'];
    saveCount = json['save_count'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['scan_count'] = this.scanCount;
    data['save_count'] = this.saveCount;
    data['created_at'] = this.createdAt;
    return data;
  }
}
