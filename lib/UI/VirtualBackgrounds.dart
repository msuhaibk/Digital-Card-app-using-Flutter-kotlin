import 'dart:io';

import 'package:fliqcard/Helpers/constants.dart';
import 'package:fliqcard/Helpers/helper.dart';
import 'package:fliqcard/Helpers/size_config.dart';
import 'package:fliqcard/View%20Models/CustomViewModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:share_files_and_screenshot_widgets/share_files_and_screenshot_widgets.dart';

import 'NoFliqcrad.dart';

class VirtualBackgrounds extends StatefulWidget {
  @override
  _VirtualBackgroundsState createState() => _VirtualBackgroundsState();
}

class _VirtualBackgroundsState extends State<VirtualBackgrounds> {
  GlobalKey previewContainer = new GlobalKey();
  int originalSize = 800;
  int seletedIndex = 0;

  List<String> vgPathsList = [
    "/../../assets/images/vbg1.jpg",
    "/../../assets/images/vbg2.jpg",
    "/../../assets/images/vbg3.jpg",
    "/../../assets/images/vbg4.jpg",
    "/../../assets/images/vbg5.jpg",
    "/../../assets/images/vbg6.jpg",
    "/../../assets/images/vbg7.jpg",
    "/../../assets/images/vbg8.jpg",
    "/../../assets/images/vbg9.jpg"
  ];

  File _image;

  final picker = ImagePicker();

  Future _pickImage() async {
    try {
      final pickedFile = await picker.getImage(source: ImageSource.gallery);

      setState(() {
        if (pickedFile != null) {
          _image = File(pickedFile.path);
        } else {
          print('No image selected.');
        }
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    final providerListener = Provider.of<CustomViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(COLOR_BACKGROUND),
        title: commonTitle(context, "FliQ-board"),
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
                    Divider(),
                    Container(
                      child: commonTitle(context, "Slide To Select Image"),
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 20,
                          child: Icon(
                            Icons.arrow_back_ios,
                            color: Color(COLOR_PRIMARY),
                          ),
                        ),
                        ImageSlideshow(
                          /// Width of the [ImageSlideshow].
                          width: SizeConfig.screenWidth - 60,

                          /// Height of the [ImageSlideshow].
                          height: 200,

                          /// The page to show when first creating the [ImageSlideshow].
                          initialPage: 0,

                          /// The color to paint the indicator.
                          indicatorColor: Color(COLOR_SECONDARY),

                          /// The color to paint behind th indicator.
                          indicatorBackgroundColor: Colors.grey,

                          /// The widgets to display in the [ImageSlideshow].
                          /// Add the sample image file into the images folder
                          children: [
                            Image.network(
                              apiUrl + vgPathsList[0],
                              fit: BoxFit.cover,
                            ),
                            Image.network(
                              apiUrl + vgPathsList[1],
                              fit: BoxFit.cover,
                            ),
                            Image.network(
                              apiUrl + vgPathsList[2],
                              fit: BoxFit.cover,
                            ),
                            Image.network(
                              apiUrl + vgPathsList[3],
                              fit: BoxFit.cover,
                            ),
                            Image.network(
                              apiUrl + vgPathsList[4],
                              fit: BoxFit.cover,
                            ),
                            Image.network(
                              apiUrl + vgPathsList[5],
                              fit: BoxFit.cover,
                            ),
                            Image.network(
                              apiUrl + vgPathsList[6],
                              fit: BoxFit.cover,
                            ),
                            Image.network(
                              apiUrl + vgPathsList[7],
                              fit: BoxFit.cover,
                            ),
                            Image.network(
                              apiUrl + vgPathsList[8],
                              fit: BoxFit.cover,
                            ),
                          ],

                          /// Called whenever the page in the center of the viewport changes.
                          onPageChanged: (value) {
                            print('Page changed: $value');
                            setState(() {
                              _image = null;
                              seletedIndex = value;
                            });
                          },
                        ),
                        Container(
                          width: 20,
                          child: Icon(
                            Icons.arrow_forward_ios,
                            color: Color(COLOR_PRIMARY),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Container(
                      child: commonTitle(context, "OR"),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            child: Column(children: <Widget>[
                          RaisedButton(
                            onPressed: () {
                              _pickImage();
                            },
                            child: Text("Choose Image"),
                          ),
                        ])),
                        SizedBox(
                          width: 10,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Divider(),
                    RepaintBoundary(
                      key: previewContainer,
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: _image != null
                                ? FileImage(_image)
                                : NetworkImage(
                                    apiUrl + vgPathsList[seletedIndex]),
                            fit: BoxFit.cover,
                          ),
                          gradient: LinearGradient(
                            colors: [
                              Color(COLOR_SECONDARY),
                              Color(COLOR_PRIMARY)
                            ],
                          ),
                        ),
                        child: Column(children: [
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  height: 70.0,
                                  width: 70.0,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage('assets/logo.png'),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 10, left: 10),
                                height: 80,
                                width: 2,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.black.withOpacity(0.5),
                                      Colors.black.withOpacity(00),
                                    ],
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 10.0,
                                    ),
                                    Text(providerListener.vcardData.title ?? "",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.bold)),
                                    SizedBox(
                                      height: 10.0,
                                    ),
                                    Text(
                                      (providerListener.vcardData.subtitle ??
                                              "") +
                                          "\n" +
                                          (providerListener.vcardData.company ??
                                              ""),
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Container(
                              margin: EdgeInsets.only(
                                  left: 10, top: 20, bottom: 20),
                              child: Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        QrImage(
                                          foregroundColor: Color(COLOR_PRIMARY),
                                          backgroundColor: Colors.white,
                                          data: apiUrl +
                                              "/../visitcard.php?id=" +
                                              providerListener.userData.id,
                                          version: QrVersions.auto,
                                          size: SizeConfig.screenWidth / 2.2,
                                          gapless: false,
                                          embeddedImage: NetworkImage(apiUrl +
                                              "../../" +
                                              providerListener
                                                  .vcardData.logoImagePath),
                                          embeddedImageStyle:
                                              QrEmbeddedImageStyle(
                                            size: Size(
                                                SizeConfig.screenWidth / 12,
                                                SizeConfig.screenWidth / 12),
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
                            "FliQCard",
                            "virtual_bg.png",
                            "image/png",
                            text: "Hi, Checkout My FliQCard!");
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
                                                    "FliQCard Image",
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
