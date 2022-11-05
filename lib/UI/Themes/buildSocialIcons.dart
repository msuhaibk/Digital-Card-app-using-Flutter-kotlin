import 'package:fliqcard/View%20Models/CustomViewModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

void _launchURL(String _url) async {
  await canLaunch(_url) ? await launch(_url) : throw 'Could not launch $_url';
}

Widget buildSocialIcons(BuildContext context) {
  final providerListener = Provider.of<CustomViewModel>(context);
  return Column(
    children: [
      Container(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            providerListener.vcardData.telephone != null &&
                    providerListener.vcardData.telephone != ""
                ? InkWell(
                    onTap: () {
                      _launchURL("tel:" + providerListener.vcardData.telephone);
                    },
                    child: Container(
                      margin: EdgeInsets.all(10),
                      child: Icon(
                        Icons.phone,
                        size: 30,
                        color: Color(int.parse(providerListener
                            .vcardData.fontcolor
                            .replaceAll("#", "0xff"))),
                      ), /*Image.network(
                    apiUrl + '/../../assets/img/phone.png',
                  ),*/
                    ),
                  )
                : SizedBox(
                    width: 1,
                  ),
            providerListener.vcardData.phone != null &&
                    providerListener.vcardData.phone != ""
                ? InkWell(
                    onTap: () {
                      _launchURL("tel:" + providerListener.vcardData.phone);
                    },
                    child: Container(
                      margin: EdgeInsets.all(10),
                      child: Icon(
                        FlutterIcons.mobile1_ant,
                        size: 30,
                        color: Color(int.parse(providerListener
                            .vcardData.fontcolor
                            .replaceAll("#", "0xff"))),
                      ),
                    ),
                  )
                : SizedBox(
                    width: 1,
                  ),
            providerListener.vcardData.website != null &&
                    providerListener.vcardData.website != ""
                ? InkWell(
                    onTap: () {
                      _launchURL("http://"+providerListener.vcardData.website);
                    },
                    child: Container(
                      margin: EdgeInsets.all(10),
                      child: Icon(
                        FlutterIcons.earth_ant,
                        size: 30,
                        color: Color(int.parse(providerListener
                            .vcardData.fontcolor
                            .replaceAll("#", "0xff"))),
                      ),
                    ),
                  )
                : SizedBox(
                    width: 1,
                  ),
            providerListener.vcardData.email != null &&
                    providerListener.vcardData.email != ""
                ? InkWell(
                    onTap: () {
                      _launchURL("mailto:" + providerListener.vcardData.email);
                    },
                    child: Container(
                      margin: EdgeInsets.all(10),
                      child: Icon(
                        Icons.email_outlined,
                        size: 35,
                        color: Color(int.parse(providerListener
                            .vcardData.fontcolor
                            .replaceAll("#", "0xff"))),
                      ),
                    ),
                  )
                : SizedBox(
                    width: 1,
                  ),
            providerListener.vcardData.wtPhone != null &&
                    providerListener.vcardData.wtPhone != ""
                ? InkWell(
                    onTap: () {
                      _launchURL("https://wa.me/" +
                          providerListener.vcardData.wtPhone
                              .replaceAll(" ", "")
                              .replaceAll("+", ""));
                    },
                    child: Container(
                      margin: EdgeInsets.all(10),
                      child: Icon(
                        FlutterIcons.logo_whatsapp_ion,
                        size: 30,
                        color: Color(int.parse(providerListener
                            .vcardData.fontcolor
                            .replaceAll("#", "0xff"))),
                      ),
                    ),
                  )
                : SizedBox(
                    width: 1,
                  ),
            providerListener.vcardData.addressLink != null &&
                    providerListener.vcardData.addressLink != ""
                ? InkWell(
                    onTap: () {
                      _launchURL(providerListener.vcardData.addressLink);
                    },
                    child: Container(
                      margin: EdgeInsets.all(10),
                      child: Icon(
                        Icons.location_on,
                        size: 30,
                        color: Color(int.parse(providerListener
                            .vcardData.fontcolor
                            .replaceAll("#", "0xff"))),
                      ),
                    ),
                  )
                : SizedBox(
                    width: 1,
                  ),
          ],
        ),
      ),
      Container(
        padding: EdgeInsets.only(left: 10, right: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            providerListener.vcardData.twitterLink != null &&
                    providerListener.vcardData.twitterLink != ""
                ? InkWell(
                    onTap: () {
                      _launchURL(providerListener.vcardData.twitterLink);
                    },
                    child: Container(
                      margin: EdgeInsets.all(10),
                      child: Icon(
                        FlutterIcons.logo_twitter_ion,
                        size: 30,
                        color: Color(int.parse(providerListener
                            .vcardData.fontcolor
                            .replaceAll("#", "0xff"))),
                      ),
                    ),
                  )
                : SizedBox(
                    width: 1,
                  ),
            providerListener.vcardData.facebookLink != null &&
                    providerListener.vcardData.facebookLink != ""
                ? InkWell(
                    onTap: () {
                      print(providerListener.vcardData.facebookLink);
                      _launchURL(providerListener.vcardData.facebookLink);
                    },
                    child: Container(
                      margin: EdgeInsets.all(10),
                      child: Icon(
                        FlutterIcons.logo_facebook_ion,
                        size: 30,
                        color: Color(int.parse(providerListener
                            .vcardData.fontcolor
                            .replaceAll("#", "0xff"))),
                      ),
                    ),
                  )
                : SizedBox(
                    width: 1,
                  ),
            providerListener.vcardData.linkedinLink != null &&
                    providerListener.vcardData.linkedinLink != ""
                ? InkWell(
                    onTap: () {
                      _launchURL(providerListener.vcardData.linkedinLink);
                    },
                    child: Container(
                      margin: EdgeInsets.all(10),
                      child: Icon(
                        FlutterIcons.logo_linkedin_ion,
                        size: 30,
                        color: Color(int.parse(providerListener
                            .vcardData.fontcolor
                            .replaceAll("#", "0xff"))),
                      ),
                    ),
                  )
                : SizedBox(
                    width: 1,
                  ),
            providerListener.vcardData.ytbLink != null &&
                providerListener.vcardData.ytbLink != ""
                ? InkWell(
              onTap: () {
                _launchURL(providerListener.vcardData.ytbLink);
              },
              child: Container(
                margin: EdgeInsets.all(10),
                child: Icon(
                  FlutterIcons.logo_youtube_ion,
                  size: 30,
                  color: Color(int.parse(providerListener
                      .vcardData.fontcolor
                      .replaceAll("#", "0xff"))),
                ),
              ),
            )
                : SizedBox(
              width: 1,
            ),
            providerListener.vcardData.pinLink != null &&
                    providerListener.vcardData.pinLink != ""
                ? InkWell(
                    onTap: () {
                      _launchURL(providerListener.vcardData.pinLink);
                    },
                    child: Container(
                      margin: EdgeInsets.all(10),
                      child: Icon(
                        FlutterIcons.logo_instagram_ion,
                        size: 35,
                        color: Color(int.parse(providerListener
                            .vcardData.fontcolor
                            .replaceAll("#", "0xff"))),
                      ),
                    ),
                  )
                : SizedBox(
                    width: 1,
                  ),
            providerListener.vcardData.material != null &&
                    providerListener.vcardData.material != ""
                ? InkWell(
                    onTap: () {
                      _launchURL(providerListener.vcardData.material);
                    },
                    child: Container(
                      margin: EdgeInsets.all(10),
                      child: Icon(
                        FlutterIcons.attachment_ent,
                        size: 35,
                        color: Color(int.parse(providerListener
                            .vcardData.fontcolor
                            .replaceAll("#", "0xff"))),
                      ),
                    ),
                  )
                : SizedBox(
                    width: 1,
                  ),
          ],
        ),
      ),
    ],
  );
}
