class TransactionsParser {
  String id;
  String userId;
  String title;
  String amount;
  String plan;
  String method;
  String date;
  String status;

  TransactionsParser(
      {this.id,
        this.userId,
        this.title,
        this.amount,
        this.plan,
        this.method,
        this.date,
        this.status});

  TransactionsParser.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    title = json['title'];
    amount = json['amount'];
    plan = json['plan'];
    method = json['method'];
    date = json['date'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['title'] = this.title;
    data['amount'] = this.amount;
    data['plan'] = this.plan;
    data['method'] = this.method;
    data['date'] = this.date;
    data['status'] = this.status;
    return data;
  }
}