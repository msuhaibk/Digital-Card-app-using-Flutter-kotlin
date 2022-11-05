import 'package:chips_choice/chips_choice.dart';
import 'package:fliqcard/Helpers/constants.dart';
import 'package:fliqcard/Helpers/helper.dart';
import 'package:fliqcard/Helpers/size_config.dart';
import 'package:fliqcard/UI/Contacts/UpdateContactScreen.dart';
import 'package:fliqcard/View%20Models/CustomViewModel.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';

import 'buildSocialIcons.dart';

class firstThemeScreen extends StatefulWidget {
  @override
  _firstThemeScreenState createState() => _firstThemeScreenState();
}

class _firstThemeScreenState extends State<firstThemeScreen> {
  @override
  void initState() {
    super.initState();
  }

  void _launchURL(String _url) async {
    await canLaunch(_url) ? await launch(_url) : throw 'Could not launch $_url';
  }

  @override
  Widget build(BuildContext context) {
    final providerListener = Provider.of<CustomViewModel>(context);

    return Container(
        margin: EdgeInsets.all(5),
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  color: Color(int.parse(providerListener.vcardData.bgcolor
                      .replaceAll("#", "0xff"))),
                  child: Container(
                    child: Stack(
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Container(
                              decoration: BoxDecoration(
                                color: Color(int.parse(providerListener
                                    .vcardData.cardcolor
                                    .replaceAll("#", "0xff"))),
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(15.0),
                                    topRight: Radius.circular(15.0)),
                              ),
                              width: double.infinity,
                              child: Column(children: [
                                SizedBox(
                                  height: 20.0,
                                ),
                                providerListener.vcardData.logoImagePath !=
                                            "" &&
                                        providerListener
                                                .vcardData.logoImagePath !=
                                            null
                                    ? Container(
                                        width: 70.0,
                                        height: 70.0,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                            image: NetworkImage(apiUrl +
                                                "../../" +
                                                providerListener
                                                    .vcardData.logoImagePath),
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      )
                                    : SizedBox(
                                        height: 1.0,
                                      ),
                                SizedBox(
                                  height: 20.0,
                                ),
                                Text(providerListener.vcardData.title ?? "",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.0,
                                    )),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Text(providerListener.vcardData.subtitle ?? "",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20.0,
                                    )),
                                SizedBox(
                                  height: 10.0,
                                ),
                              ]),
                            ),
                            Container(
                                decoration: providerListener
                                        .vcardData.bannerImagePath.isNotEmpty
                                    ? BoxDecoration(
                                        image: DecorationImage(
                                            image: providerListener.vcardData
                                                    .bannerImagePath.isNotEmpty
                                                ? NetworkImage(apiUrl +
                                                    "../../" +
                                                    providerListener.vcardData
                                                        .bannerImagePath)
                                                : null,
                                            fit: BoxFit.fill),
                                      )
                                    : null,
                                child: Column(
                                  children: [
                                    SizedBox(height: 20),
                                    Container(
                                      padding:
                                          EdgeInsets.only(left: 20, right: 20),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          providerListener.vcardData.company !=
                                                  ""
                                              ? InkWell(
                                                  onTap: () {},
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        (providerListener
                                                                .vcardData
                                                                .company ??
                                                            ""),
                                                        style: TextStyle(
                                                            color: Color(int.parse(
                                                                providerListener
                                                                    .vcardData
                                                                    .fontcolor
                                                                    .replaceAll(
                                                                        "#",
                                                                        "0xff"))),
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              : SizedBox(
                                                  height: 1.0,
                                                ),
                                          providerListener.vcardData.company !=
                                                  ""
                                              ? Divider(
                                                  thickness: 1,
                                                  color: Color(int.parse(
                                                      providerListener
                                                          .vcardData.fontcolor
                                                          .replaceAll(
                                                              "#", "0xff"))),
                                                )
                                              : SizedBox(
                                                  height: 1.0,
                                                ),
                                          SizedBox(
                                            height: 10.0,
                                          ),
                                          InkWell(
                                            onTap: () {
                                              _launchURL("tel:" +
                                                      providerListener
                                                          .vcardData.phone ??
                                                  "");
                                            },
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Text(
                                                  (providerListener
                                                          .vcardData.phone ??
                                                      ""),
                                                  style: TextStyle(
                                                      color: Color(int.parse(
                                                          providerListener
                                                              .vcardData
                                                              .fontcolor
                                                              .replaceAll("#",
                                                                  "0xff"))),
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Divider(
                                            thickness: 1,
                                            color: Color(int.parse(
                                                providerListener
                                                    .vcardData.fontcolor
                                                    .replaceAll("#", "0xff"))),
                                          ),
                                          SizedBox(
                                            height: 10.0,
                                          ),
                                          InkWell(
                                            onTap: () {
                                              _launchURL("mailto:" +
                                                      providerListener
                                                          .vcardData.email ??
                                                  "");
                                            },
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Text(
                                                  (providerListener
                                                          .vcardData.email ??
                                                      ""),
                                                  style: TextStyle(
                                                      color: Color(int.parse(
                                                          providerListener
                                                              .vcardData
                                                              .fontcolor
                                                              .replaceAll("#",
                                                                  "0xff"))),
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                              ],
                                            ),
                                          ),
                                          providerListener
                                                      .vcardData.description !=
                                                  ""
                                              ? Divider(
                                                  thickness: 1,
                                                  color: Color(int.parse(
                                                      providerListener
                                                          .vcardData.fontcolor
                                                          .replaceAll(
                                                              "#", "0xff"))),
                                                )
                                              : SizedBox(
                                                  height: 1.0,
                                                ),
                                          providerListener
                                                      .vcardData.description !=
                                                  ""
                                              ? InkWell(
                                                  onTap: () {},
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        (providerListener
                                                                .vcardData
                                                                .description ??
                                                            ""),
                                                        style: TextStyle(
                                                            color: Color(int.parse(
                                                                providerListener
                                                                    .vcardData
                                                                    .fontcolor
                                                                    .replaceAll(
                                                                        "#",
                                                                        "0xff"))),
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              : SizedBox(
                                                  height: 1.0,
                                                ),
                                          SizedBox(
                                            height: 10.0,
                                          ),
                                        ],
                                      ),
                                    ),
                                    buildSocialIcons(context),
                                  ],
                                )),
                          ],
                        ),
                      ],
                    ),
                  )),
            ],
          ),
        ));
  }
}
