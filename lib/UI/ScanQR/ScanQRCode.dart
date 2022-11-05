import 'dart:async';
import 'dart:io';

import 'package:fliqcard/Helpers/constants.dart';
import 'package:fliqcard/Helpers/helper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:url_launcher/url_launcher.dart';

void _launchURL(String _url) async {
  try {
    await launch(_url);
  } catch (e) {
    print('Could not launch');
  }
}

class ScanQRCode extends StatefulWidget {
  ScanQRCode({Key key}) : super(key: key);

  @override
  _ScanQRCodeState createState() => _ScanQRCodeState();
}

class _ScanQRCodeState extends State<ScanQRCode> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

/*
  Barcode result;

  QRViewController controller;*/

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    scanQR();
  }

  Future<void> scanQR() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#EDC97A', 'Cancel', true, ScanMode.QR);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _launchURL(barcodeScanRes ?? "https://fliqcard.com");
      pop(context);
    });
  }

/*
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller.pauseCamera();
    } else if (Platform.isIOS) {
      controller.resumeCamera();
    }
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) async {
      if (scanData.code.isNotEmpty) {
        await controller.pauseCamera();
        setState(() {
          result = scanData;
          print(result.code);
          if (result.code.contains("fliqcard")) {
            _launchURL(result.code ?? "https://fliqcard.com");
          }
        });
      }
    });
  }

  @override
  void dispose() {
  //  controller?.dispose();
    super.dispose();
  }

 */

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery
        .of(context)
        .size
        .height;
    final screenWidth = MediaQuery
        .of(context)
        .size
        .width;

    return Scaffold(
      backgroundColor: Color(COLOR_SECONDARY),
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back,
            size: 20,
            color: Color(COLOR_TITLE),
          ),
        ),
        title: Text(
          "Scan QR Code",
          style: TextStyle(
            color: Color(COLOR_PRIMARY),
          ),
        ),
        backgroundColor: Color(COLOR_SECONDARY),
      ),
      body: SingleChildScrollView(
        child: Container(
            child: Container(
            height: screenHeight,
           /* child: QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
            ),*/
          ),
        ),
      ),
    );
  }
}
