import 'dart:convert';
import 'dart:io';
import 'package:fliqcard/Helpers/constants.dart';
import 'package:fliqcard/Models/AnalyticsParser.dart';
import 'package:fliqcard/Models/CommentsListParser.dart';
import 'package:fliqcard/Models/ContactsParser.dart';
import 'package:fliqcard/Models/EventsListParser.dart';
import 'package:fliqcard/Models/FollowupListParser.dart';
import 'package:fliqcard/Models/InvitesListParser.dart';
import 'package:fliqcard/Models/SharedParser.dart';
import 'package:fliqcard/Models/MemberShipParser.dart';
import 'package:fliqcard/Models/SharedCards.dart';
import 'package:fliqcard/Models/StaffListParser.dart';
import 'package:fliqcard/Models/TransactionsParser.dart';
import 'package:fliqcard/Models/UserDataParser.dart';
import 'package:fliqcard/Models/VcardParser.dart';
import 'package:fliqcard/Models/AppVersionParser.dart';
import 'package:fliqcard/UI/Dashboard/bar_chart_model.dart';
import 'package:fliqcard/services/web_service.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:charts_flutter/flutter.dart' as charts;

class CustomViewModel extends ChangeNotifier {
  var bottomIndex = 0;

  var hide = "no";
  List<String> slug_list = [];

  AppVersionParser appVersionParser;
  UserDataParser userData;
  List<ContactsParser> contactsList = [];
  List<ContactsParser> FilterContactsList = [];

  var contactsNEW_COUNT = 0;
  var contactsALL_COUNT = 0;
  var contactsCLIENT_COUNT = 0;
  var contactsFAMILY_COUNT = 0;
  var contactsFRIEND_COUNT = 0;
  var contactsBUSINESS_COUNT = 0;
  var contactsVENDOR_COUNT = 0;
  var contactsOTHER_COUNT = 0;

  var sharedNEW_COUNT = 0;
  var sharedALL_COUNT = 0;
  var sharedCLIENT_COUNT = 0;
  var sharedFAMILY_COUNT = 0;
  var sharedFRIEND_COUNT = 0;
  var sharedBUSINESS_COUNT = 0;
  var sharedVENDOR_COUNT = 0;
  var sharedOTHER_COUNT = 0;

  List<SharedParser> sharedList = [];
  List<SharedParser> FilterSharedList = [];
  List<String> scan_array = [];
  List<String> save_array = [];
  List<String> scan_array_months = [];
  List<String> monthsList = [
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December"
  ];
  List<String> ListOfScan = [];
  List<String> ListOfScanZero = [
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0",
    "0"
  ];
  List<BarChartModel> dataList = [];

  List<TransactionsParser> transactionsList = [];

  List<StaffListParser> staffList = [];

  List<StaffListParser> teamList = [];

  List<AnalyticsParser> analyticsList = [];
  List<String> MonthsList = [];
  List<int> ScanCountsList = [];
  List<SharedCards> tempsharedcardsList = [];
  List<SharedCards> sharedcardsList = [];

  int TotalVisits = 0;
  int TotalSaved = 0;

  MemberShipParser memberShip;
  VcardParser vcardData;
  VcardParser staffsFliqcard;
  List<FollowupListParser> followupList = [];
  List<FollowupListParser> todaysfollowupList = [];
  List<CommentsListParser> commentsList = [];

  List<EventsListParser> eventsList = [];
  List<InvitesListParser> invitesList = [];

  Future setBottomIndex(int index) async {
    bottomIndex = index;
    notifyListeners();
  }

  Future registerAccount(String fullname, String phone, String country,
      String email, String password) async {
    final response = await WebService()
        .registerAccount(fullname, phone, country, email, password);

    if (response != "error") {
      var responseDecoded = jsonDecode(utf8.decode(response.bodyBytes));
      var responseDecodedStatus = responseDecoded['status'];
      var responseDecodedData = responseDecoded['data'].toString();

      if (responseDecodedStatus == "false") {
        notifyListeners();
        return responseDecodedData;
      } else if (responseDecodedStatus == "true") {
        notifyListeners();
        return "success";
      } else {
        notifyListeners();
        return "error";
      }
    } else {
      print("***error");
      notifyListeners();
      return "error";
    }
  }

  Future loginAccount(String email, String password) async {
    this.userData = null;
    final response = await WebService().loginAccount(email, password);
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (response != "error") {
      var responseDecoded = jsonDecode(utf8.decode(response.bodyBytes));
      var responseDecodedStatus = responseDecoded['status'];
      var responseDecodedData = responseDecoded['data'].toString();

      if (responseDecodedStatus == "false") {
        notifyListeners();
        return responseDecodedData;
      } else if (responseDecodedStatus == "true") {
        prefs.setString("id", responseDecoded['data'][0]['id'].toString());
        final data = responseDecoded['data'][0];
        this.userData = UserDataParser.fromJson(data);

        notifyListeners();
        return "success";
      } else {
        notifyListeners();
        return "error";
      }
    } else {
      print("***error");
      notifyListeners();
      return "error";
    }
  }

  Future getAppVersion() async {
    this.appVersionParser = null;

    final response = await WebService().getAppVersion();

    if (response != "error") {
      var responseDecoded = jsonDecode(utf8.decode(response.bodyBytes));

      if (responseDecoded != null) {
        this.appVersionParser = AppVersionParser.fromJson(responseDecoded);
        notifyListeners();
        return "success";
      } else {
        notifyListeners();
        return "error";
      }
    } else {
      notifyListeners();
      return "error";
    }
  }

  Future getappVersionParser() async {
    return appVersionParser;
  }

  Future getvData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var myvcardData;
    var userData;

    final response = await WebService().getData(prefs.getString('id'));

    if (response != "error") {
      var responseDecoded = jsonDecode(utf8.decode(response.bodyBytes));
      var responseDecodedStatus = responseDecoded['status'];
      var responseDecodedData = responseDecoded['data'].toString();

      if (responseDecodedStatus == "false") {
        notifyListeners();
        return responseDecodedData;
      } else if (responseDecodedStatus == "true") {
        final data = responseDecoded['data'][0];
        userData = UserDataParser.fromJson(data);

        if (responseDecoded['data'][0]['vcard'] != null) {
          final vcard = responseDecoded['data'][0]['vcard'][0];
          if (vcard != null) {
            myvcardData = vcard;
          }
        }
      }
    }

    return myvcardData;
  }

  Future getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    this.userData = null;
    this.memberShip = null;
    this.vcardData = null;
    this.contactsList.clear();
    this.sharedList.clear();
    this.transactionsList.clear();
    this.staffList.clear();
    this.teamList.clear();
    this.TotalVisits = 0;
    this.TotalSaved = 0;
    this.scan_array.clear();
    this.save_array.clear();
    this.scan_array_months.clear();
    this.ListOfScan.clear();
    this.dataList.clear();
    this.slug_list.clear();

    final response = await WebService().getData(prefs.getString('id'));

    if (response != "error") {
      var responseDecoded = jsonDecode(utf8.decode(response.bodyBytes));
      var responseDecodedStatus = responseDecoded['status'];
      var responseDecodedData = responseDecoded['data'].toString();

      if (responseDecodedStatus == "false") {
        notifyListeners();
        return responseDecodedData;
      } else if (responseDecodedStatus == "true") {
        final data = responseDecoded['data'][0];
        this.userData = UserDataParser.fromJson(data);

        if (responseDecoded['data'][0]['hide'] != null) {
          final hide = responseDecoded['data'][0]['hide'];
          if (hide != null) {
            this.hide = hide;
          }
        }

        if (responseDecoded['data'][0]['membership'] != null) {
          final member = responseDecoded['data'][0]['membership'][0];
          if (member != null) {
            this.memberShip = MemberShipParser.fromJson(member);
          }
        }

        final contacts = responseDecoded['data'][0]['contacts'];

        if (contacts != null) {
          for (Map i in contacts) {
            contactsList.add(ContactsParser.fromJson(i));
          }
        }

        final shared = responseDecoded['data'][0]['shared'];

        if (shared != null) {
          for (Map i in shared) {
            sharedList.add(SharedParser.fromJson(i));
          }
        }

        final transactions = responseDecoded['data'][0]['transactions'];

        if (transactions != null) {
          for (Map i in transactions) {
            transactionsList.add(TransactionsParser.fromJson(i));
          }
        }

        if (responseDecoded['data'][0]['vcard'] != null) {
          final vcard = responseDecoded['data'][0]['vcard'][0];
          if (vcard != null) {
            this.vcardData = VcardParser.fromJson(vcard);
          }
        }

        if (responseDecoded['data'][0]['vcard_slug'] != null) {
          final vcard_slug = responseDecoded['data'][0]['vcard_slug'];
          if (vcard_slug != null) {
            for (Map i in vcard_slug) {
              this.slug_list.add(VcardParser.fromJson(i).slug ?? "");
            }
          }
        }

        final staff = responseDecoded['data'][0]['staff'];

        if (staff != null) {
          for (Map i in staff) {
            staffList.add(StaffListParser.fromJson(i));
          }
        }

        final team = responseDecoded['data'][0]['myteam'];

        if (team != null) {
          for (Map i in team) {
            teamList.add(StaffListParser.fromJson(i));
          }
        }

        if (responseDecoded['data'][0]['scan_array'].toString().length > 0) {
          scan_array =
              responseDecoded['data'][0]['scan_array'].toString().split(",");
          if (scan_array.length > 0) {
            for (int j = 0; j < scan_array.length; j++) {
              TotalVisits = TotalVisits + int.parse(scan_array[j] ?? "0");

              // scan_array[j] = (int.parse(scan_array[j] ?? "0") / 50).toString();
            }
          }

          scan_array_months = responseDecoded['data'][0]['scan_array_months']
              .toString()
              .split(",");

          for (int j = 0; j < scan_array_months.length; j++) {
            dataList.add(
              BarChartModel(
                year: scan_array_months[j].substring(0, 3),
                financial: int.parse(scan_array[j] ?? "0"),
                color: charts.ColorUtil.fromDartColor(Color(COLOR_SECONDARY)),
              ),
            );
          }

          /* for (int j = 0; j < monthsList.length; j++) {
            if (scan_array_months.contains(monthsList[j])) {
              int idx = scan_array_months.indexOf(monthsList[j]);
              ListOfScan.add(scan_array[idx]);
              print("AAAAAAAAAA" + scan_array[idx]);
              if (j > 6) {
                dataList.add(
                  BarChartModel(
                    year: monthsList[j],
                    financial: int.parse(scan_array[idx] ?? "0"),
                    color:
                        charts.ColorUtil.fromDartColor(Color(COLOR_SECONDARY)),
                  ),
                );
              }
            } else {
              ListOfScan.add("0");
              if (j > 6) {
                dataList.add(
                  BarChartModel(
                    year: monthsList[j],
                    financial: 0,
                    color:
                        charts.ColorUtil.fromDartColor(Color(COLOR_SECONDARY)),
                  ),
                );
              }
            }
          }*/

        }
        if (responseDecoded['data'][0]['save_array'].toString().length > 0) {
          save_array =
              responseDecoded['data'][0]['save_array'].toString().split(",");
          if (save_array.length > 0) {
            for (int j = 0; j < save_array.length; j++) {
              TotalSaved = TotalSaved + int.parse(save_array[j] ?? "0");
            }
          }
        }

        notifyListeners();
        return "success";
      } else {
        notifyListeners();
        return "error";
      }
    } else {
      print("***error");
      notifyListeners();
      return "error";
    }
  }

  Future getAllContacts() async {
    this.FilterContactsList.clear();
    for (int i = 0; i < contactsList.length; i++) {
      FilterContactsList.add(contactsList[i]);
    }
    notifyListeners();
    return "success";
  }

  Future getFilterContacts(String category_name, String searchString) async {
    this.FilterContactsList.clear();

    for (int i = 0; i < contactsList.length; i++) {
      if (category_name == "All") {
        if ((contactsList[i].category ?? "")
                .toLowerCase()
                .contains(searchString) ||
            (contactsList[i].name ?? "").toLowerCase().contains(searchString) ||
            (contactsList[i].company ?? "")
                .toLowerCase()
                .contains(searchString) ||
            (contactsList[i].phone ?? "")
                .toLowerCase()
                .contains(searchString) ||
            (contactsList[i].email ?? "")
                .toLowerCase()
                .contains(searchString) ||
            (contactsList[i].tags ?? "").toLowerCase().contains(searchString) ||
            (contactsList[i].notes ?? "")
                .toLowerCase()
                .contains(searchString)) {
          FilterContactsList.add(contactsList[i]);
        }
      } else {
        if (contactsList[i].category == category_name &&
            ((contactsList[i].category ?? "")
                    .toLowerCase()
                    .contains(searchString) ||
                (contactsList[i].name ?? "")
                    .toLowerCase()
                    .contains(searchString) ||
                (contactsList[i].company ?? "")
                    .toLowerCase()
                    .contains(searchString) ||
                (contactsList[i].phone ?? "")
                    .toLowerCase()
                    .contains(searchString) ||
                (contactsList[i].email ?? "")
                    .toLowerCase()
                    .contains(searchString) ||
                (contactsList[i].tags ?? "")
                    .toLowerCase()
                    .contains(searchString) ||
                (contactsList[i].notes ?? "")
                    .toLowerCase()
                    .contains(searchString))) {
          FilterContactsList.add(contactsList[i]);
        }
      }
    }

    notifyListeners();
    return "success";
  }

  Future getAllShared() async {
    this.FilterSharedList.clear();
    for (int i = 0; i < sharedList.length; i++) {
      FilterSharedList.add(sharedList[i]);
    }
    notifyListeners();
    return "success";
  }

  Future getFilterShared(String category_name, String searchString) async {
    this.FilterSharedList.clear();

    for (int i = 0; i < sharedList.length; i++) {
      if (category_name == "All") {
        if ((sharedList[i].category ?? "")
                .toLowerCase()
                .contains(searchString) ||
            (sharedList[i].nameFQ ?? "").toLowerCase().contains(searchString) ||
            (sharedList[i].companyFQ ?? "")
                .toLowerCase()
                .contains(searchString) ||
            (sharedList[i].phoneFQ ?? "")
                .toLowerCase()
                .contains(searchString) ||
            (sharedList[i].emailFQ ?? "")
                .toLowerCase()
                .contains(searchString) ||
            (sharedList[i].tags ?? "").toLowerCase().contains(searchString) ||
            (sharedList[i].notes ?? "").toLowerCase().contains(searchString)) {
          FilterSharedList.add(sharedList[i]);
        }
      } else {
        if (sharedList[i].category == category_name &&
            ((sharedList[i].category ?? "")
                    .toLowerCase()
                    .contains(searchString) ||
                (sharedList[i].nameFQ ?? "")
                    .toLowerCase()
                    .contains(searchString) ||
                (sharedList[i].companyFQ ?? "")
                    .toLowerCase()
                    .contains(searchString) ||
                (sharedList[i].phoneFQ ?? "")
                    .toLowerCase()
                    .contains(searchString) ||
                (sharedList[i].emailFQ ?? "")
                    .toLowerCase()
                    .contains(searchString) ||
                (sharedList[i].tags ?? "")
                    .toLowerCase()
                    .contains(searchString) ||
                (sharedList[i].notes ?? "")
                    .toLowerCase()
                    .contains(searchString))) {
          FilterSharedList.add(sharedList[i]);
        }
      }
    }

    notifyListeners();
    return "success";
  }

  Future UpdateContact(
      int index, String id, String tags, String notes, String category) async {
    final response =
        await WebService().UpdateContact(id, tags, notes, category);

    if (response != "error") {
      var responseDecoded = jsonDecode(utf8.decode(response.bodyBytes));
      var responseDecodedStatus = responseDecoded['status'];
      var responseDecodedData = responseDecoded['data'].toString();

      if (responseDecodedStatus == "false") {
        notifyListeners();
        return responseDecodedData;
      } else if (responseDecodedStatus == "true") {
        notifyListeners();
        return responseDecodedData;
      } else {
        notifyListeners();
        return "error";
      }
    } else {
      print("***error");
      notifyListeners();
      return "error";
    }
  }

  Future deleteContact(String id) async {
    final response = await WebService().deleteContact(id);

    if (response != "error") {
      var responseDecoded = jsonDecode(utf8.decode(response.bodyBytes));
      var responseDecodedStatus = responseDecoded['status'];
      var responseDecodedData = responseDecoded['data'].toString();

      if (responseDecodedStatus == "false") {
        notifyListeners();
        return responseDecodedData;
      } else if (responseDecodedStatus == "true") {
        notifyListeners();
        return responseDecodedData;
      } else {
        notifyListeners();
        return "error";
      }
    } else {
      print("***error");
      notifyListeners();
      return "error";
    }
  }

  Future updateStaff(String id, String fullname, String department,
      String phone, String email, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final response = await WebService().updateStaff(id, prefs.getString('id'),
        fullname, department, phone, email, password);

    if (response != "error") {
      var responseDecoded = jsonDecode(utf8.decode(response.bodyBytes));
      var responseDecodedStatus = responseDecoded['status'];
      var responseDecodedData = responseDecoded['data'].toString();

      if (responseDecodedStatus == "false") {
        notifyListeners();
        return responseDecodedData;
      } else if (responseDecodedStatus == "true") {
        notifyListeners();
        getLatestStaffs();
        return "success";
      } else {
        notifyListeners();
        return "error";
      }
    } else {
      print("***error");
      notifyListeners();
      return "error";
    }
  }

  Future ChangePassword(String id, String password) async {
    final response = await WebService().ChangePassword(id, password);

    if (response != "error") {
      var responseDecoded = jsonDecode(utf8.decode(response.bodyBytes));
      var responseDecodedStatus = responseDecoded['status'];
      var responseDecodedData = responseDecoded['data'].toString();

      if (responseDecodedStatus == "false") {
        notifyListeners();
        return responseDecodedData;
      } else if (responseDecodedStatus == "true") {
        notifyListeners();
        return responseDecodedData;
      } else {
        notifyListeners();
        return "error";
      }
    } else {
      print("***error");
      notifyListeners();
      return "error";
    }
  }

  Future getLatestStaffs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    this.staffList.clear();

    final response = await WebService().getData(prefs.getString('id'));

    if (response != "error") {
      var responseDecoded = jsonDecode(utf8.decode(response.bodyBytes));
      var responseDecodedStatus = responseDecoded['status'];
      var responseDecodedData = responseDecoded['data'].toString();

      if (responseDecodedStatus == "false") {
        notifyListeners();
        return responseDecodedData;
      } else if (responseDecodedStatus == "true") {
        final staff = responseDecoded['data'][0]['staff'];

        if (staff != null) {
          for (Map i in staff) {
            staffList.add(StaffListParser.fromJson(i));
          }
        }

        notifyListeners();
        return "success";
      } else {
        notifyListeners();
        return "error";
      }
    } else {
      print("***error");
      notifyListeners();
      return "error";
    }
  }

  Future DeletStaff(String id) async {
    final response = await WebService().DeletStaff(id);

    if (response != "error") {
      var responseDecoded = jsonDecode(utf8.decode(response.bodyBytes));
      var responseDecodedStatus = responseDecoded['status'];
      var responseDecodedData = responseDecoded['data'].toString();

      if (responseDecodedStatus == "false") {
        notifyListeners();
        return responseDecodedData;
      } else if (responseDecodedStatus == "true") {
        getLatestStaffs();
        notifyListeners();
        return responseDecodedData;
      } else {
        notifyListeners();
        return "error";
      }
    } else {
      print("***error");
      notifyListeners();
      return "error";
    }
  }

  Future updateVcard(
      String operation,
      String slug,
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
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final response = await WebService().updateVcard(
        operation,
        slug,
        prefs.getString('id'),
        title,
        subtitle,
        description,
        email,
        company,
        wt_phone,
        website,
        address,
        address_link,
        twitter_link,
        facebook_link,
        linkedin_link,
        ytb_link,
        pin_link,
        phone,
        phone2,
        telephone,
        materialFilePath,
        bgcolor,
        cardcolor,
        fontcolor,
        bannerImage,
        logoImage,
        profileImage);

    if (response != "error") {
      notifyListeners();
      return "Card Saved";
    } else {
      print("***error");
      notifyListeners();
      return "error";
    }
  }

  Future themeToogle(String theme_number) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final response =
        await WebService().themeToogle(prefs.getString('id'), theme_number);

    if (response != "error") {
      var responseDecoded = jsonDecode(utf8.decode(response.bodyBytes));
      var responseDecodedStatus = responseDecoded['status'];
      var responseDecodedData = responseDecoded['data'].toString();

      if (responseDecodedStatus == "false") {
        notifyListeners();
        return responseDecodedData;
      } else if (responseDecodedStatus == "true") {
        notifyListeners();
        return responseDecodedData;
      } else {
        notifyListeners();
        return "error";
      }
    } else {
      print("***error");
      notifyListeners();
      return "error";
    }
  }

  Future UpdateLocation(String lat, String lng) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final response =
        await WebService().UpdateLocation(prefs.getString('id'), lat, lng);

    if (response != "error") {
      var responseDecoded = jsonDecode(utf8.decode(response.bodyBytes));
      var responseDecodedStatus = responseDecoded['status'];
      var responseDecodedData = responseDecoded['data'].toString();

      if (responseDecodedStatus == "false") {
        notifyListeners();
        return responseDecodedData;
      } else if (responseDecodedStatus == "true") {
        notifyListeners();
        return responseDecodedData;
      } else {
        notifyListeners();
        return "error";
      }
    } else {
      print("***error");
      notifyListeners();
      return "error";
    }
  }

  Future UpdateAttendance(String lat, String lng, comment) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final response = await WebService().UpdateAttendance(prefs.getString('id'),
        userData.email, userData.fullname, lat, lng, comment);

    if (response != "error") {
      var responseDecoded = jsonDecode(utf8.decode(response.bodyBytes));
      var responseDecodedStatus = responseDecoded['status'];
      var responseDecodedData = responseDecoded['data'].toString();

      if (responseDecodedStatus == "false") {
        notifyListeners();
        return responseDecodedData;
      } else if (responseDecodedStatus == "true") {
        notifyListeners();
        return responseDecodedData;
      } else {
        notifyListeners();
        return "error";
      }
    } else {
      print("***error");
      notifyListeners();
      return "error";
    }
  }

  Future GetSharedCards() async {
    this.tempsharedcardsList.clear();
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final response = await WebService().GetSharedCards(prefs.getString('id'));

    if (response != "error") {
      var responseDecoded = jsonDecode(utf8.decode(response.bodyBytes));
      var responseDecodedStatus = responseDecoded['status'];
      var responseDecodedData = responseDecoded['data'].toString();

      if (responseDecodedStatus == "false") {
        notifyListeners();
        return responseDecodedData;
      } else if (responseDecodedStatus == "true") {
        final cards = responseDecoded['data'];

        if (cards != null) {
          for (Map i in cards) {
            if (SharedCards.fromJson(i).status == "0") {
              tempsharedcardsList.add(SharedCards.fromJson(i));
            }
          }
        }

        notifyListeners();
        return responseDecodedData;
      } else {
        notifyListeners();
        return "error";
      }
    } else {
      print("***error");
      notifyListeners();
      return "error";
    }
  }

  Future GetDistinctSharedCards() async {
    this.sharedcardsList.clear();
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final response =
        await WebService().GetDistinctSharedCards(prefs.getString('id'));

    if (response != "error") {
      var responseDecoded = jsonDecode(utf8.decode(response.bodyBytes));
      var responseDecodedStatus = responseDecoded['status'];
      var responseDecodedData = responseDecoded['data'].toString();

      if (responseDecodedStatus == "false") {
        notifyListeners();
        return responseDecodedData;
      } else if (responseDecodedStatus == "true") {
        final cards = responseDecoded['data'];

        if (cards != null) {
          for (Map i in cards) {
            sharedcardsList.add(SharedCards.fromJson(i));
          }
        }

        notifyListeners();
        return responseDecodedData;
      } else {
        notifyListeners();
        return "error";
      }
    } else {
      print("***error");
      notifyListeners();
      return "error";
    }
  }

  Future UpdateStatus(int status, String user_id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final response =
        await WebService().UpdateStatus(status, prefs.getString('id'), user_id);

    if (response != "error") {
      var responseDecoded = jsonDecode(utf8.decode(response.bodyBytes));
      var responseDecodedStatus = responseDecoded['status'];
      var responseDecodedData = responseDecoded['data'].toString();

      if (responseDecodedStatus == "false") {
        notifyListeners();
        return responseDecodedData;
      } else if (responseDecodedStatus == "true") {
        notifyListeners();
        return responseDecodedData;
      } else {
        notifyListeners();
        return "error";
      }
    } else {
      print("***error");
      notifyListeners();
      return "error";
    }
  }

  Future SendCard(String lat, String lng) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final response = await WebService().SendCard(
        prefs.getString('id'), vcardData.title, userData.email, lat, lng);

    if (response != "error") {
      var responseDecoded = jsonDecode(utf8.decode(response.bodyBytes));
      var responseDecodedStatus = responseDecoded['status'];
      var responseDecodedData = responseDecoded['data'].toString();

      if (responseDecodedStatus == "false") {
        notifyListeners();
        return responseDecodedData;
      } else if (responseDecodedStatus == "true") {
        notifyListeners();
        return "success";
      } else {
        notifyListeners();
        return "error";
      }
    } else {
      print("***error");
      notifyListeners();
      return "error";
    }
  }

  Future ForgotPassword(String email) async {
    final response = await WebService().ForgotPassword(email);

    if (response != "error") {
      var responseDecoded = jsonDecode(utf8.decode(response.bodyBytes));
      var responseDecodedStatus = responseDecoded['status'];
      var responseDecodedData = responseDecoded['data'].toString();

      if (responseDecodedStatus == "false") {
        notifyListeners();
        return responseDecodedData;
      } else if (responseDecodedStatus == "true") {
        notifyListeners();
        return responseDecodedData;
      } else {
        notifyListeners();
        return "error";
      }
    } else {
      print("***error");
      notifyListeners();
      return "error";
    }
  }

  Future ActivatePlan(
      String trans_id, String plan, String plan_id, method) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final response = await WebService()
        .ActivatePlan(prefs.getString('id'), trans_id, plan, plan_id, method);

    if (response != "error") {
      var responseDecoded = jsonDecode(utf8.decode(response.bodyBytes));
      var responseDecodedStatus = responseDecoded['status'];
      var responseDecodedData = responseDecoded['data'].toString();

      if (responseDecodedStatus == "false") {
        notifyListeners();
        return responseDecodedData;
      } else if (responseDecodedStatus == "true") {
        notifyListeners();
        return responseDecodedData;
      } else {
        notifyListeners();
        return "error";
      }
    } else {
      print("***error");
      notifyListeners();
      return "error";
    }
  }

  Future deleteBanner() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final response = await WebService().deleteBanner(prefs.getString('id'));

    if (response != "error") {
      var responseDecoded = jsonDecode(utf8.decode(response.bodyBytes));
      var responseDecodedStatus = responseDecoded['status'];
      var responseDecodedData = responseDecoded['data'].toString();

      if (responseDecodedStatus == "false") {
        notifyListeners();
        return responseDecodedData;
      } else if (responseDecodedStatus == "true") {
        notifyListeners();
        return responseDecodedData;
      } else {
        notifyListeners();
        return "error";
      }
    } else {
      print("***error");
      notifyListeners();
      return "error";
    }
  }

  Future deleteLogo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final response = await WebService().deleteLogo(prefs.getString('id'));

    if (response != "error") {
      var responseDecoded = jsonDecode(utf8.decode(response.bodyBytes));
      var responseDecodedStatus = responseDecoded['status'];
      var responseDecodedData = responseDecoded['data'].toString();

      if (responseDecodedStatus == "false") {
        notifyListeners();
        return responseDecodedData;
      } else if (responseDecodedStatus == "true") {
        notifyListeners();
        return responseDecodedData;
      } else {
        notifyListeners();
        return "error";
      }
    } else {
      print("***error");
      notifyListeners();
      return "error";
    }
  }

  Future deleteProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final response = await WebService().deleteProfile(prefs.getString('id'));

    if (response != "error") {
      var responseDecoded = jsonDecode(utf8.decode(response.bodyBytes));
      var responseDecodedStatus = responseDecoded['status'];
      var responseDecodedData = responseDecoded['data'].toString();

      if (responseDecodedStatus == "false") {
        notifyListeners();
        return responseDecodedData;
      } else if (responseDecodedStatus == "true") {
        notifyListeners();
        return responseDecodedData;
      } else {
        notifyListeners();
        return "error";
      }
    } else {
      print("***error");
      notifyListeners();
      return "error";
    }
  }

  Future getStaffsFliqcard(id) async {
    this.staffsFliqcard = null;

    final response = await WebService().getData(id);

    if (response != "error") {
      var responseDecoded = jsonDecode(utf8.decode(response.bodyBytes));
      var responseDecodedStatus = responseDecoded['status'];
      var responseDecodedData = responseDecoded['data'].toString();

      if (responseDecodedStatus == "false") {
        notifyListeners();
        return "error";
      } else if (responseDecodedStatus == "true") {
        if (responseDecoded['data'][0]['vcard'] != null) {
          final vcard = responseDecoded['data'][0]['vcard'][0];
          if (vcard != null) {
            this.staffsFliqcard = VcardParser.fromJson(vcard);
          }
        }
        notifyListeners();
        return "success";
      } else {
        notifyListeners();
        return "error";
      }
    } else {
      print("***error");
      notifyListeners();
      return "error";
    }
  }

  Future getLatestContacts() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    this.contactsList.clear();
    this.sharedList.clear();
    contactsNEW_COUNT = 0;
    contactsALL_COUNT = 0;
    contactsCLIENT_COUNT = 0;
    contactsFAMILY_COUNT = 0;
    contactsFRIEND_COUNT = 0;
    contactsBUSINESS_COUNT = 0;
    contactsVENDOR_COUNT = 0;
    contactsOTHER_COUNT = 0;

    sharedNEW_COUNT = 0;
    sharedALL_COUNT = 0;
    sharedCLIENT_COUNT = 0;
    sharedFAMILY_COUNT = 0;
    sharedFRIEND_COUNT = 0;
    sharedBUSINESS_COUNT = 0;
    sharedVENDOR_COUNT = 0;
    sharedOTHER_COUNT = 0;

    final response = await WebService().getData(prefs.getString('id'));

    if (response != "error") {
      var responseDecoded = jsonDecode(utf8.decode(response.bodyBytes));
      var responseDecodedStatus = responseDecoded['status'];
      var responseDecodedData = responseDecoded['data'].toString();

      if (responseDecodedStatus == "false") {
        notifyListeners();
        return responseDecodedData;
      } else if (responseDecodedStatus == "true") {
        final contacts = responseDecoded['data'][0]['contacts'];

        if (contacts != null) {
          for (Map i in contacts) {
            contactsList.add(ContactsParser.fromJson(i));
            contactsALL_COUNT = contactsALL_COUNT + 1;
            if (ContactsParser.fromJson(i).category != null) {
              if (ContactsParser.fromJson(i).category == "New") {
                contactsNEW_COUNT = contactsNEW_COUNT + 1;
              } else if (ContactsParser.fromJson(i).category == "Client") {
                contactsCLIENT_COUNT = contactsCLIENT_COUNT + 1;
              } else if (ContactsParser.fromJson(i).category == "Family") {
                contactsFAMILY_COUNT = contactsFAMILY_COUNT + 1;
              } else if (ContactsParser.fromJson(i).category == "Friend") {
                contactsFRIEND_COUNT = contactsFRIEND_COUNT + 1;
              } else if (ContactsParser.fromJson(i).category == "Business") {
                contactsBUSINESS_COUNT = contactsBUSINESS_COUNT + 1;
              } else if (ContactsParser.fromJson(i).category == "Vendor") {
                contactsVENDOR_COUNT = contactsVENDOR_COUNT + 1;
              } else if (ContactsParser.fromJson(i).category == "Other") {
                contactsOTHER_COUNT = contactsOTHER_COUNT + 1;
              }
            }
          }
        }

        final shared = responseDecoded['data'][0]['shared'];

        if (shared != null) {
          for (Map i in shared) {
            sharedList.add(SharedParser.fromJson(i));
            sharedALL_COUNT = sharedALL_COUNT + 1;
            if (SharedParser.fromJson(i).category != null) {
              if (SharedParser.fromJson(i).category == "New") {
                sharedNEW_COUNT = sharedNEW_COUNT + 1;
              } else if (SharedParser.fromJson(i).category == "Client") {
                sharedCLIENT_COUNT = sharedCLIENT_COUNT + 1;
              } else if (SharedParser.fromJson(i).category == "Family") {
                sharedFAMILY_COUNT = sharedFAMILY_COUNT + 1;
              } else if (SharedParser.fromJson(i).category == "Friend") {
                sharedFRIEND_COUNT = sharedFRIEND_COUNT + 1;
              } else if (SharedParser.fromJson(i).category == "Business") {
                sharedBUSINESS_COUNT = sharedBUSINESS_COUNT + 1;
              } else if (SharedParser.fromJson(i).category == "Vendor") {
                sharedVENDOR_COUNT = sharedVENDOR_COUNT + 1;
              } else if (SharedParser.fromJson(i).category == "Other") {
                sharedOTHER_COUNT = sharedOTHER_COUNT + 1;
              }
            }
          }
        }

        notifyListeners();
        return "success";
      } else {
        notifyListeners();
        return "error";
      }
    } else {
      print("***error");
      notifyListeners();
      return "error";
    }
  }

  Future SetBanner(String serno) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final response = await WebService().SetBanner(prefs.getString('id'), serno);

    if (response != "error") {
      var responseDecoded = jsonDecode(utf8.decode(response.bodyBytes));
      var responseDecodedStatus = responseDecoded['status'];
      var responseDecodedData = responseDecoded['data'].toString();

      if (responseDecodedStatus == "false") {
        notifyListeners();
        return responseDecodedData;
      } else if (responseDecodedStatus == "true") {
        notifyListeners();
        return responseDecodedData;
      } else {
        notifyListeners();
        return "error";
      }
    } else {
      print("***error");
      notifyListeners();
      return "error";
    }
  }

  Future getFollowup(status) async {
    this.followupList.clear();
    this.todaysfollowupList.clear();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    final response =
        await WebService().getFollowup(prefs.getString('id') ?? "");

    if (response != "error") {
      var responseDecoded = jsonDecode(utf8.decode(response.bodyBytes));
      var responseDecodedStatus = responseDecoded['status'];
      var responseDecodedData = responseDecoded['data'].toString();

      if (responseDecodedStatus == "false") {
        notifyListeners();
        return "error";
      } else if (responseDecodedStatus == "true") {
        final followup = responseDecoded['data'];

        if (followup != null) {
          for (Map i in followup) {
            if (status == FollowupListParser.fromJson(i).status) {
              followupList.add(FollowupListParser.fromJson(i));

              var now = new DateTime.now();
              var formatter = new DateFormat('yyyy-MM-dd');
              String formattedDate = formatter.format(now);
              if (FollowupListParser.fromJson(i)
                  .createdAt
                  .contains(formattedDate)) {
                todaysfollowupList.add(FollowupListParser.fromJson(i));
              }
            }
          }
        }

        notifyListeners();
        return "success";
      } else {
        notifyListeners();
        return "error";
      }
    } else {
      print("***error");
      notifyListeners();
      return "error";
    }
  }

  Future getComments(email) async {
    this.commentsList.clear();

    final response = await WebService().getComments(email);

    if (response != "error") {
      var responseDecoded = jsonDecode(utf8.decode(response.bodyBytes));
      var responseDecodedStatus = responseDecoded['status'];

      if (responseDecodedStatus == "false") {
        notifyListeners();
        return "error";
      } else if (responseDecodedStatus == "true") {
        final followup = responseDecoded['data'];

        if (followup != null) {
          for (Map i in followup) {
            commentsList.add(CommentsListParser.fromJson(i));
          }
        }

        notifyListeners();
        return "success";
      } else {
        notifyListeners();
        return "error";
      }
    } else {
      notifyListeners();
      return "error";
    }
  }

  Future CancelFollowup(id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final response = await WebService().CancelFollowup(id);

    if (response != "error") {
      var responseDecoded = jsonDecode(utf8.decode(response.bodyBytes));
      var responseDecodedStatus = responseDecoded['status'];
      var responseDecodedData = responseDecoded['data'].toString();

      if (responseDecodedStatus == "false") {
        notifyListeners();
        return responseDecodedData;
      } else if (responseDecodedStatus == "true") {
        notifyListeners();
        return responseDecodedData;
      } else {
        notifyListeners();
        return "error";
      }
    } else {
      print("***error");
      notifyListeners();
      return "error";
    }
  }

  Future CompleteFollowup(id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final response = await WebService().CompleteFollowup(id);

    if (response != "error") {
      var responseDecoded = jsonDecode(utf8.decode(response.bodyBytes));
      var responseDecodedStatus = responseDecoded['status'];
      var responseDecodedData = responseDecoded['data'].toString();

      if (responseDecodedStatus == "false") {
        notifyListeners();
        return responseDecodedData;
      } else if (responseDecodedStatus == "true") {
        notifyListeners();
        return responseDecodedData;
      } else {
        notifyListeners();
        return "error";
      }
    } else {
      print("***error");
      notifyListeners();
      return "error";
    }
  }

  Future RescheduleFollowup(id, user_id, created_at) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final response =
        await WebService().RescheduleFollowup(id, user_id, created_at);

    if (response != "error") {
      var responseDecoded = jsonDecode(utf8.decode(response.bodyBytes));
      var responseDecodedStatus = responseDecoded['status'];
      var responseDecodedData = responseDecoded['data'].toString();

      if (responseDecodedStatus == "false") {
        notifyListeners();
        return responseDecodedData;
      } else if (responseDecodedStatus == "true") {
        notifyListeners();
        return responseDecodedData;
      } else {
        notifyListeners();
        return "error";
      }
    } else {
      print("***error");
      notifyListeners();
      return "error";
    }
  }

  Future AddFollowup(user_id, name, email, phone, created_at, about) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final response = await WebService()
        .AddFollowup(user_id, name, email, phone, created_at, about);

    if (response != "error") {
      var responseDecoded = jsonDecode(utf8.decode(response.bodyBytes));
      var responseDecodedStatus = responseDecoded['status'];
      var responseDecodedData = responseDecoded['data'].toString();

      if (responseDecodedStatus == "false") {
        notifyListeners();
        return responseDecodedData;
      } else if (responseDecodedStatus == "true") {
        notifyListeners();
        return responseDecodedData;
      } else {
        notifyListeners();
        return "error";
      }
    } else {
      print("***error");
      notifyListeners();
      return "error";
    }
  }

  Future getEvents() async {
    this.eventsList.clear();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final response = await WebService().getEvents(prefs.getString('id') ?? "");

    if (response != "error") {
      var responseDecoded = jsonDecode(utf8.decode(response.bodyBytes));
      var responseDecodedStatus = responseDecoded['status'];

      if (responseDecodedStatus == "false") {
        notifyListeners();
        return "error";
      } else if (responseDecodedStatus == "true") {
        final followup = responseDecoded['data'];

        if (followup != null) {
          for (Map i in followup) {
            eventsList.add(EventsListParser.fromJson(i));
          }
        }

        notifyListeners();
        return "success";
      } else {
        notifyListeners();
        return "error";
      }
    } else {
      notifyListeners();
      return "error";
    }
  }

  Future DeleteEvent(id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final response = await WebService().DeleteEvent(id);

    if (response != "error") {
      var responseDecoded = jsonDecode(utf8.decode(response.bodyBytes));
      var responseDecodedStatus = responseDecoded['status'];
      var responseDecodedData = responseDecoded['data'].toString();

      if (responseDecodedStatus == "false") {
        notifyListeners();
        return responseDecodedData;
      } else if (responseDecodedStatus == "true") {
        notifyListeners();
        return responseDecodedData;
      } else {
        notifyListeners();
        return "error";
      }
    } else {
      print("***error");
      notifyListeners();
      return "error";
    }
  }

  Future UpdateFcmToken(fcmtoken) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final response =
        await WebService().UpdateFcmToken(prefs.getString('id'), fcmtoken);

    if (response != "error") {
      var responseDecoded = jsonDecode(utf8.decode(response.bodyBytes));
      var responseDecodedStatus = responseDecoded['status'];
      var responseDecodedData = responseDecoded['data'].toString();

      if (responseDecodedStatus == "false") {
        notifyListeners();
        return responseDecodedData;
      } else if (responseDecodedStatus == "true") {
        notifyListeners();
        return responseDecodedData;
      } else {
        notifyListeners();
        return "error";
      }
    } else {
      print("***error");
      notifyListeners();
      return "error";
    }
  }

  Future getInvites() async {
    this.invitesList.clear();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final response = await WebService().getInvites(prefs.getString('id') ?? "");

    if (response != "error") {
      var responseDecoded = jsonDecode(utf8.decode(response.bodyBytes));
      var responseDecodedStatus = responseDecoded['status'];

      if (responseDecodedStatus == "false") {
        notifyListeners();
        return "error";
      } else if (responseDecodedStatus == "true") {
        final followup = responseDecoded['data'];

        if (followup != null) {
          for (Map i in followup) {
            invitesList.add(InvitesListParser.fromJson(i));
          }
        }

        notifyListeners();
        return "success";
      } else {
        notifyListeners();
        return "error";
      }
    } else {
      notifyListeners();
      return "error";
    }
  }
}
