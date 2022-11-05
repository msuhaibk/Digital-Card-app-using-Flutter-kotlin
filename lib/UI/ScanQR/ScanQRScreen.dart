import 'package:fliqcard/Helpers/constants.dart';
import 'package:fliqcard/Helpers/helper.dart';
import 'package:fliqcard/Helpers/size_config.dart';
import 'package:fliqcard/View%20Models/CustomViewModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_circle_color_picker/flutter_circle_color_picker.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:share_files_and_screenshot_widgets/share_files_and_screenshot_widgets.dart';

import 'ScanQRCode.dart';

class ScanQRScrenn extends StatefulWidget {
  @override
  ScanQRScrennState createState() {
    return new ScanQRScrennState();
  }
}

class ScanQRScrennState extends State<ScanQRScrenn> {
  Color _currentColor = Color(COLOR_PRIMARY);
  final _controller = CircleColorPickerController(
    initialColor: Color(COLOR_PRIMARY),
  );

  GlobalKey previewContainer = new GlobalKey();
  int originalSize = 800;

  @override
  Widget build(BuildContext context) {
    final providerListener = Provider.of<CustomViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(COLOR_SECONDARY),
        title: commonTitle(context, "QR Code"),
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
        actions: [
          InkWell(
            onTap: () {
              push(context, ScanQRCode());
            },
            child: Container(
              padding: EdgeInsets.only(right: 10),
              child: Icon(
                Icons.qr_code,
                size: 30,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
      body: Container(
        child: providerListener.vcardData != null
            ? Container(
                child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(height: 20),
                    RepaintBoundary(
                      key: previewContainer,
                      child: QrImage(
                        foregroundColor: _currentColor,
                        backgroundColor: Colors.white,
                        data: apiUrl +
                            "/../visitcard.php?id=" +
                            providerListener.userData.id,
                        version: QrVersions.auto,
                        size: SizeConfig.screenWidth - 80,
                        gapless: true,
                        embeddedImage: NetworkImage(apiUrl +
                            "../../" +
                            providerListener.vcardData.logoImagePath),
                        embeddedImageStyle: QrEmbeddedImageStyle(
                          size: Size(60, 60),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            CircleColorPicker(
                              controller: _controller,
                              onChanged: (color) {
                                setState(() => _currentColor = color);
                              },
                              size: const Size(240, 240),
                              strokeWidth: 4,
                              thumbSize: 36,
                            ),
                            commonTitleSmall(
                                context, "Recommended to use dark colors"),
                          ],
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
                                            Icons.download_rounded,
                                            color: Color(COLOR_PRIMARY),
                                            size: 35,
                                          ),
                                        )))),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 100,
                    )
                  ],
                ),
              ))
            : Container(
                margin: EdgeInsets.all(40),
                child: Container(
                    child: commonTitle(context,
                        "Please create FliQCard to access this feature."))),
      ),
    );
  }
}
