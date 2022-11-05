import 'dart:convert';
import 'dart:io';
import 'package:fliqcard/Helpers/constants.dart';
import 'package:fliqcard/UI/Profile/ChangePassword.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path/path.dart';

class WebService {
  Future registerAccount(String fullname, String phone, String country,
      String email, String password) async {
    try {
      Map data = {
        "fullname": fullname,
        "phone": phone,
        "country": country,
        "email": email,
        "password": password
      };

      var body = json.encode(data);
      print(body);

      final response = await http.post(Uri.parse(register),
          headers: {
            "Content-Type": "application/json",
          },
          body: body);

      if (response.statusCode == 200) {
        return response;
      } else {
        return "error";
      }
    } catch (Exception) {
      print("exception" + Exception.toString());
    }
  }

  Future loginAccount(String email, String password) async {
    try {
      Map data = {"email": email, "password": password};

      var body = json.encode(data);
      print(body);

      final response = await http.post(Uri.parse(login),
          headers: {
            "Content-Type": "application/json",
          },
          body: body);

      if (response.statusCode == 200) {
        return response;
      } else {
        return "error";
      }
    } catch (Exception) {
      print("exception" + Exception.toString());
    }
  }

  Future getAppVersion() async {
    try {
      final response = await http.get(
        Uri.parse(appversion),
      );

      if (response.statusCode == 200) {
        return response;
      } else {
        return "error";
      }
    } catch (Exception) {
      print("exception" + Exception.toString());
    }
  }

  Future getData(String id) async {
    try {
      Map data = {"id": id, "source": Platform.isAndroid ? "android" : "ios"};

      var body = json.encode(data);
      print(body);

      final response = await http.post(Uri.parse(getdata),
          headers: {
            "Content-Type": "application/json",
          },
          body: body);

      if (response.statusCode == 200) {
        return response;
      } else {
        return "error";
      }
    } catch (Exception) {
      print("exception" + Exception.toString());
    }
  }

  Future UpdateContact(
      String id, String tags, String notes, String category) async {
    try {
      Map data = {"id": id, "tags": tags, "notes": notes, "category": category};

      var body = json.encode(data);
      print(body);

      final response = await http.post(Uri.parse(updateContact),
          headers: {
            "Content-Type": "application/json",
          },
          body: body);

      if (response.statusCode == 200) {
        return response;
      } else {
        return "error";
      }
    } catch (Exception) {
      print("exception" + Exception.toString());
    }
  }

  Future deleteContact(String id) async {
    try {
      Map data = {"id": id};

      var body = json.encode(data);
      print(body);

      final response = await http.post(Uri.parse(deletecontact),
          headers: {
            "Content-Type": "application/json",
          },
          body: body);

      if (response.statusCode == 200) {
        return response;
      } else {
        return "error";
      }
    } catch (Exception) {
      print("exception" + Exception.toString());
    }
  }

  Future updateStaff(String id, String parent_id, String fullname,
      String department, String phone, String email, String password) async {
    try {
      Map data = {
        "id": id,
        "fullname": fullname,
        "parent_id": parent_id,
        "department": department,
        "phone": phone,
        "email": email,
        "password": password
      };

      var body = json.encode(data);
      print(body);

      final response = await http.post(Uri.parse(updatestaff),
          headers: {
            "Content-Type": "application/json",
          },
          body: body);

      if (response.statusCode == 200) {
        return response;
      } else {
        return "error";
      }
    } catch (Exception) {
      print("exception" + Exception.toString());
    }
  }

  Future ChangePassword(String id, String password) async {
    try {
      Map data = {"id": id, "password": password};

      var body = json.encode(data);
      print(body);

      final response = await http.post(Uri.parse(changepassword),
          headers: {
            "Content-Type": "application/json",
          },
          body: body);

      if (response.statusCode == 200) {
        return response;
      } else {
        return "error";
      }
    } catch (Exception) {
      print("exception" + Exception.toString());
    }
  }

  Future DeletStaff(String id) async {
    try {
      Map data = {"id": id};

      var body = json.encode(data);
      print(body);

      final response = await http.post(Uri.parse(deletestaff),
          headers: {
            "Content-Type": "application/json",
          },
          body: body);

      if (response.statusCode == 200) {
        return response;
      } else {
        return "error";
      }
    } catch (Exception) {
      print("exception" + Exception.toString());
    }
  }

  Future updateVcard(
      String operation,
      String slug,
      String user_id,
      String title,
      String subtitle,
      String description,
      String email,
      String company,
      String wt_phone,
      String website,
      String address,
      String address_link,
      String twitter_link,
      String facebook_link,
      String linkedin_link,
      String ytb_link,
      String pin_link,
      String phone,
      String phone2,
      String telephone,
      String materialFilePath,
      String bgcolor,
      String cardcolor,
      String fontcolor,
      File bannerImage,
      File logoImage,
      File profileImage) async {
    try {
      var uri = Uri.parse(addeditcard);
      var request = new http.MultipartRequest("POST", uri);

      if (bannerImage != null) {
        var _bannerFront =
            new http.ByteStream(Stream.castFrom(bannerImage.openRead()));
        var _bannerLength = await bannerImage.length();

        var multipartBannerFront = new http.MultipartFile(
            "bannerImage", _bannerFront, _bannerLength,
            filename: basename(bannerImage.path));
        request.files.add(multipartBannerFront);
      }

      if (logoImage != null) {
        var _logoFront =
            new http.ByteStream(Stream.castFrom(logoImage.openRead()));
        var _logoLength = await logoImage.length();

        var multipartLogoFront = new http.MultipartFile(
            "logoImage", _logoFront, _logoLength,
            filename: basename(logoImage.path));
        request.files.add(multipartLogoFront);
      }

      if (profileImage != null) {
        var _profileFront =
            new http.ByteStream(Stream.castFrom(profileImage.openRead()));
        var _profileLength = await profileImage.length();

        var multipartProfileFront = new http.MultipartFile(
            "profileImage", _profileFront, _profileLength,
            filename: basename(profileImage.path));
        request.files.add(multipartProfileFront);
      }

      request.fields['operation'] = operation;
      request.fields['user_id'] = user_id;
      request.fields['slug'] = slug;
      request.fields['title'] = title;
      request.fields['subtitle'] = subtitle;
      request.fields['description'] = description;
      request.fields['email'] = email;
      request.fields['company'] = company;
      request.fields['wt_phone'] = wt_phone;
      request.fields['website'] = website;
      request.fields['address'] = address;
      request.fields['address_link'] = address_link;
      request.fields['twitter_link'] = twitter_link;
      request.fields['facebook_link'] = facebook_link;
      request.fields['linkedin_link'] = linkedin_link;
      request.fields['ytb_link'] = ytb_link;
      request.fields['pin_link'] = pin_link;
      request.fields['phone'] = phone;
      request.fields['phone2'] = phone2;
      request.fields['telephone'] = telephone;
      request.fields['materialFilePath'] = materialFilePath;
      request.fields['bgcolor'] = bgcolor;
      request.fields['cardcolor'] = cardcolor;
      request.fields['fontcolor'] = fontcolor;

      print(request.fields);
      var response = await request.send();
      print(response.stream.first);
      if (response.statusCode == 200) {
        return response;
      } else {
        return "error";
      }
    } catch (Exception) {
      print("exception" + Exception.toString());
    }
  }

  Future themeToogle(String user_id, String theme_number) async {
    try {
      Map data = {"user_id": user_id, "theme_number": theme_number};

      var body = json.encode(data);
      print(body);

      final response = await http.post(Uri.parse(theme_toggle),
          headers: {
            "Content-Type": "application/json",
          },
          body: body);

      if (response.statusCode == 200) {
        return response;
      } else {
        return "error";
      }
    } catch (Exception) {
      print("exception" + Exception.toString());
    }
  }

  Future UpdateLocation(String id, String lat, String lng) async {
    try {
      Map data = {"id": id, "lat": lat, "lng": lng};

      var body = json.encode(data);
      print(body);

      final response = await http.post(Uri.parse(updateLocation),
          headers: {
            "Content-Type": "application/json",
          },
          body: body);

      if (response.statusCode == 200) {
        return response;
      } else {
        return "error";
      }
    } catch (Exception) {
      print("exception" + Exception.toString());
    }
  }

  Future UpdateAttendance( id, email, fullname, lat,  lng, comment) async {
    try {
      Map data = {"id": id, "email": email, "fullname": fullname, "lat": lat, "lng": lng, "comment": comment};

      var body = json.encode(data);
      print(body);

      final response = await http.post(Uri.parse(updateattendance),
          headers: {
            "Content-Type": "application/json",
          },
          body: body);

      if (response.statusCode == 200) {
        return response;
      } else {
        return "error";
      }
    } catch (Exception) {
      print("exception" + Exception.toString());
    }
  }

  Future GetSharedCards(String id) async {
    try {
      Map data = {"id": id};

      var body = json.encode(data);
      print(body);

      final response = await http.post(Uri.parse(getsharedcards),
          headers: {
            "Content-Type": "application/json",
          },
          body: body);

      if (response.statusCode == 200) {
        return response;
      } else {
        return "error";
      }
    } catch (Exception) {
      print("exception" + Exception.toString());
    }
  }

  Future GetDistinctSharedCards(String id) async {
    try {
      Map data = {"id": id};

      var body = json.encode(data);
      print(body);

      final response = await http.post(Uri.parse(getdistinctcards),
          headers: {
            "Content-Type": "application/json",
          },
          body: body);

      if (response.statusCode == 200) {
        return response;
      } else {
        return "error";
      }
    } catch (Exception) {
      print("exception" + Exception.toString());
    }
  }

  Future UpdateStatus(int status, String user_id, String id) async {
    try {
      Map data = {"status": status.toString(), "user_id": user_id, "id": id};

      var body = json.encode(data);
      print(body);

      final response = await http.post(Uri.parse(acceptcard),
          headers: {
            "Content-Type": "application/json",
          },
          body: body);

      if (response.statusCode == 200) {
        return response;
      } else {
        return "error";
      }
    } catch (Exception) {
      print("exception" + Exception.toString());
    }
  }

  Future SendCard(String id, String name, String email, lat, lng) async {
    try {
      Map data = {
        "id": id,
        "name": name,
        "email": email,
        "lat": lat,
        "lng": lng
      };

      var body = json.encode(data);
      print(body);

      final response = await http.post(Uri.parse(sendcard),
          headers: {
            "Content-Type": "application/json",
          },
          body: body);

      if (response.statusCode == 200) {
        return response;
      } else {
        return "error";
      }
    } catch (Exception) {
      print("exception" + Exception.toString());
    }
  }

  Future ForgotPassword(String email) async {
    try {
      Map data = {"email": email};

      var body = json.encode(data);
      print(body);

      final response = await http.post(Uri.parse(forgot),
          headers: {
            "Content-Type": "application/json",
          },
          body: body);

      if (response.statusCode == 200) {
        return response;
      } else {
        return "error";
      }
    } catch (Exception) {
      print("exception" + Exception.toString());
    }
  }

  Future ActivatePlan(
      String id, String trans_id, String plan, String plan_id, method) async {
    try {
      Map data = {
        "id": id,
        "trans_id": trans_id,
        "plan": plan,
        "plan_id": plan_id,
        "method": method
      };

      var body = json.encode(data);
      print(body);

      final response = await http.post(Uri.parse(activateplan),
          headers: {
            "Content-Type": "application/json",
          },
          body: body);

      if (response.statusCode == 200) {
        return response;
      } else {
        return "error";
      }
    } catch (Exception) {
      print("exception" + Exception.toString());
    }
  }

  Future deleteBanner(String user_id) async {
    try {
      Map data = {"user_id": user_id};

      var body = json.encode(data);

      final response = await http.post(Uri.parse(deletebanner),
          headers: {
            "Content-Type": "application/json",
          },
          body: body);

      if (response.statusCode == 200) {
        return response;
      } else {
        return "error";
      }
    } catch (Exception) {
      print("exception" + Exception.toString());
    }
  }

  Future deleteLogo(String user_id) async {
    try {
      Map data = {"user_id": user_id};

      var body = json.encode(data);
      print(body);

      final response = await http.post(Uri.parse(deletelogo),
          headers: {
            "Content-Type": "application/json",
          },
          body: body);

      if (response.statusCode == 200) {
        return response;
      } else {
        return "error";
      }
    } catch (Exception) {
      print("exception" + Exception.toString());
    }
  }

  Future deleteProfile(String user_id) async {
    try {
      Map data = {"user_id": user_id};

      var body = json.encode(data);
      print(body);

      final response = await http.post(Uri.parse(deleteprofile),
          headers: {
            "Content-Type": "application/json",
          },
          body: body);

      if (response.statusCode == 200) {
        return response;
      } else {
        return "error";
      }
    } catch (Exception) {
      print("exception" + Exception.toString());
    }
  }

  Future SetBanner(String user_id, String serno) async {
    try {
      Map data = {"user_id": user_id, "serno": serno};

      var body = json.encode(data);
      print(body);

      final response = await http.post(Uri.parse(setBanner),
          headers: {
            "Content-Type": "application/json",
          },
          body: body);

      if (response.statusCode == 200) {
        return response;
      } else {
        return "error";
      }
    } catch (Exception) {
      print("exception" + Exception.toString());
    }
  }

  Future getFollowup(String id) async {
    try {
      Map data = {"id": id};

      var body = json.encode(data);

      final response = await http.post(Uri.parse(getfollowup),
          headers: {
            "Content-Type": "application/json",
          },
          body: body);

      if (response.statusCode == 200) {
        return response;
      } else {
        return "error";
      }
    } catch (Exception) {
      print("exception" + Exception.toString());
    }
  }

  Future getComments(String email) async {
    try {
      Map data = {"email": email};

      var body = json.encode(data);

      final response = await http.post(Uri.parse(getcomments),
          headers: {
            "Content-Type": "application/json",
          },
          body: body);

      if (response.statusCode == 200) {
        return response;
      } else {
        return "error";
      }
    } catch (Exception) {
      print("exception" + Exception.toString());
    }
  }

  Future CancelFollowup(id) async {
    try {
      Map data = {"id": id};

      var body = json.encode(data);

      final response = await http.post(Uri.parse(cancelFollowup),
          headers: {
            "Content-Type": "application/json",
          },
          body: body);

      if (response.statusCode == 200) {
        return response;
      } else {
        return "error";
      }
    } catch (Exception) {
      print("exception" + Exception.toString());
    }
  }

  Future CompleteFollowup(id) async {
    try {
      Map data = {"id": id};

      var body = json.encode(data);

      final response = await http.post(Uri.parse(completeFollowup),
          headers: {
            "Content-Type": "application/json",
          },
          body: body);

      if (response.statusCode == 200) {
        return response;
      } else {
        return "error";
      }
    } catch (Exception) {
      print("exception" + Exception.toString());
    }
  }

  Future RescheduleFollowup(id, user_id, created_at) async {
    try {
      Map data = {"id": id, "user_id": user_id, "created_at": created_at};

      var body = json.encode(data);

      final response = await http.post(Uri.parse(rescheduleFollowup),
          headers: {
            "Content-Type": "application/json",
          },
          body: body);

      if (response.statusCode == 200) {
        return response;
      } else {
        return "error";
      }
    } catch (Exception) {
      print("exception" + Exception.toString());
    }
  }

  Future AddFollowup(user_id, name, email, phone, created_at, about) async {
    try {
      Map data = {
        "user_id": user_id,
        "name": name,
        "email": email,
        "phone": phone,
        "created_at": created_at,
        "about": about
      };

      var body = json.encode(data);

      final response = await http.post(Uri.parse(addFollowup),
          headers: {
            "Content-Type": "application/json",
          },
          body: body);

      if (response.statusCode == 200) {
        return response;
      } else {
        return "error";
      }
    } catch (Exception) {
      print("exception" + Exception.toString());
    }
  }

  Future getEvents(id) async {
    try {
      Map data = {"id": id};

      var body = json.encode(data);

      final response = await http.post(Uri.parse(getevents),
          headers: {
            "Content-Type": "application/json",
          },
          body: body);

      if (response.statusCode == 200) {
        return response;
      } else {
        return "error";
      }
    } catch (Exception) {
      print("exception" + Exception.toString());
    }
  }

  Future DeleteEvent(id) async {
    try {
      Map data = {"id": id};

      var body = json.encode(data);

      final response = await http.post(Uri.parse(deleteEvent),
          headers: {
            "Content-Type": "application/json",
          },
          body: body);

      if (response.statusCode == 200) {
        return response;
      } else {
        return "error";
      }
    } catch (Exception) {
      print("exception" + Exception.toString());
    }
  }

  Future UpdateFcmToken(id, fcmtoken) async {
    try {
      Map data = {"id": id, "fcmtoken": fcmtoken};

      var body = json.encode(data);
      print(body);

      final response = await http.post(Uri.parse(updateFcmToken),
          headers: {
            "Content-Type": "application/json",
          },
          body: body);

      if (response.statusCode == 200) {
        return response;
      } else {
        return "error";
      }
    } catch (Exception) {
      print("exception" + Exception.toString());
    }
  }

  Future getInvites(id) async {
    try {
      Map data = {"id": id};

      var body = json.encode(data);

      final response = await http.post(Uri.parse(events_invites),
          headers: {
            "Content-Type": "application/json",
          },
          body: body);

      if (response.statusCode == 200) {
        return response;
      } else {
        return "error";
      }
    } catch (Exception) {
      print("exception" + Exception.toString());
    }
  }
}
