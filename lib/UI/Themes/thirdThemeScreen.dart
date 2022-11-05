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

class thirdThemeScreen extends StatefulWidget {
  @override
  _thirdThemeScreenState createState() => _thirdThemeScreenState();
}

class _thirdThemeScreenState extends State<thirdThemeScreen> {
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
      decoration: BoxDecoration(
        color: Color(int.parse(
            providerListener.vcardData.bgcolor.replaceAll("#", "0xff"))),
        borderRadius: BorderRadius.circular(15),
        image: providerListener.vcardData.bannerImagePath.isNotEmpty
            ? DecorationImage(
                image:
                    NetworkImage(apiUrl + "../../../assets/images/bgtheme.png"),
                fit: BoxFit.fill)
            : null,
      ),
      child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          color: Colors.transparent,
          child: Stack(
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(
                        left: 10, right: 100, top: 10, bottom: 10),
                    child: Container(
                      margin: EdgeInsets.only(left: 10, bottom: 10, top: 10),
                      width: SizeConfig.screenWidth,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            providerListener.vcardData.title ?? "",
                            style: TextStyle(
                                color: Color(int.parse(providerListener
                                    .vcardData.fontcolor
                                    .replaceAll("#", "0xff"))),
                                fontSize: 22,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            (providerListener.vcardData.subtitle ?? ""),
                            style: TextStyle(
                                color: Color(int.parse(providerListener
                                    .vcardData.fontcolor
                                    .replaceAll("#", "0xff"))),
                                fontSize: 15,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20, right: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        providerListener.vcardData.company != ""
                            ? InkWell(
                                onTap: () {},
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Icon(
                                      Icons.circle,
                                      color: Color(int.parse(providerListener
                                          .vcardData.fontcolor
                                          .replaceAll("#", "0xff"))),
                                      size: 14,
                                    ),
                                    SizedBox(
                                      width: 20.0,
                                    ),
                                    Text(
                                      (providerListener.vcardData.company ??
                                          ""),
                                      style: TextStyle(
                                          color: Color(int.parse(
                                              providerListener
                                                  .vcardData.fontcolor
                                                  .replaceAll("#", "0xff"))),
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500),
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
                        InkWell(
                          onTap: () {
                            _launchURL(
                                "tel:" + providerListener.vcardData.phone ??
                                    "");
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.circle,
                                color: Color(int.parse(providerListener
                                    .vcardData.fontcolor
                                    .replaceAll("#", "0xff"))),
                                size: 14,
                              ),
                              SizedBox(
                                width: 20.0,
                              ),
                              Text(
                                "dsaldaasthird",
                                style: TextStyle(
                                    color: Color(int.parse(providerListener
                                        .vcardData.fontcolor
                                        .replaceAll("#", "0xff"))),
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        providerListener.vcardData.email == ""
                            ? Container()
                            : InkWell(
                                onTap: () {
                                  _launchURL("mailto:" +
                                          providerListener.vcardData.email ??
                                      "");
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Icon(
                                      Icons.circle,
                                      color: Color(int.parse(providerListener
                                          .vcardData.fontcolor
                                          .replaceAll("#", "0xff"))),
                                      size: 14,
                                    ),
                                    SizedBox(
                                      width: 20.0,
                                    ),
                                    Text(
                                      (providerListener.vcardData.email ?? ""),
                                      style: TextStyle(
                                          color: Color(int.parse(
                                              providerListener
                                                  .vcardData.fontcolor
                                                  .replaceAll("#", "0xff"))),
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                              ),
                        providerListener.vcardData.website == ""
                            ? Container()
                            : SizedBox(
                                height: 10.0,
                              ),
                        providerListener.vcardData.website == ""
                            ? Container()
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(
                                    Icons.circle,
                                    color: Color(int.parse(providerListener
                                        .vcardData.fontcolor
                                        .replaceAll("#", "0xff"))),
                                    size: 14,
                                  ),
                                  SizedBox(
                                    width: 20.0,
                                  ),
                                  Text(
                                    (providerListener.vcardData.website ?? ""),
                                    style: TextStyle(
                                        color: Color(int.parse(providerListener
                                            .vcardData.fontcolor
                                            .replaceAll("#", "0xff"))),
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                        providerListener.vcardData.description == ""
                            ? Container()
                            : SizedBox(
                                height: 10.0,
                              ),
                        providerListener.vcardData.description == ""
                            ? Container()
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(
                                    Icons.circle,
                                    color: Color(int.parse(providerListener
                                        .vcardData.fontcolor
                                        .replaceAll("#", "0xff"))),
                                    size: 14,
                                  ),
                                  SizedBox(
                                    width: 20.0,
                                  ),
                                  Text(
                                    (providerListener.vcardData.description ??
                                        ""),
                                    style: TextStyle(
                                        color: Color(int.parse(providerListener
                                            .vcardData.fontcolor
                                            .replaceAll("#", "0xff"))),
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  providerListener.vcardData.profileImagePath != null &&
                          providerListener.vcardData.profileImagePath != ""
                      ? Container(
                          width: 100.0,
                          height: 100.0,
                          decoration: BoxDecoration(
                            color: const Color(0xff7c94b6),
                            image: DecorationImage(
                              image: NetworkImage(apiUrl +
                                  "../../" +
                                  providerListener.vcardData.profileImagePath),
                              fit: BoxFit.fill,
                            ),
                            borderRadius:
                                BorderRadius.all(Radius.circular(100.0)),
                            border: Border.all(
                              color: Color(int.parse(providerListener
                                  .vcardData.fontcolor
                                  .replaceAll("#", "0xff"))),
                              width: 2.0,
                            ),
                          ),
                        )
                      : SizedBox(
                          height: 1.0,
                        ),
                  SizedBox(
                    height: 30.0,
                  ),
                  buildSocialIcons(context),
                  SizedBox(
                    height: 30.0,
                  ),
                ],
              ),
              providerListener.vcardData.logoImagePath != "" &&
                      providerListener.vcardData.logoImagePath != null
                  ? Positioned(
                      top: 15,
                      right: 15,
                      child: InkWell(
                        onTap: () {},
                        child: Container(
                          width: 70.0,
                          height: 70.0,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            image: DecorationImage(
                              image: NetworkImage(apiUrl +
                                  "../../" +
                                  providerListener.vcardData.logoImagePath),
                              fit: BoxFit.fill,
                            ),
                            borderRadius:
                                BorderRadius.all(Radius.circular(15.0)),
                          ),
                        ),
                      ),
                    )
                  : SizedBox(
                      height: 1,
                    ),
            ],
          )),
    );
  }
}
