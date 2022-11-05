import 'dart:async';

import 'package:animated_size_and_fade/animated_size_and_fade.dart';
import 'package:fliqcard/Helpers/constants.dart';
import 'package:fliqcard/Helpers/helper.dart';
import 'package:fliqcard/Helpers/size_config.dart';
import 'package:fliqcard/UI/Themes/buildSocialIcons.dart';
import 'package:fliqcard/View%20Models/CustomViewModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:video_player/video_player.dart';

class fourthThemeScreen extends StatefulWidget {
  final banner_video;

  fourthThemeScreen(this.banner_video);

  @override
  State<StatefulWidget> createState() => _fourthThemeScreenState();
}

class _fourthThemeScreenState extends State<fourthThemeScreen>
    with TickerProviderStateMixin {
  VideoPlayerController _controller;
  bool _visible = false;
  bool toggle = false;

  @override
  void initState() {
    super.initState();
    if (_controller != null) {
      _controller.dispose();
      _controller = null;
    }
    if (widget.banner_video != null && widget.banner_video != "") {
      print(widget.banner_video);
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

  _getVideoBackground() {
    return AnimatedOpacity(
      opacity: _visible ? 1.0 : 0.0,
      duration: Duration(milliseconds: 1000),
      child: VideoPlayer(_controller),
    );
  }

  _getBackgroundColor() {
    final providerListener = Provider.of<CustomViewModel>(context);
    return SizedBox(
      width: SizeConfig.screenWidth,
      height: SizeConfig.screenHeight,
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

  _getContent() {
    final providerListener = Provider.of<CustomViewModel>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        AnimatedSizeAndFade.showHide(
          vsync: this,
          fadeDuration: Duration(milliseconds: 100),
          sizeDuration: Duration(milliseconds: 100),
          show: toggle,
          child: Column(
            children: [
              SizedBox(
                height: 100.0,
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
                        borderRadius: BorderRadius.all(Radius.circular(50.0)),
                        border: Border.all(
                          color: Color(int.parse(providerListener
                              .vcardData.fontcolor
                              .replaceAll("#", "0xff"))),
                          width: 4.0,
                        ),
                      ),
                    )
                  : SizedBox(
                      height: 1.0,
                    ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                providerListener.vcardData.title ?? "",
                style: TextStyle(
                    color: Color(int.parse(providerListener.vcardData.fontcolor
                        .replaceAll("#", "0xff"))),
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 5.0,
              ),
              Container(
                width: SizeConfig.screenWidth - 50,
                alignment: Alignment.center,
                child: Center(
                  child: Text(
                    (providerListener.vcardData.subtitle ?? "") +
                            (providerListener.vcardData.company != ""
                                ? ","
                                : "") +
                            providerListener.vcardData.company ??
                        "",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Color(int.parse(providerListener
                            .vcardData.fontcolor
                            .replaceAll("#", "0xff"))),
                        fontSize: 18,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              buildSocialIcons(context),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final providerListener = Provider.of<CustomViewModel>(context);

    return Scaffold(
      body: Container(
        color: Color(int.parse(
            providerListener.vcardData.bgcolor.replaceAll("#", "0xff"))),
        child: providerListener.vcardData != null
            ? Stack(
                children: <Widget>[
                  providerListener.vcardData.bannerImagePath != null &&
                          providerListener.vcardData.bannerImagePath != "" &&
                          providerListener.vcardData.bannerImagePath
                              .contains("mp4")
                      ? _getBackgroundColor()
                      : Container(
                          width: SizeConfig.screenWidth,
                          height: SizeConfig.screenHeight,
                          child: Image.network(
                            apiUrl +
                                "/../" +
                                providerListener.vcardData.bannerImagePath,
                            fit: BoxFit.fill,
                          ),
                        ),
                  providerListener.vcardData.bannerImagePath != null &&
                          providerListener.vcardData.bannerImagePath != "" &&
                          providerListener.vcardData.bannerImagePath
                              .contains("mp4")
                      ? _getVideoBackground()
                      : SizedBox(
                          height: 1,
                        ),
                  _getContent(),
                  providerListener.vcardData.logoImagePath != "" &&
                          providerListener.vcardData.logoImagePath != null
                      ? Positioned(
                          bottom: 20,
                          left: (SizeConfig.screenWidth / 2) - 50,
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                toggle = !toggle;
                              });
                            },
                            child: Container(
                              width: 100.0,
                              height: 100.0,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(Radius.circular(15.0)),
                                image: DecorationImage(
                                  image: NetworkImage(apiUrl +
                                      "../../" +
                                      providerListener.vcardData.logoImagePath),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                          ),
                        )
                      : SizedBox(
                          height: 1,
                        )
                ],
              )
            : Container(
                margin: EdgeInsets.all(40),
                child: Container(
                    child: commonTitle(context,
                        "Please create FliQCard to acces this feature."))),
      ),
    );
  }
}
