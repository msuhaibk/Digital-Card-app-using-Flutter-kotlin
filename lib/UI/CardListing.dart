import 'package:fliqcard/Helpers/constants.dart';
import 'package:fliqcard/Helpers/helper.dart';
import 'package:fliqcard/Helpers/size_config.dart';
import 'package:fliqcard/View%20Models/CustomViewModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:share_files_and_screenshot_widgets/share_files_and_screenshot_widgets.dart';

import 'NoFliqcrad.dart';

class CardListing extends StatefulWidget {
  @override
  _CardListingState createState() => _CardListingState();
}

class _CardListingState extends State<CardListing> {
  int counter = 0;
  GlobalKey previewContainer = new GlobalKey();
  int originalSize = 800;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final providerListener = Provider.of<CustomViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(COLOR_BACKGROUND),
        title: commonTitle(context, "FliQ-Listing"),
        elevation: 0,
        leading: InkWell(
          onTap: () {
            pop(context);
          },
          child: Container(
            padding: EdgeInsets.all(2),
            child: Icon(
              Icons.arrow_back_ios,
              color: Color(COLOR_PRIMARY),
            ),
          ),
        ),
      ),
      body: providerListener.vcardData != null
          ? Container(
              color: Color(COLOR_BACKGROUND),
              height: double.infinity,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    RepaintBoundary(
                      key: previewContainer,
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Color(getColorCode(
                                  providerListener.vcardData.bgcolor)),
                              Color(getColorCode(
                                  providerListener.vcardData.cardcolor))
                            ],
                          ),
                        ),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 20.0,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  providerListener.vcardData.profileImagePath !=
                                              "" &&
                                          providerListener
                                                  .vcardData.profileImagePath !=
                                              null
                                      ? Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: Container(
                                            width: 80.0,
                                            height: 80.0,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(15.0)),
                                              image: DecorationImage(
                                                image: NetworkImage(apiUrl +
                                                    "../../" +
                                                    providerListener.vcardData
                                                        .profileImagePath),
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                          ),
                                      )
                                      : SizedBox(
                                          height: 1.0,
                                        ),
                                ],
                              ),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Text(providerListener.vcardData.title,
                                        style: TextStyle(
                                            color: Color(getColorCode(providerListener
                                                .vcardData.fontcolor)),
                                            fontSize: 10.0,
                                            fontWeight: FontWeight.bold)),
                                  ),
                                ],
                              ),

                              Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    providerListener.vcardData.subtitle ==
                                            null
                                        ? Container()
                                        : Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Icon(
                                                Icons.label,
                                                color: Colors.white,
                                                size: 30,
                                              ),
                                              SizedBox(
                                                width: 20.0,
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment
                                                        .start,
                                                children: [
                                                  Text(
                                                    providerListener
                                                            .vcardData
                                                            .subtitle ??
                                                        "",
                                                    style: TextStyle(
                                                      fontSize: 15.0,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                    providerListener.vcardData.subtitle ==
                                            null
                                        ? Container()
                                        : SizedBox(
                                            height: 10.0,
                                          ),
                                    providerListener.vcardData.company ==
                                            null
                                        ? Container()
                                        : Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Icon(
                                                Icons.home_work_outlined,
                                                color: Colors.white,
                                                size: 30,
                                              ),
                                              SizedBox(
                                                width: 20.0,
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment
                                                        .start,
                                                children: [
                                                  Text(
                                                    providerListener
                                                            .vcardData
                                                            .company ??
                                                        "",
                                                    style: TextStyle(
                                                      fontSize: 15.0,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                    providerListener.vcardData.company ==
                                            null
                                        ? Container()
                                        : SizedBox(
                                            height: 10.0,
                                          ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Icon(
                                          Icons.email,
                                          color: Colors.white,
                                          size: 30,
                                        ),
                                        SizedBox(
                                          width: 20.0,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              providerListener
                                                      .vcardData.email ??
                                                  "",
                                              style: TextStyle(
                                                fontSize: 15.0,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10.0,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Icon(
                                          Icons.call,
                                          color: Colors.white,
                                          size: 30,
                                        ),
                                        SizedBox(
                                          width: 20.0,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "s9d7sa9d79",
                                              style: TextStyle(
                                                fontSize: 15.0,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 8.0,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          QrImage(
                                            foregroundColor:
                                                Color(COLOR_PRIMARY),
                                            backgroundColor: Colors.white,
                                            data: apiUrl +
                                                "/../visitcard.php?id=" +
                                                providerListener.userData.id,
                                            version: QrVersions.auto,
                                            size: 200,
                                            gapless: true,
                                            embeddedImage: NetworkImage(
                                                apiUrl +
                                                    "../../" +
                                                    providerListener.vcardData
                                                        .logoImagePath),
                                            embeddedImageStyle:
                                                QrEmbeddedImageStyle(
                                              size: Size(40, 40),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ]),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        ShareFilesAndScreenshotWidgets().shareScreenshot(
                            previewContainer,
                            originalSize,
                            providerListener.vcardData.title,
                            "card_listing.png",
                            "image/png",
                            text: "Hi, Checkout My FLiQCard!");
                      },
                      child: Container(
                        child: Center(
                            child: Card(
                                color: Color(COLOR_SECONDARY),
                                margin:
                                    EdgeInsets.fromLTRB(0.0, 45.0, 0.0, 50.0),
                                child: Container(
                                    margin: EdgeInsets.all(10),
                                    width: (SizeConfig.screenWidth) - 100,
                                    child: Padding(
                                      padding: EdgeInsets.all(10.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Icon(
                                                Icons.download_rounded,
                                                color: Color(COLOR_PRIMARY),
                                                size: 35,
                                              ),
                                              SizedBox(
                                                width: 20.0,
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Download",
                                                    style: TextStyle(
                                                      fontSize: 15.0,
                                                      color: Color(COLOR_TITLE),
                                                    ),
                                                  ),
                                                  Text(
                                                    "FliQCrad Image",
                                                    style: TextStyle(
                                                      fontSize: 12.0,
                                                      color:
                                                          Color(COLOR_SUBTITLE),
                                                    ),
                                                  )
                                                ],
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    )))),
                      ),
                    ),
                  ],
                ),
              ))
          : buildNoFliqcradWidget(context),
    );
  }
}
