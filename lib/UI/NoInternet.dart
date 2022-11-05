import 'dart:typed_data';

import 'package:fliqcard/Helpers/size_config.dart';
import 'package:flutter/material.dart';
import 'package:fliqcard/Helpers/constants.dart';
import 'package:fliqcard/Helpers/helper.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:share_files_and_screenshot_widgets/share_files_and_screenshot_widgets.dart';
import 'package:share_plus/share_plus.dart';

import '../main.dart';
import 'MainScreen.dart';

class NoInternet extends StatefulWidget {
  final id;

  NoInternet(this.id);

  @override
  _NoInternetState createState() => _NoInternetState();
}

class _NoInternetState extends State<NoInternet> {
  GlobalKey previewContainer = new GlobalKey();
  int originalSize = 800;
  Color _currentColor = Color(COLOR_PRIMARY);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(COLOR_BACKGROUND),
        title: commonTitle(context, "Your Offline"),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              widget.id == "0"
                  ? SizedBox(
                      height: 1,
                    )
                  : Column(
                    children: [
                      commonTitleBigBold(context, "Share QR Code"),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            RepaintBoundary(
                              key: previewContainer,
                              child: QrImage(
                                foregroundColor: _currentColor,
                                backgroundColor: Colors.white,
                                data: apiUrl + "/../visitcard.php?id=" + widget.id,
                                version: QrVersions.auto,
                                size: 200,
                                gapless: true,
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                ShareFilesAndScreenshotWidgets().shareScreenshot(
                                    previewContainer,
                                    originalSize,
                                    "Sohel",
                                    "FliQCard.png",
                                    "image/png",
                                    text: "Hi, Checkout My FliQCard!");
                              },
                              child: Container(
                                child: Center(
                                    child: Card(
                                        color: Color(COLOR_SECONDARY),
                                        margin: EdgeInsets.fromLTRB(
                                            0.0, 45.0, 0.0, 50.0),
                                        child: Container(
                                            margin: EdgeInsets.all(10),
                                            child: Padding(
                                              padding: EdgeInsets.all(10.0),
                                              child: Icon(
                                                Icons.share,
                                                color: Color(COLOR_PRIMARY),
                                                size: 35,
                                              ),
                                            )))),
                              ),
                            ),
                          ],
                        ),
                      Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              Share.share(
                                  "https://fliqcard.com/digitalcard/dashboard/visitcard.php?id=" +
                                      widget.id);
                            },
                            child: Container(
                                margin: EdgeInsets.all(10),
                                child: Column(
                                  children: [
                                    commonTitleBigBold(context, "Share Link"),
                                    SizedBox(height: 10),
                                    Icon(
                                      FlutterIcons.share_2_fea,
                                      size: 35,
                                      color: Color(COLOR_PRIMARY),
                                    ),
                                    SizedBox(height: 20),
                                  ],
                                )),
                          ),
                        ],
                      ),
                      Divider(),
                    ],
                  ),
              SizedBox(height: 20),
              SizedBox(height: 20),
              commonTitleSmallBold(
                  context, "Turn on Internet and tap to restart the app."),
              SizedBox(height: 20),
              InkWell(
                onTap: () {
                  pushReplacement(context, OnBoardingPage());
                },
                child: Center(
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                      color: Color(COLOR_SECONDARY),
                      borderRadius: BorderRadius.all(
                        Radius.circular(25),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Color(COLOR_SECONDARY).withOpacity(0.2),
                          spreadRadius: 3,
                          blurRadius: 4,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        "Restart ",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color(COLOR_PRIMARY),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              commonTitleSmallBold(
                  context, "If Internet is on, tap to skip this screen."),
              SizedBox(height: 20),
              InkWell(
                onTap: () {
                  pushReplacement(context, MainScreen());
                },
                child: Center(
                  child: Container(
                    width: 100,
                    height: 30,
                    decoration: BoxDecoration(
                      color: Color(COLOR_SECONDARY),
                      borderRadius: BorderRadius.all(
                        Radius.circular(25),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Color(COLOR_SECONDARY).withOpacity(0.2),
                          spreadRadius: 3,
                          blurRadius: 4,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        "Skip",
                        style: TextStyle(
                          fontSize: 20,
                          color: Color(COLOR_PRIMARY),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
