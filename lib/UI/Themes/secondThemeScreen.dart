import 'package:chips_choice/chips_choice.dart';
import 'package:fliqcard/Helpers/constants.dart';
import 'package:fliqcard/Helpers/helper.dart';
import 'package:fliqcard/Helpers/size_config.dart';
import 'package:fliqcard/UI/Contacts/UpdateContactScreen.dart';
import 'package:fliqcard/View%20Models/CustomViewModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';

import 'buildSocialIcons.dart';

class secondThemeScreen extends StatefulWidget {
  final banner_video;

  secondThemeScreen(this.banner_video);

  @override
  _secondThemeScreenState createState() => _secondThemeScreenState();
}

class _secondThemeScreenState extends State<secondThemeScreen> {
  VideoPlayerController _controller;
  bool _visible = false;

  @override
  void initState() {
    super.initState();

    if (_controller != null) {
      _controller.dispose();
      _controller = null;
    }
    if (widget.banner_video != null && widget.banner_video != "") {
      _controller =
          VideoPlayerController.network(apiUrl + "/../" + widget.banner_video);
      _controller.initialize().then((_) {
        _controller.setLooping(true);
        setState(() {
          _controller.play();
          _visible = true;
        });
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    if (_controller != null) {
      _controller.dispose();
      _controller = null;
    }
  }

  void _launchURL(String _url) async {
    await canLaunch(_url) ? await launch(_url) : throw 'Could not launch $_url';
  }

  _getVideoBackground() {
    return AnimatedOpacity(
      opacity: _visible ? 1.0 : 0.0,
      duration: Duration(milliseconds: 1000),
      child: VideoPlayer(_controller),
    );
  }

  _getBackgroundColor() {
    final providerListener = Provider.of<CustomViewModel>(context);
    return Container(
      width: SizeConfig.screenWidth,
      height: 200,
      child: Shimmer.fromColors(
          baseColor: Color(int.parse(
              providerListener.vcardData.fontcolor.replaceAll("#", "0xff"))),
          highlightColor: Color(COLOR_SECONDARY),
          child: Center(
            child: Text(
              'loading Banner video...',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 25.0,
              ),
            ),
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    final providerListener = Provider.of<CustomViewModel>(context);

    return Container(
        margin: EdgeInsets.all(5),
        width: double.infinity,
        child: SingleChildScrollView(
          child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              color: Colors.transparent,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Color(int.parse(providerListener.vcardData.bgcolor
                      .replaceAll("#", "0xff"))),
                ),
                child: Stack(
                  children: [
                    providerListener.vcardData.bannerImagePath != null &&
                        providerListener.vcardData.bannerImagePath != "" &&
                        providerListener.vcardData.bannerImagePath
                            .contains("mp4")
                        ? _getBackgroundColor()
                        : SizedBox(height: 0,),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        providerListener
                            .vcardData.bannerImagePath.isNotEmpty? providerListener.vcardData.bannerImagePath != null &&
                                providerListener.vcardData.bannerImagePath !=
                                    "" &&
                                providerListener.vcardData.bannerImagePath
                                    .contains("mp4")
                            ? Container(
                                height: 200, child: _getVideoBackground())
                            : Container(
                                width: SizeConfig.screenWidth,
                                height: 200,
                                child: Image.network(
                                  (apiUrl +
                                      "/../" +
                                      providerListener
                                          .vcardData.bannerImagePath)??"",
                                  fit: BoxFit.fill,
                                ),
                              ):Container(),
                        SizedBox(height: 20),
                        Padding(
                          padding: EdgeInsets.only(left: 20, right: 20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  providerListener.vcardData.profileImagePath !=
                                              null &&
                                          providerListener
                                                  .vcardData.profileImagePath !=
                                              ""
                                      ? Container(
                                          margin: EdgeInsets.only(right: 10),
                                          width: 70.0,
                                          height: 70.0,
                                          decoration: BoxDecoration(
                                            color: const Color(0xff7c94b6),
                                            image: DecorationImage(
                                              image: NetworkImage(apiUrl +
                                                  "../../" +
                                                  providerListener.vcardData
                                                      .profileImagePath),
                                              fit: BoxFit.fill,
                                            ),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(5.0)),
                                            border: Border.all(
                                              color: Color(int.parse(
                                                  providerListener
                                                      .vcardData.fontcolor
                                                      .replaceAll(
                                                          "#", "0xff"))),
                                              width: 4.0,
                                            ),
                                          ),
                                        )
                                      : SizedBox(
                                          height: 1.0,
                                        ),
                                  Text(providerListener.vcardData.title ?? "",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20.0,
                                      )),
                                ],
                              ),
                              SizedBox(
                                height: 20.0,
                              ),
                              providerListener.vcardData.subtitle!=""?  InkWell(
                                onTap: () {},
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Icon(
                                      FlutterIcons.tag_faw,
                                      color: Color(int.parse(providerListener
                                          .vcardData.fontcolor
                                          .replaceAll("#", "0xff"))),
                                      size: 14,
                                    ),
                                    SizedBox(
                                      width: 20.0,
                                    ),
                                    Text(
                                      (providerListener.vcardData.subtitle ??
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
                              ):Container(),
                              providerListener.vcardData.company!=""?  SizedBox(
                                height: 20.0,
                              ): SizedBox(
                                height: 1.0,
                              ),
                              providerListener.vcardData.company!=""?  InkWell(
                                onTap: () {},
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Icon(
                                      FlutterIcons.building_faw,
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
                              ): SizedBox(
                                height: 1.0,
                              ),
                              providerListener.vcardData.email==""?Container(): SizedBox(
                                height: 20.0,
                              ),
                              providerListener.vcardData.email==""?Container(): InkWell(
                                onTap: () {
                                  _launchURL("mailto:" +
                                          providerListener.vcardData.email ??
                                      "");
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Icon(
                                      Icons.email,
                                      color: Color(int.parse(providerListener
                                          .vcardData.fontcolor
                                          .replaceAll("#", "0xff"))),
                                      size: 16,
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
                              providerListener.vcardData.email==""?Container(): SizedBox(
                                height: 20.0,
                              ),
                              providerListener.vcardData.phone==""?Container(): InkWell(
                                onTap: () {
                                  _launchURL("tel:" +
                                          providerListener.vcardData.phone ??
                                      "");
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Icon(
                                      Icons.phone_android_sharp,
                                      color: Color(int.parse(providerListener
                                          .vcardData.fontcolor
                                          .replaceAll("#", "0xff"))),
                                      size: 16,
                                    ),
                                    SizedBox(
                                      width: 20.0,
                                    ),
                                    Text(
                                      "dsaldaassec",
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
                              providerListener.vcardData.description==""?Container(): SizedBox(
                                height: 20.0,
                              ),
                              providerListener.vcardData.description==""?Container(): Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(
                                    Icons.person,
                                    color: Color(int.parse(providerListener
                                        .vcardData.fontcolor
                                        .replaceAll("#", "0xff"))),
                                    size: 16,
                                  ),
                                  SizedBox(
                                    width: 20.0,
                                  ),
                                  Text(
                                    (providerListener.vcardData.description ?? ""),
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
                              SizedBox(
                                height: 20.0,
                              ),
                            ],
                          ),
                        ),
                        buildSocialIcons(context),
                        SizedBox(
                          height: 16.0,
                        ),
                      ],
                    ),
                  ],
                ),
              )),
        ));
  }
}
