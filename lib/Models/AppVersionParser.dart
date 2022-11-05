class AppVersionParser {
  String androidVersion;
  String iosVersion;
  String playstore;
  String appstore;

  AppVersionParser(
      {this.androidVersion, this.iosVersion, this.playstore, this.appstore});

  AppVersionParser.fromJson(Map<String, dynamic> json) {
    androidVersion = json['android_version'];
    iosVersion = json['ios_version'];
    playstore = json['playstore'];
    appstore = json['appstore'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['android_version'] = this.androidVersion;
    data['ios_version'] = this.iosVersion;
    data['playstore'] = this.playstore;
    data['appstore'] = this.appstore;
    return data;
  }
}