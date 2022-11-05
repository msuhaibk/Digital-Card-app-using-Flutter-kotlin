class InvitesListParser {
  String id;
  String userId;
  String organizerId;
  String eventId;
  String title;
  String scheduedAt;
  String organizer;

  InvitesListParser(
      {this.id,
        this.userId,
        this.organizerId,
        this.eventId,
        this.title,
        this.scheduedAt,
        this.organizer});

  InvitesListParser.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    organizerId = json['organizer_id'];
    eventId = json['event_id'];
    title = json['title'];
    scheduedAt = json['schedued_at'];
    organizer = json['organizer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['organizer_id'] = this.organizerId;
    data['event_id'] = this.eventId;
    data['title'] = this.title;
    data['schedued_at'] = this.scheduedAt;
    data['organizer'] = this.organizer;
    return data;
  }
}
