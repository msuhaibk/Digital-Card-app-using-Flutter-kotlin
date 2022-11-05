import 'dart:convert';
import 'dart:io';

import "package:fliqcard/main.dart";

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:fliqcard/AccountBlocked.dart';
import 'package:fliqcard/Helpers/constants.dart';
import 'package:fliqcard/Helpers/helper.dart';
import 'package:fliqcard/Helpers/size_config.dart';
import 'package:fliqcard/Models/VcardParser.dart';
import 'package:fliqcard/Models/AppVersionParser.dart';
import 'package:fliqcard/UI/Auth/SelectScreen.dart';
import 'package:fliqcard/UI/Pricing/PricingScreen.dart';
import 'package:fliqcard/UI/Themes/fourthThemeScreen.dart';
import 'package:fliqcard/UI/CardListing.dart';
import 'package:fliqcard/UI/Contacts/ContactsScreen.dart';
import 'package:fliqcard/UI/Dashboard/DashBoard.dart';
import 'package:fliqcard/UI/Dashboard/LineChartSample.dart';
import 'package:fliqcard/UI/EmailSignature.dart';
import 'package:fliqcard/UI/Profile/Profile.dart';
import 'package:fliqcard/UI/ScanQR/ScanQRScreen.dart';
import 'package:fliqcard/UI/Staff/AddEditStaff.dart';
import 'package:fliqcard/UI/Staff/StaffListScreen.dart';
import 'package:fliqcard/UI/Staff/TeamListScreen.dart';
import 'package:fliqcard/UI/VirtualBackgrounds.dart';
import 'package:fliqcard/UI/widget_to_image.dart';
import 'package:fliqcard/View%20Models/CustomViewModel.dart';
import 'package:fliqcard/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:package_info/package_info.dart';
import 'package:provider/provider.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import 'Dashboard/bar_chart_demo.dart';
import 'Dashboard/bar_chart_graph.dart';
import 'Dashboard/bar_chart_model.dart';
import 'Dashboard/donut_chart_graph.dart';
import 'Events/InvitesList.dart';
import 'Events/ListOfEvents.dart';
import 'Follow/ListOfFollow.dart';
import 'NoFliqcrad.dart';
import 'Notifications/NotificationsInit.dart';
import 'Notifications/showAwesomeNotifications.dart';
import 'Radar/RadarScreen.dart';
import 'Radar/ReceivedCards.dart';
import 'ScanQR/ScanQRCode.dart';
import 'Themes/AddEditCard.dart';
import 'Themes/ThemeSelector.dart';
import 'Themes/firstThemeScreen.dart';
import 'Themes/secondThemeScreen.dart';
import 'Themes/thirdThemeScreen.dart';

import 'package:fliqcard/Models/VcardParser.dart';

import 'dart:typed_data';

import 'package:flutter/material.dart';

import 'package:home_widget/home_widget.dart';

// import 'package:convert_widget_image_example/utils.dart';
// import 'package:convert_widget_image_example/widget/card_widget.dart';
// import 'package:convert_widget_image_example/widget/title_widget.dart';
// import 'package:convert_widget_image_example/widget/widget_to_image.dart';

import 'package:charts_flutter/flutter.dart' as charts;

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('Handling a background message ${message.messageId}');
  showAwesomeNotifications(message);
}

var bytes;

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final _advancedDrawerController = AdvancedDrawerController();
  TextEditingController commentController = TextEditingController();

  bool _isloaded = false;
  PackageInfo packageInfo;
  String app_build = "";
  String app_version = "";

  GlobalKey key1;
  GlobalKey key2;
  Uint8List bytes1;
  Uint8List bytes2;

  Location location = new Location();

  bool _serviceEnabled;
  PermissionStatus _permissionGranted;
  LocationData _locationData;

  Future initTask() {
    /* Future.delayed(const Duration(milliseconds: 500), () async {

    });
*/
    return Provider.of<CustomViewModel>(context, listen: false)
        .getLatestContacts()
        .then((value) {
      return value;
    });
  }

  Future<void> datawidget() async {
    // int _counter;
  }

  getLocation() async {
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        commonToast(context, "To add Attendance location is required!");
      } else {}
    }
    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted == PermissionStatus.granted) {
        _showDiaog(context);
        //updateLocation();
      } else {
        commonToast(context, "To add Attendance location is required!");
      }
    } else if (_permissionGranted == PermissionStatus.granted) {
      _showDiaog(context);
      // updateLocation();
    }
  }

  Future updateLocation() async {
    _locationData = await location.getLocation();
    print(_locationData);
    EasyLoading.show(status: 'loading...');

    Provider.of<CustomViewModel>(context, listen: false)
        .UpdateAttendance(_locationData.latitude.toString(),
            _locationData.longitude.toString(), commentController.text ?? "")
        .then((value) {
      EasyLoading.dismiss();
      commonToast(context, "Attendance updated!");
    });
  }

  void _launchURL(String _url) async {
    await canLaunch(_url) ? await launch(_url) : throw 'Could not launch $_url';
  }

  Future checkVersion() async {
    packageInfo = await PackageInfo.fromPlatform();

    setState(() {
      _isloaded = false;
      app_build = packageInfo.buildNumber;
      app_version = packageInfo.version;
    });

    Provider.of<CustomViewModel>(context, listen: false)
        .getAppVersion()
        .then((value) {
      setState(() {
        if (value == "success") {
          Provider.of<CustomViewModel>(context, listen: false)
              .getappVersionParser()
              .then((value) {
            AppVersionParser appVersionParser = value;
            if (Platform.isAndroid) {
              if (int.parse(app_build) >=
                  int.parse(appVersionParser.androidVersion)) {
                getData();
              } else {
                showForceAlertDialog(context, appVersionParser.playstore ?? "");
              }
            } else {
              if (int.parse(app_build) >=
                  int.parse(appVersionParser.iosVersion)) {
                getData();
              } else {
                showForceAlertDialog(context, appVersionParser.appstore ?? "");
              }
            }
          });
        } else {
          commonToast(context, value);
        }
      });
    });
  }

  NotificatiosnInit() async {
    await Firebase.initializeApp();

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    await FirebaseMessaging.instance.requestPermission();
    await FirebaseMessaging.instance.setAutoInitEnabled(true);

    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    awesome_notification_init();

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      showAwesomeNotifications(message);
    });

    try {
      AwesomeNotifications().actionStream.listen((receivedNotification) {
        print("clicked");
      });
    } catch (e) {
      print("action stream exception");
    }

    try {
      var fcmtokentemp = await FirebaseMessaging.instance.getToken();
      setState(() {
        fcmtoken = fcmtokentemp;
      });
    } catch (e) {
      print("firebase default issues");
    }

    print("fcmtoken");
    print(fcmtoken);

    Provider.of<CustomViewModel>(context, listen: false)
        .UpdateFcmToken(fcmtoken);
  }

  // var vcdata;
  // var customviewObj = CustomViewModel();

  widgetupdate(vcdata) async {
    await HomeWidget.saveWidgetData<String>('_vcardata', jsonEncode(vcdata));
    await HomeWidget.saveWidgetData<int>('_isActivated', 1);
    await HomeWidget.updateWidget(
        name: 'AppWidgetProvider', iOSName: 'AppWidgetProvider');
    // commonToast(context, "Widget Activated");
  }

  Future getData() async {
    print("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa");

    // await customviewObj.getvData().then((dd) => {vcdata = dd});
    // await HomeWidget.saveWidgetData<String>('_counter', jsonEncode(vcdata));
    // await HomeWidget.updateWidget(
    //     name: 'AppWidgetProvider', iOSName: 'AppWidgetProvider');

    setState(() {
      _isloaded = false;
    });
    Provider.of<CustomViewModel>(context, listen: false)
        .getData()
        .then((value) {
      setState(() {
        if (value == "success") {
          setState(() {
            _isloaded = true;
            NotificatiosnInit();
            Provider.of<CustomViewModel>(context, listen: false).getInvites();

            //vcard update widget
            var vcdata =
                Provider.of<CustomViewModel>(context, listen: false).vcardData;
            widgetupdate(vcdata);
            // print(jsonEncode(vcdata));
            Provider.of<CustomViewModel>(context, listen: false)
                .getFollowup("pending");
          });
        } else {
          commonToast(context, value);
        }
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkVersion();
    initTask();
  }

  void showForceAlertDialog(BuildContext context, String url) {
    showCupertinoDialog(
        barrierDismissible: false,
        context: context,
        builder: (_) => CupertinoAlertDialog(
              title: new Text("Update Required!"),
              content: new Text(
                  "Upgrade to the new improved version of FliQCard app."),
              actions: [
                CupertinoButton(
                  child: Text('Update'),
                  onPressed: () {
                    _launchURL(url ?? "");
                  },
                )
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final providerListener = Provider.of<CustomViewModel>(context);

    return _isloaded == true
        ? providerListener.userData != null
            ? providerListener.userData.is_block == "0"
                ? AdvancedDrawer(
                    backdropColor: Color(COLOR_SECONDARY),
                    controller: _advancedDrawerController,
                    animationCurve: Curves.easeInOut,
                    animationDuration: const Duration(milliseconds: 300),
                    animateChildDecoration: true,
                    rtlOpening: false,
                    disabledGestures: false,
                    childDecoration: const BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(16)),
                    ),
                    child: Scaffold(
                      backgroundColor: Color(COLOR_BACKGROUND),
                      appBar: AppBar(
                        backgroundColor: Color(COLOR_BACKGROUND),
                        /* title: Container(
                          width: 70.0,
                          height: 70.0,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: Image.asset(
                            'assets/logo.png',
                          ),
                        ),*/
                        elevation: 0,
                        leading: IconButton(
                          onPressed: _handleMenuButtonPressed,
                          icon: ValueListenableBuilder<AdvancedDrawerValue>(
                            valueListenable: _advancedDrawerController,
                            builder: (_, value, __) {
                              return AnimatedSwitcher(
                                duration: Duration(milliseconds: 250),
                                child: Icon(
                                  value.visible ? Icons.clear : Icons.menu,
                                  key: ValueKey<bool>(value.visible),
                                  color: Color(COLOR_PRIMARY),
                                ),
                              );
                            },
                          ),
                        ),
                        actions: [
                          Stack(
                            children: [
                              providerListener.hide == "yes"
                                  ? Container()
                                  : Padding(
                                      padding: const EdgeInsets.only(top: 5),
                                      child: IconButton(
                                        onPressed: () {
                                          push(context, InvitesList());
                                        },
                                        icon: Icon(
                                          Icons.notifications_outlined,
                                          size: 25,
                                        ),
                                        color: Colors.black,
                                      ),
                                    ),
                              providerListener.invitesList.length > 0
                                  ? Positioned(
                                      top: 5,
                                      right: 10,
                                      child: Container(
                                        alignment: Alignment.center,
                                        height: 15,
                                        width: 15,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(50)),
                                          color: Colors.red,
                                        ),
                                        child: Text(
                                          providerListener.invitesList.length
                                              .toString(),
                                          textScaleFactor: 1,
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.poppins(
                                              fontSize: 10,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    )
                                  : SizedBox(
                                      height: 1,
                                    ),
                            ],
                          ),
                          InkWell(
                            onTap: () {
                              providerListener.vcardData != null
                                  ? push(
                                      context,
                                      AddEditCard(
                                          providerListener.vcardData.slug ?? "",
                                          providerListener.vcardData.title ??
                                              "",
                                          providerListener.vcardData.subtitle ??
                                              "",
                                          providerListener.vcardData.description ??
                                              "",
                                          providerListener.userData.email ?? "",
                                          providerListener.vcardData.company ??
                                              "",
                                          providerListener.vcardData.phone ??
                                              "",
                                          providerListener.vcardData.phone2 ??
                                              "",
                                          providerListener.vcardData.telephone ??
                                              "",
                                          providerListener.vcardData.wtPhone ??
                                              "",
                                          providerListener.vcardData.website ??
                                              "",
                                          providerListener.vcardData.address ??
                                              "",
                                          providerListener.vcardData.addressLink ??
                                              "",
                                          providerListener
                                              .vcardData.twitterLink,
                                          providerListener.vcardData.facebookLink ??
                                              "",
                                          providerListener
                                                  .vcardData.linkedinLink ??
                                              "",
                                          providerListener.vcardData.ytbLink ??
                                              "",
                                          providerListener.vcardData.pinLink ??
                                              "",
                                          providerListener.vcardData.bgcolor,
                                          providerListener.vcardData.cardcolor,
                                          providerListener.vcardData.fontcolor,
                                          providerListener.vcardData.material ??
                                              ""))
                                  : push(
                                      context,
                                      AddEditCard(
                                          "",
                                          "",
                                          "",
                                          "",
                                          providerListener.userData.email ?? "",
                                          "",
                                          "",
                                          "",
                                          "",
                                          "",
                                          "",
                                          "",
                                          "",
                                          "",
                                          "",
                                          "",
                                          "",
                                          "",
                                          "#180202",
                                          "#E26522",
                                          "#ffffff",
                                          ""),
                                    );
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(right: 20),
                              child: Icon(
                                Icons.add,
                                size: 30,
                                color: Color(COLOR_PRIMARY),
                              ),
                            ),
                          ),
                          providerListener.vcardData != null
                              ? InkWell(
                                  onTap: () {
                                    push(context, ThemeSelector());
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 20),
                                    child: Icon(
                                      Icons.photo_size_select_actual_outlined,
                                      color: Color(COLOR_PRIMARY),
                                    ),
                                  ),
                                )
                              : SizedBox(
                                  height: 1,
                                ),
                          InkWell(
                            onTap: () {
                              push(context, ReceivedCards());
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(right: 20),
                              child: Icon(
                                FlutterIcons.radar_mco,
                                color: Color(COLOR_PRIMARY),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              getData();
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(right: 20),
                              child: Icon(
                                Icons.refresh,
                                color: Color(COLOR_PRIMARY),
                              ),
                            ),
                          ),
                        ],
                      ),
                      body: _getBody(providerListener.bottomIndex),
                      bottomNavigationBar: SalomonBottomBar(
                        selectedItemColor: Color(COLOR_PRIMARY),
                        currentIndex: providerListener.bottomIndex,
                        onTap: (i) =>
                            setState(() => providerListener.bottomIndex = i),
                        items: [
                          /// Home
                          SalomonBottomBarItem(
                            icon: Icon(Icons.dashboard),
                            title: commonTitleSmall(context, "DashBoard"),
                            selectedColor: Color(COLOR_SECONDARY),
                          ),

                          /// Likes
                          SalomonBottomBarItem(
                            icon: Icon(Icons.credit_card_sharp),
                            title: commonTitleSmall(context, "FliQCard"),
                            selectedColor: Color(COLOR_SECONDARY),
                          ),

                          /// Search
                          SalomonBottomBarItem(
                            icon: Icon(Icons.contacts),
                            title: commonTitleSmall(context, "Contacts"),
                            selectedColor: Color(COLOR_SECONDARY),
                          ),
                          SalomonBottomBarItem(
                            icon: Icon(FlutterIcons.share_2_fea),
                            title: commonTitleSmall(context, "Share"),
                            selectedColor: Color(COLOR_SECONDARY),
                          ),
                        ],
                      ),
                    ),
                    drawer: SafeArea(
                      child: Container(
                        child: ListTileTheme(
                          textColor: Color(COLOR_SUBTITLE),
                          iconColor: Color(COLOR_PRIMARY),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: () {
                                  if (providerListener.userData != null &&
                                      providerListener.memberShip != null) {
                                    _advancedDrawerController.hideDrawer();
                                    push(context, CardListing());
                                  } else {
                                    push(context, PricingScreen(1));
                                  }
                                },
                                child: Row(
                                  children: [
                                    SizedBox(width: 15),
                                    Icon(Icons.download_rounded),
                                    SizedBox(width: 10),
                                    commonTitleSmallBold(
                                        context, 'FliQ-Listing'),
                                  ],
                                ),
                              ),
                              Divider(),
                              InkWell(
                                onTap: () {
                                  _advancedDrawerController.hideDrawer();
                                  push(context, VirtualBackgrounds());
                                },
                                child: Row(
                                  children: [
                                    SizedBox(width: 15),
                                    Icon(Icons.image),
                                    SizedBox(width: 10),
                                    commonTitleSmallBold(context, 'FliQ-board'),
                                  ],
                                ),
                              ),
                              providerListener.hide == "yes"
                                  ? Container()
                                  : Divider(),
                              providerListener.hide == "yes"
                                  ? Container()
                                  : InkWell(
                                      onTap: () {
                                        _advancedDrawerController.hideDrawer();
                                        push(context, EmailSignature());
                                      },
                                      child: Row(
                                        children: [
                                          SizedBox(width: 15),
                                          Icon(Icons.email),
                                          SizedBox(width: 10),
                                          commonTitleSmallBold(
                                              context, 'Email Signature'),
                                        ],
                                      ),
                                    ),
                              Divider(),
                              InkWell(
                                onTap: () {
                                  if (providerListener.userData != null &&
                                      providerListener.memberShip != null) {
                                    _advancedDrawerController.hideDrawer();
                                    push(context, ScanQRScrenn());
                                  } else {
                                    push(context, PricingScreen(1));
                                  }
                                },
                                child: Row(
                                  children: [
                                    SizedBox(width: 15),
                                    Icon(Icons.qr_code),
                                    SizedBox(width: 10),
                                    commonTitleSmallBold(context, 'QR Code'),
                                  ],
                                ),
                              ),
                              providerListener.hide == "yes"
                                  ? Container()
                                  : Divider(),
                              providerListener.hide == "yes"
                                  ? Container()
                                  : InkWell(
                                      onTap: () {
                                        if (providerListener.userData != null &&
                                            providerListener.memberShip !=
                                                null) {
                                          _advancedDrawerController
                                              .hideDrawer();
                                          push(context, ListOfFollow());
                                        } else {
                                          push(context, PricingScreen(1));
                                        }
                                      },
                                      child: Row(
                                        children: [
                                          SizedBox(width: 15),
                                          Icon(Icons.date_range_outlined),
                                          SizedBox(width: 10),
                                          commonTitleSmallBold(
                                              context, 'Follow Up'),
                                        ],
                                      ),
                                    ),
                              providerListener.hide == "yes"
                                  ? Container()
                                  : Divider(),
                              providerListener.hide == "yes"
                                  ? Container()
                                  : InkWell(
                                      onTap: () {
                                        if (providerListener.userData != null &&
                                            providerListener.memberShip !=
                                                null) {
                                          _advancedDrawerController
                                              .hideDrawer();
                                          push(context, ListOfEvents());
                                        } else {
                                          push(context, PricingScreen(1));
                                        }
                                      },
                                      child: Row(
                                        children: [
                                          SizedBox(width: 15),
                                          Icon(Icons.location_on),
                                          SizedBox(width: 10),
                                          commonTitleSmallBold(
                                              context, 'Events'),
                                        ],
                                      ),
                                    ),
                              Divider(),
                              InkWell(
                                onTap: () {
                                  if (providerListener.userData != null &&
                                      providerListener.memberShip != null) {
                                    _advancedDrawerController.hideDrawer();
                                    push(context, StaffListScreen());
                                  } else {
                                    push(context, PricingScreen(1));
                                  }
                                },
                                child: Row(
                                  children: [
                                    SizedBox(width: 15),
                                    Icon(Icons.group),
                                    SizedBox(width: 10),
                                    commonTitleSmallBold(context, 'Staff List'),
                                  ],
                                ),
                              ),
                              providerListener.teamList.isNotEmpty
                                  ? Divider()
                                  : SizedBox(
                                      height: 1,
                                    ),
                              providerListener.teamList.isNotEmpty
                                  ? InkWell(
                                      onTap: () {
                                        if (providerListener.userData != null &&
                                            providerListener.memberShip !=
                                                null) {
                                          _advancedDrawerController
                                              .hideDrawer();
                                          push(context, TeamListScreen());
                                        } else {
                                          push(context, PricingScreen(1));
                                        }
                                      },
                                      child: Row(
                                        children: [
                                          SizedBox(width: 15),
                                          Icon(Icons.group),
                                          SizedBox(width: 10),
                                          commonTitleSmallBold(
                                              context, 'Team List'),
                                        ],
                                      ),
                                    )
                                  : SizedBox(
                                      height: 1,
                                    ),
                              Divider(),
                              InkWell(
                                onTap: () {
                                  _advancedDrawerController.hideDrawer();
                                  push(context, Profile());
                                },
                                child: Row(
                                  children: [
                                    SizedBox(width: 15),
                                    Icon(Icons.settings),
                                    SizedBox(width: 10),
                                    commonTitleSmallBold(
                                        context, 'Account Settings'),
                                  ],
                                ),
                              ),
                              Divider(),
                              InkWell(
                                onTap: () async {
                                  SharedPreferences prefs =
                                      await SharedPreferences.getInstance();
                                  prefs.remove('id');
                                  pop(context);
                                  push(context, SelectScreen());
                                },
                                child: Row(
                                  children: [
                                    SizedBox(width: 15),
                                    Icon(Icons.power_settings_new_outlined),
                                    SizedBox(width: 10),
                                    commonTitleSmallBold(context, 'LogOut'),
                                  ],
                                ),
                              ),
                              Divider(),
                              InkWell(
                                onTap: () {},
                                child: commonTitleSmall(
                                    context, "Version: " + (app_version ?? "")),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                : buildAccountBlockedWidget(context)
            : SizedBox(
                height: 1,
              )
        : Container(
            height: SizeConfig.screenHeight,
            color: Colors.white,
            child: Center(
              child: new CircularProgressIndicator(
                strokeWidth: 1,
                backgroundColor: Color(COLOR_PRIMARY),
                valueColor:
                    AlwaysStoppedAnimation<Color>(Color(COLOR_BACKGROUND)),
              ),
            ),
          );
    ;
  }

  void _handleMenuButtonPressed() {
    // NOTICE: Manage Advanced Drawer state through the Controller.
    // _advancedDrawerController.value = AdvancedDrawerValue.visible();
    _advancedDrawerController.showDrawer();
  }

  _getBody(int selectedIndex) {
    final providerListener = Provider.of<CustomViewModel>(context);

    switch (selectedIndex) {
      case 0:
        return providerListener.vcardData != null
            ? Container(
                child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    providerListener.hide == "yes"
                        ? Container()
                        : Padding(
                            padding: EdgeInsets.all(10),
                            child: InkWell(
                                onTap: () {
                                  providerListener.userData.isStaff != "1"
                                      ? providerListener.memberShip != null
                                          ? print("already member")
                                          : push(context, PricingScreen(1))
                                      : print("staff");
                                },
                                child: Card(
                                  color: providerListener.memberShip != null
                                      ? Colors.lightGreen
                                      : Color(COLOR_SECONDARY),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      providerListener.memberShip != null
                                          ? providerListener.memberShip.plan ==
                                                  "EXECUTIVE"
                                              ? InkWell(
                                                  onTap: () {
                                                    push(context,
                                                        PricingScreen(1));
                                                  },
                                                  child: ListTile(
                                                    leading: Icon(
                                                        FlutterIcons
                                                            .crown_faw5s,
                                                        color: Colors.white),
                                                    title: Text(
                                                      "UPGRADE NOW",
                                                      style: TextStyle(
                                                          fontSize: 19.0,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: Colors.white),
                                                    ),
                                                    subtitle: Text(
                                                      "You have " +
                                                          providerListener
                                                              .memberShip.plan +
                                                          " plan, Valid till " +
                                                          providerListener
                                                              .memberShip
                                                              .endDate,
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 12),
                                                    ),
                                                  ),
                                                )
                                              : ListTile(
                                                  leading: Icon(
                                                      FlutterIcons.crown_faw5s,
                                                      color: Colors.white),
                                                  title: Text(
                                                      providerListener
                                                              .memberShip.plan +
                                                          " plan",
                                                      style: TextStyle(
                                                          fontSize: 19.0,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: Colors.white)),
                                                  subtitle: Text("Valid till " +
                                                      providerListener
                                                          .memberShip.endDate),
                                                )
                                          : ListTile(
                                              leading: Icon(
                                                  FlutterIcons.crown_faw5s,
                                                  color: Colors.black),
                                              title: Text("Go premium",
                                                  style: TextStyle(
                                                      fontSize: 19.0,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Colors.black)),
                                              trailing: Icon(
                                                  Icons.arrow_forward_ios,
                                                  color: Colors.black),
                                            ),
                                    ],
                                  ),
                                )),
                          ),
                    providerListener.dataList.length > 0
                        ? BarChartGraph(
                            data: providerListener.dataList,
                          )
                        : Container(),
                    /* Padding(
                        padding: EdgeInsets.only(left: 10, right: 10),
                        child: LineChartSample()),*/
                    SizedBox(height: 5),

                    // charts.PieChart(seriesList, animate: false),
                    SizedBox(height: 10),
                    Divider(
                      thickness: 1,
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                          onTap: () async {
                            push(context, ScanQRCode());

                            //mineeeemdeez

                            // final bytes1 = await Utils.capture(key1);

                            // bytes = bytes1;

                            // setState(() {
                            //   this.bytes1 = bytes1;
                            // });
                          },
                          child: Column(
                            children: [
                              Container(
                                padding: EdgeInsets.only(right: 10),
                                child: Icon(
                                  Icons.qr_code,
                                  size: 100,
                                  color: Colors.black,
                                ),
                              ),
                              commonTitleSmallBold(context, "Scan QR"),
                            ],
                          ),
                        ),
                        providerListener.hide == "yes"
                            ? Container()
                            : InkWell(
                                onTap: () {
                                  setState(() {
                                    commentController.clear();
                                  });
                                  getLocation();
                                },
                                child: Column(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.only(right: 10),
                                      child: Icon(
                                        Icons.person_pin,
                                        size: 70,
                                        color: Colors.black,
                                      ),
                                    ),
                                    commonTitleSmallBold(
                                        context, "Add Attendance"),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        var now = new DateTime.now();
                                        var formatter =
                                            new DateFormat('yyyy-MM-dd');
                                        String formattedDate =
                                            formatter.format(now);

                                        _launchURL((apiUrl +
                                            "/../attendance.php?start_at=" +
                                            formattedDate +
                                            "&end_at=" +
                                            formattedDate +
                                            "&user_id=" +
                                            providerListener.userData.id +
                                            "&staff_name=" +
                                            (providerListener
                                                    .userData.fullname ??
                                                "") +
                                            "&isfromapp=yes"));
                                      },
                                      child: Text("View Attendance ->",
                                          style: GoogleFonts.poppins(
                                              textStyle: TextStyle(
                                                  fontSize: 12.0,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.blueAccent))),
                                    ),
                                  ],
                                ),
                              ),
                      ],
                    ),
                    //mineeeee
//                     WidgetToImage(
//                       builder: (key) {
//                         this.key1 = key;
// // error may come for no theme CHECK ??
//                         return providerListener.vcardData != null
//                             ? _getTheme(providerListener.vcardData != null
//                                 ? (providerListener.vcardData.themeSelected ??
//                                         "0")
//                                     .toString()
//                                 : "0")
//                             : buildNoFliqcradWidget(context);
//                       },
//                     ),
                    // buildImage(bytes1),
                    SizedBox(height: 2),
                    GridDashboard(),
                    DonutPieChart(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                            child: (Text("All Sent and Received FliQ",
                                textAlign: TextAlign.right,
                                style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black87)))))
                      ],
                    ),
                    SizedBox(height: 30),
                    providerListener.todaysfollowupList.length > 0
                        ? Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Today's Follow Up",
                                style: TextStyle(
                                    fontSize: 19.0,
                                    fontWeight: FontWeight.w500,
                                    color: Color(COLOR_PRIMARY))),
                          )
                        : Container(),
                    SizedBox(height: 10),
                    providerListener.todaysfollowupList.length > 0
                        ? Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height:
                                  providerListener.todaysfollowupList.length *
                                      80.0,
                              child: ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: providerListener
                                      .todaysfollowupList.length,
                                  itemBuilder: (BuildContext context, int i) {
                                    return InkWell(
                                      onTap: () {
                                        // push(context,  BarChartDemo());
                                        push(context, ListOfFollow());
                                      },
                                      child: Card(
                                        elevation: 10,
                                        color: Colors.white,
                                        child: Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  Icon(
                                                    Icons.person_pin,
                                                    color: Color(COLOR_PRIMARY),
                                                    size: 30,
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Container(
                                                      width: SizeConfig
                                                              .screenWidth /
                                                          1.5,
                                                      child: Text(providerListener
                                                              .todaysfollowupList[
                                                                  i]
                                                              .name ??
                                                          "")),
                                                ],
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 10),
                                                child:
                                                    Icon(Icons.remove_red_eye),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                            ),
                          )
                        : SizedBox(
                            height: 1,
                          ),
                    SizedBox(height: 50),
                  ],
                ),
              ))
            : buildNoFliqcradWidget(context);
        break;
      case 1:
        return providerListener.vcardData != null
            ? _getTheme(providerListener.vcardData != null
                ? (providerListener.vcardData.themeSelected ?? "0").toString()
                : "0")
            : buildNoFliqcradWidget(context);
        break;
      case 2:
        return Container(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ContactsScreen(),
              ],
            ),
          ),
        );
        break;
      case 3:
        return Container(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RadarScreen(),
              ],
            ),
          ),
        );
        break;
    }
  }

  _getTheme(String index) {
    final providerListener = Provider.of<CustomViewModel>(context);
    switch (index) {
      case "1":
        return firstThemeScreen();

        break;
      case "2":
        return secondThemeScreen(providerListener.vcardData != null
            ? _getBannerLink(providerListener.vcardData)
            : "");
        break;
      case "3":
        return thirdThemeScreen();
        break;
      case "4":
        return fourthThemeScreen(providerListener.vcardData != null
            ? _getBannerLink(providerListener.vcardData)
            : "");
        break;
      default:
        return fourthThemeScreen(providerListener.vcardData != null
            ? _getBannerLink(providerListener.vcardData)
            : "");
    }
  }

  String _getBannerLink(VcardParser vcardParser) {
    return vcardParser.bannerImagePath != "" &&
            vcardParser.bannerImagePath.contains("mp4")
        ? vcardParser.bannerImagePath
        : "";
  }

  _showDiaog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10)), //this right here
            child: SingleChildScrollView(
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10)),
                        gradient: LinearGradient(
                          colors: [
                            Color(COLOR_PRIMARY),
                            Color(COLOR_SECONDARY)
                          ],
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Text("Comment",
                                style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                        fontSize: 19.0,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white70))),
                          ),
                          InkWell(
                            onTap: () {
                              pop(context);
                            },
                            child: Container(
                              padding: EdgeInsets.only(right: 12),
                              child: Icon(
                                Icons.clear,
                                color: Color(COLOR_PRIMARY),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Short description about attendance",
                          textAlign: TextAlign.start,
                          style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.black))),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 30, horizontal: 10),
                      child: Column(
                        children: [
                          TextFormField(
                            keyboardType: TextInputType.name,
                            controller: commentController,
                            maxLines: 2,
                            maxLength: 50,
                            decoration: InputDecoration(
                                hintText: 'Comment',
                                hintStyle: GoogleFonts.poppins(
                                    color: Colors.grey,
                                    letterSpacing: 1,
                                    fontSize: 16)),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: InkWell(
                        onTap: () {
                          updateLocation();
                          pop(context);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              height: 45,
                              width: 100,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12)),
                                gradient: LinearGradient(
                                  colors: [
                                    Color(COLOR_PRIMARY),
                                    Color(COLOR_SECONDARY)
                                  ],
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  "Submit",
                                  textScaleFactor: 1,
                                  style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    letterSpacing: 1,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

//mineeeee
//   Widget buildImage(Uint8List bytes) =>
//       bytes != null ? Image.memory(bytes) : Container();
}
