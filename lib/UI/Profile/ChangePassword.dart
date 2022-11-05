import 'package:fliqcard/Helpers/constants.dart';
import 'package:fliqcard/Helpers/helper.dart';
import 'package:fliqcard/UI/MainScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class ChangePassword extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(COLOR_BACKGROUND),
        title: commonTitle(context, "Change Password"),
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
            SizedBox(
              height: 16,
            ),
            TextField(
                onTap: (){
                  commonToast(context, "Enter new password!");
                },
                readOnly: true,
                decoration: InputDecoration(
                  hintText: 'admin@techsohel.com',
                  hintStyle: TextStyle(fontSize: 16, color: Color(COLOR_SUBTITLE)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: BorderSide(
                      width: 0,
                      style: BorderStyle.none,
                    ),
                  ),
                  filled: true,
                  fillColor: Colors.grey.withOpacity(0.5),
                  contentPadding:
                  EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                ),
              ),
            SizedBox(
              height: 16,
            ),

            TextField(
              decoration: InputDecoration(
                hintText: 'Password',
                hintStyle: TextStyle(fontSize: 16, color: Color(COLOR_SUBTITLE)),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide(
                    width: 0,
                    style: BorderStyle.none,
                  ),
                ),
                filled: true,
                fillColor: Colors.grey.withOpacity(0.1),
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 16, vertical: 0),
              ),
            ),
            SizedBox(
              height: 24,
            ),
            InkWell(
              onTap: () {
                commonToast(context, "Feature coming soon");
                pop(context);
              },
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
                    "Save ",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(COLOR_PRIMARY),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 24,
            ),
          ],
        ),
      ),
    );
  }
}
