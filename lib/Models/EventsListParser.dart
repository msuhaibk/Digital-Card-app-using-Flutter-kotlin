class EventsListParser {
  String id;
  String userId;
  String title;
  String description;
  String imagePath;
  String videoPath;
  String updatedAt;
  String organizer;
  String venue;
  String contact;
  String email;

  EventsListParser(
      {this.id,
        this.userId,
        this.title,
        this.description,
        this.imagePath,
        this.videoPath,
        this.updatedAt,
        this.organizer,
        this.venue,
        this.contact,
        this.email});

  EventsListParser.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    title = json['title'];
    description = json['description'];
    imagePath = json['ImagePath'];
    videoPath = json['VideoPath'];
    updatedAt = json['updated_at'];
    organizer = json['organizer'];
    venue = json['venue'];
    contact = json['contact'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['title'] = this.title;
    data['description'] = this.description;
    data['ImagePath'] = this.imagePath;
    data['VideoPath'] = this.videoPath;
    data['updated_at'] = this.updatedAt;
    data['organizer'] = this.organizer;
    data['venue'] = this.venue;
    data['contact'] = this.contact;
    data['email'] = this.email;
    return data;
  }
}
