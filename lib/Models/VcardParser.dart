class VcardParser {
  String id;
  String userId;
  String slug;
  String title;
  String subtitle;
  String company;
  String email;
  String website;
  String address;
  String addressLink;
  String phone;
  String phone2;
  String telephone;
  String material;
  String wtPhone;
  String bgcolor;
  String cardcolor;
  String fontcolor;
  String bannerImagePath;
  String logoImagePath;
  String profileImagePath;
  String description;
  String twitterLink;
  String facebookLink;
  String linkedinLink;
  String ytbLink;
  String pinLink;
  String themeSelected;
  String virtualbgPath;

  VcardParser(
      {this.id,
        this.userId,
        this.title,
        this.subtitle,
        this.company,
        this.email,
        this.website,
        this.address,
        this.addressLink,
        this.phone,
        this.phone2,
        this.telephone,
        this.material,
        this.wtPhone,
        this.bgcolor,
        this.cardcolor,
        this.fontcolor,
        this.bannerImagePath,
        this.logoImagePath,
        this.profileImagePath,
        this.description,
        this.twitterLink,
        this.facebookLink,
        this.linkedinLink,
        this.ytbLink,
        this.pinLink,
        this.themeSelected,
        this.virtualbgPath});

  VcardParser.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    slug = json['slug'];
    title = json['title'];
    subtitle = json['subtitle'];
    company = json['company'];
    email = json['email'];
    website = json['website'];
    address = json['address'];
    addressLink = json['address_link'];
    phone = json['phone'];
    phone2 = json['phone2'];
    telephone = json['telephone'];
    material = json['material'];
    wtPhone = json['wt_phone'];
    bgcolor = json['bgcolor'];
    cardcolor = json['cardcolor'];
    fontcolor = json['fontcolor'];
    bannerImagePath = json['bannerImagePath'];
    logoImagePath = json['logoImagePath'];
    profileImagePath = json['profileImagePath'];
    description = json['description'];
    twitterLink = json['twitter_link'];
    facebookLink = json['facebook_link'];
    linkedinLink = json['linkedin_link'];
    ytbLink = json['ytb_link'];
    pinLink = json['pin_link'];
    themeSelected = json['theme_selected'];
    virtualbgPath = json['virtualbgPath'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['slug'] = this.slug;
    data['title'] = this.title;
    data['subtitle'] = this.subtitle;
    data['company'] = this.company;
    data['email'] = this.email;
    data['website'] = this.website;
    data['address'] = this.address;
    data['address_link'] = this.addressLink;
    data['phone'] = this.phone;
    data['phone2'] = this.phone2;
    data['telephone'] = this.telephone;
    data['material'] = this.material;
    data['wt_phone'] = this.wtPhone;
    data['bgcolor'] = this.bgcolor;
    data['cardcolor'] = this.cardcolor;
    data['fontcolor'] = this.fontcolor;
    data['bannerImagePath'] = this.bannerImagePath;
    data['logoImagePath'] = this.logoImagePath;
    data['profileImagePath'] = this.profileImagePath;
    data['description'] = this.description;
    data['twitter_link'] = this.twitterLink;
    data['facebook_link'] = this.facebookLink;
    data['linkedin_link'] = this.linkedinLink;
    data['ytb_link'] = this.ytbLink;
    data['pin_link'] = this.pinLink;
    data['theme_selected'] = this.themeSelected;
    data['virtualbgPath'] = this.virtualbgPath;
    return data;
  }
}