class MemberShipParser {
  String id;
  String userId;
  String transId;
  String planId;
  String plan;
  String method;
  String startDate;
  String endDate;
  String status;
  String staffCount;

  MemberShipParser(
      {this.id,
      this.userId,
      this.transId,
      this.planId,
      this.plan,
      this.method,
      this.startDate,
      this.endDate,
      this.status,
      this.staffCount});

  MemberShipParser.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    transId = json['trans_id'];
    planId = json['plan_id'];
    plan = json['plan'];
    method = json['method'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    status = json['status'];
    staffCount = json['staff_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['trans_id'] = this.transId;
    data['plan_id'] = this.planId;
    data['plan'] = this.plan;
    data['method'] = this.method;
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    data['status'] = this.status;
    data['staff_count'] = this.staffCount;
    return data;
  }
}
