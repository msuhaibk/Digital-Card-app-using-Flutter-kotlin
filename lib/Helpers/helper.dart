import 'dart:io';

import 'package:fliqcard/Helpers/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';


var fcmtoken = "fcm";

int getColorCode(String color){
 return  int.parse(color.replaceAll("#", "0xff"));
}

bool isEmailValid(String email) {
  Pattern pattern =
      r'^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regex = new RegExp(pattern);
  return regex.hasMatch(email);
}

pushReplacement(BuildContext context, Widget destination) {
  Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (c, a1, a2) => destination,
        transitionsBuilder: (c, anim, a2, child) =>
            FadeTransition(opacity: anim, child: child),
        transitionDuration: Duration(milliseconds: 300),
      ));
}

push(BuildContext context, Widget destination) {
  Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (c, a1, a2) => destination,
        transitionsBuilder: (c, anim, a2, child) =>
            FadeTransition(opacity: anim, child: child),
        transitionDuration: Duration(milliseconds: 300),
      ));
}

pop(BuildContext context) {
  Navigator.pop(context);
}

void commonToast(BuildContext context, String msg) {
  Fluttertoast.showToast(toastLength: Toast.LENGTH_LONG,
      msg: msg, backgroundColor: Colors.black, textColor: Colors.white);
}

Widget redText(BuildContext context, String text) {
  return Text(text,
      style: GoogleFonts.poppins(
          textStyle: TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
              color: Colors.red)));
}


Widget commonTitle(BuildContext context, String text) {
  return Text(text,
      style: GoogleFonts.poppins(
          textStyle: TextStyle(
              fontSize: 19.0,
              fontWeight: FontWeight.w500,
              color: Color(COLOR_TITLE))));
}

Widget commonTitleBigBold(BuildContext context, String text) {
  return Text(text,
      style: GoogleFonts.poppins(
          textStyle: TextStyle(
              fontSize: 25.0,
              fontWeight: FontWeight.w500,
              color: Color(COLOR_TITLE))));
}

Widget commonTitleSmall(BuildContext context, String text) {
  return Text(text,
      style: GoogleFonts.poppins(
          textStyle: TextStyle(fontSize: 14.0, color: Color(COLOR_TITLE))));
}

Widget commonTitleBigBoldWhite(BuildContext context, String text) {
  return Text(text,
      style: GoogleFonts.poppins(
          textStyle: TextStyle(
              fontSize: 25.0,
              fontWeight: FontWeight.w500,
              color: Colors.white)));
}

Widget commonTitleSmallWhite(BuildContext context, String text) {
  return Text(text,
      style: GoogleFonts.poppins(
          textStyle: TextStyle(fontSize: 14.0, color: Colors.white)));
}

Widget commonTitleSmallBold(BuildContext context, String text) {
  return Text(text,
      style: GoogleFonts.poppins(
          textStyle: TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
              color: Color(COLOR_TITLE))));
}

Widget commonSubTitle(BuildContext context, String text) {
  return Text(text,
      style: GoogleFonts.poppins(
          textStyle: TextStyle(fontSize: 15.0, color: Color(COLOR_SUBTITLE))));
}

Widget commonSubTitleSmall(BuildContext context, String text) {
  return Text(text,
      style: GoogleFonts.poppins(
          textStyle: TextStyle(fontSize: 12.0, color: Color(COLOR_SUBTITLE))));
}




void logLongString(String s) {
  if (s == null || s.length <= 0) return;
  const int n = 1000;
  int startIndex = 0;
  int endIndex = n;
  while (startIndex < s.length) {
    if (endIndex > s.length) endIndex = s.length;
    print(s.substring(startIndex, endIndex));
    startIndex += n;
    endIndex = startIndex + n;
  }
}
