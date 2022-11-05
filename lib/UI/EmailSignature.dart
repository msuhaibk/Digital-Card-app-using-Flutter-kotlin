import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:fliqcard/Helpers/constants.dart';
import 'package:fliqcard/Helpers/helper.dart';

class EmailSignature extends StatefulWidget {
  @override
  _EmailSignatureState createState() => _EmailSignatureState();
}

class _EmailSignatureState extends State<EmailSignature> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(COLOR_BACKGROUND),
        title: commonTitle(context, "Email signature"),
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
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            commonTitleBigBold(context, "Email signature -"),
            SizedBox(height: 20),
            commonTitle(context,
                "An email signature is a powerful way to convey your professionalism to your readers and give them the information they need to contact you. An email signature is placed at the bottom of each mail, which helps leave a great impression and makes you stand out from your peers."),
            SizedBox(height: 20),
            commonSubTitle(context,
                "Login to fliqcard.com from computer or laptop to access the feature.")
          ],
        ),
      ),
    );
  }
}
