import 'package:fliqcard/Helpers/constants.dart';
import 'package:fliqcard/Helpers/helper.dart';
import 'package:fliqcard/Helpers/size_config.dart';
import 'package:fliqcard/View%20Models/CustomViewModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:share_files_and_screenshot_widgets/share_files_and_screenshot_widgets.dart';

import 'NoFliqcrad.dart';

class CardListingStaff extends StatefulWidget {
  final id;

  CardListingStaff(this.id);

  @override
  _CardListingStaffState createState() => _CardListingStaffState();
}

class _CardListingStaffState extends State<CardListingStaff> {
  int counter = 0;
  GlobalKey previewContainer = new GlobalKey();
  int originalSize = 800;
  bool _enabled = false;

  Future initTask() {
    Provider.of<CustomViewModel>(context, listen: false)
        .getStaffsFliqcard(widget.id)
        .then((value) {
      setState(() {
        if (value == "error") {
          commonToast(context, "FliQCard not created by the staff");
        } else {
          _enabled = true;
        }
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initTask();
  }

  @override
  Widget build(BuildContext context) {
    final providerListener = Provider.of<CustomViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(COLOR_BACKGROUND),
        title: commonTitle(context, "Card Listing"),
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
      body: _enabled == true
          ? providerListener.staffsFliqcard != null
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
                                      providerListener.staffsFliqcard.bgcolor)),
                                  Color(getColorCode(
                                      providerListener.staffsFliqcard.cardcolor))
                                ],
                              ),
                            ),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: 20.0,
                                  ),
                                  providerListener.staffsFliqcard.profileImagePath !=
                                              "" &&
                                          providerListener
                                                  .staffsFliqcard.profileImagePath !=
                                              null
                                      ? CircleAvatar(
                                          radius: 40.0,
                                          backgroundImage: NetworkImage(apiUrl +
                                              "../../" +
                                              providerListener
                                                  .staffsFliqcard.profileImagePath),
                                          backgroundColor: Colors.white,
                                        )
                                      : SizedBox(
                                          height: 1.0,
                                        ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  Text(providerListener.staffsFliqcard.title,
                                      style: TextStyle(
                                          color: Color(getColorCode(
                                              providerListener
                                                  .staffsFliqcard.fontcolor)),
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.bold)),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  Text(
                                    (providerListener.staffsFliqcard.subtitle ??
                                            "") +
                                        (providerListener.staffsFliqcard.company !=
                                                ""
                                            ? ","
                                            : "") +
                                        (providerListener.staffsFliqcard.company ??
                                            ""),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15.0,
                                    ),
                                  ),
                                  Container(
                                      margin: EdgeInsets.all(10),
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
                                                  Icons.email,
                                                  color: Colors.white,
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
                                                      providerListener.staffsFliqcard
                                                              .email ??
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
                                                      providerListener.staffsFliqcard
                                                              .phone ??
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
                                              height: 15.0,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                QrImage(
                                                  foregroundColor:
                                                      Color(COLOR_PRIMARY),
                                                  backgroundColor: Colors.white,
                                                  data: apiUrl +
                                                      "/../visitcard.php?id=" +
                                                      providerListener
                                                          .userData.id,
                                                  version: QrVersions.auto,
                                                  size: 200,
                                                  gapless: true,
                                                  embeddedImage: NetworkImage(
                                                      apiUrl +
                                                          "../../" +
                                                          providerListener
                                                              .staffsFliqcard
                                                              .logoImagePath),
                                                  embeddedImageStyle:
                                                      QrEmbeddedImageStyle(
                                                    size: Size(40, 40),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ))
                                ]),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            ShareFilesAndScreenshotWidgets().shareScreenshot(
                                previewContainer,
                                originalSize,
                                providerListener.staffsFliqcard.title,
                                "card_listing.png",
                                "image/png",
                                text: "Hi, Checkout My FLiQCard!");
                          },
                          child: Container(
                            child: Center(
                                child: Card(
                                    color: Color(COLOR_SECONDARY),
                                    margin: EdgeInsets.fromLTRB(
                                        0.0, 45.0, 0.0, 50.0),
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
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        "Download",
                                                        style: TextStyle(
                                                          fontSize: 15.0,
                                                          color: Color(
                                                              COLOR_TITLE),
                                                        ),
                                                      ),
                                                      Text(
                                                        "FliQCrad Image",
                                                        style: TextStyle(
                                                          fontSize: 12.0,
                                                          color: Color(
                                                              COLOR_SUBTITLE),
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
              : buildNoFliqcradWidget(context)
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
            ),
    );
  }
}
