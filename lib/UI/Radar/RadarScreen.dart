import 'package:fliqcard/Helpers/constants.dart';
import 'package:fliqcard/Helpers/helper.dart';
import 'package:fliqcard/Helpers/size_config.dart';
import 'package:fliqcard/UI/Auth/SelectScreen.dart';
import 'package:fliqcard/View%20Models/CustomViewModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../GoPremiumWidget.dart';
import 'TempReceivedCards.dart';

void _launchURL(String _url) async {
  await canLaunch(_url) ? await launch(_url) : throw 'Could not launch $_url';
}

class RadarScreen extends StatefulWidget {
  @override
  _RadarScreenState createState() => _RadarScreenState();
}

class _RadarScreenState extends State<RadarScreen> {
  Location location = new Location();

  bool _serviceEnabled;
  PermissionStatus _permissionGranted;
  LocationData _locationData;

  getLocation(int temp) async {
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        commonToast(context, "TO use Radar sharing location is required!");
      } else {}
    }
    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted == PermissionStatus.granted) {
        updateLocation(temp);
      } else {
        commonToast(context, "TO use Radar sharing location is required!");
      }
    } else if (_permissionGranted == PermissionStatus.granted) {
      updateLocation(temp);
    }
  }

  Future updateLocation(int temp) async {
    _locationData = await location.getLocation();
    print(_locationData);
    EasyLoading.show(status: 'loading...');

    Provider.of<CustomViewModel>(context, listen: false)
        .UpdateLocation(_locationData.latitude.toString(),
            _locationData.longitude.toString())
        .then((value) {
      EasyLoading.dismiss();
      if (temp == 1) {
        Provider.of<CustomViewModel>(context, listen: false)
            .SendCard(_locationData.latitude.toString(),
                _locationData.longitude.toString())
            .then((value) {
          setState(() {
            if (value == "success") {
              commonToast(context, "Card send!");
            } else {
              commonToast(context, value);
            }
          });
        });
      } else {
        push(context, TempReceivedCards());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final providerListener = Provider.of<CustomViewModel>(context);

    return Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
        child: providerListener.memberShip != null
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      color: Color(COLOR_SECONDARY),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          ListTile(
                            leading: Icon(Icons.looks_one,
                                color: Color(COLOR_PRIMARY)),
                            title: Text(
                                "All receivers should activate Radar by tapping on receive option.",
                                style: TextStyle(
                                    fontSize: 17.0,
                                    fontWeight: FontWeight.w500,
                                    color: Color(COLOR_PRIMARY))),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      color: Color(COLOR_SECONDARY),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          ListTile(
                            leading: Icon(Icons.looks_two,
                                color: Color(COLOR_PRIMARY)),
                            title: Text("Now Share FliQCard.",
                                style: TextStyle(
                                    fontSize: 17.0,
                                    fontWeight: FontWeight.w500,
                                    color: Color(COLOR_PRIMARY))),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        onTap: () {
                          if (providerListener.vcardData != null) {
                            getLocation(1);
                          } else {
                            commonToast(context, "Please create FliQCard");
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: Column(
                            children: [
                              CircleAvatar(
                                radius: SizeConfig.screenWidth / 7,
                                backgroundImage:
                                    AssetImage('assets/send2.png'),
                                backgroundColor: Colors.white,
                              ),
                              commonTitle(context, "Send"),
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          getLocation(2);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: Column(
                            children: [
                              CircleAvatar(
                                radius: SizeConfig.screenWidth / 7,
                                backgroundImage:
                                    AssetImage('assets/rec2.png'),
                                backgroundColor: Colors.white,
                              ),
                              commonTitle(context, "Receive"),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Divider(),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      commonTitleSmallBold(context, "OR"),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 10, right: 10, top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            if (providerListener.vcardData != null) {
                              if (providerListener.vcardData.slug != null &&
                                  providerListener.vcardData.slug != "") {
                                Share.share(
                                    "https://fliqcard.com/id.php?name=" +
                                        providerListener.vcardData.slug);
                              } else {
                                Share.share(
                                    "https://fliqcard.com/digitalcard/dashboard/visitcard.php?id=" +
                                        providerListener.userData.id);
                              }
                            } else {
                              Share.share(
                                  "https://fliqcard.com/digitalcard/dashboard/visitcard.php?id=" +
                                      providerListener.userData.id);
                            }
                          },
                          child: Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Color(COLOR_SECONDARY),
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            margin: EdgeInsets.all(10),
                            child: Row(
                              children: [
                                Icon(
                                  FlutterIcons.share_2_fea,
                                  size: 30,
                                  color: Color(COLOR_PRIMARY),
                                ),
                                SizedBox(width: 5),
                                commonTitleSmallBold(context, "Share with"),
                              ],
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            if (providerListener.vcardData != null) {
                              if (providerListener.vcardData.slug != null &&
                                  providerListener.vcardData.slug != "") {
                                Clipboard.setData(ClipboardData(
                                    text: "https://fliqcard.com/id.php?name=" +
                                        providerListener.vcardData.slug));
                              } else {
                                Clipboard.setData(ClipboardData(
                                    text:
                                        "https://fliqcard.com/digitalcard/dashboard/visitcard.php?id=" +
                                            providerListener.userData.id));
                              }
                            } else {
                              Clipboard.setData(ClipboardData(
                                  text:
                                      "https://fliqcard.com/digitalcard/dashboard/visitcard.php?id=" +
                                          providerListener.userData.id));
                            }

                            commonToast(context, "Copied to clipboard");
                          },
                          child: Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Color(COLOR_SECONDARY),
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            margin: EdgeInsets.all(10),
                            child: Row(
                              children: [
                                Icon(
                                  FlutterIcons.copy1_ant,
                                  size: 30,
                                  color: Color(COLOR_PRIMARY),
                                ),
                                SizedBox(width: 5),
                                commonTitleSmallBold(context, "Copy Link"),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            : Column(
                children: [
                  GoPremiumWidget(context, 1),
                  Divider(),
                  Container(
                    padding: EdgeInsets.only(left: 10, right: 10, top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            if (providerListener.vcardData != null) {
                              if (providerListener.vcardData.slug != null &&
                                  providerListener.vcardData.slug != "") {
                                Share.share(
                                    "https://fliqcard.com/id.php?name=" +
                                        providerListener.vcardData.slug);
                              } else {
                                Share.share(
                                    "https://fliqcard.com/digitalcard/dashboard/visitcard.php?id=" +
                                        providerListener.userData.id);
                              }
                            } else {
                              Share.share(
                                  "https://fliqcard.com/digitalcard/dashboard/visitcard.php?id=" +
                                      providerListener.userData.id);
                            }
                          },
                          child: Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Color(COLOR_SECONDARY),
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            margin: EdgeInsets.all(10),
                            child: Row(
                              children: [
                                Icon(
                                  FlutterIcons.share_2_fea,
                                  size: 30,
                                  color: Color(COLOR_PRIMARY),
                                ),
                                SizedBox(width: 5),
                                commonTitleSmallBold(context, "Share with"),
                              ],
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            if (providerListener.vcardData != null) {
                              if (providerListener.vcardData.slug != null &&
                                  providerListener.vcardData.slug != "") {
                                Clipboard.setData(ClipboardData(
                                    text: "https://fliqcard.com/id.php?name=" +
                                        providerListener.vcardData.slug));
                              } else {
                                Clipboard.setData(ClipboardData(
                                    text:
                                        "https://fliqcard.com/digitalcard/dashboard/visitcard.php?id=" +
                                            providerListener.userData.id));
                              }
                            } else {
                              Clipboard.setData(ClipboardData(
                                  text:
                                      "https://fliqcard.com/digitalcard/dashboard/visitcard.php?id=" +
                                          providerListener.userData.id));
                            }

                            commonToast(context, "Copied to clipboard");
                          },
                          child: Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Color(COLOR_SECONDARY),
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            margin: EdgeInsets.all(10),
                            child: Row(
                              children: [
                                Icon(
                                  FlutterIcons.copy1_ant,
                                  size: 30,
                                  color: Color(COLOR_PRIMARY),
                                ),
                                SizedBox(width: 5),
                                commonTitleSmallBold(context, "Copy Link"),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ));
  }
}
