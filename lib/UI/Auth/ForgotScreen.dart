import 'package:fliqcard/Helpers/constants.dart';
import 'package:fliqcard/Helpers/helper.dart';
import 'package:fliqcard/Helpers/size_config.dart';
import 'package:fliqcard/UI/MainScreen.dart';
import 'package:fliqcard/View%20Models/CustomViewModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';

import 'SelectScreen.dart';

class ForgotScreen extends StatefulWidget {
  @override
  _ForgotScreenState createState() => _ForgotScreenState();
}

class _ForgotScreenState extends State<ForgotScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();

  bool isEmailValid(String email) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    return regex.hasMatch(email);
  }

  Future _ForgotPassword() {
    Provider.of<CustomViewModel>(context, listen: false)
        .ForgotPassword(emailController.text)
        .then((value) {
      setState(() {
        EasyLoading.dismiss();
        if (value == "error") {
          commonToast(context, value);
        } else {
          commonToast(context, value);
          pop(context);
        }
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      backgroundColor: Color(COLOR_SECONDARY),
      appBar: AppBar(
        backgroundColor: Color(COLOR_SECONDARY),
        title: commonTitle(context, "Forgot Password"),
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
        margin: EdgeInsets.all(40),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 30,
              ),
              TextFormField(
                controller: emailController,
                validator: (email) {
                  if (email != "") {
                    if (isEmailValid(email)) {
                      return null;
                    } else
                      return "Invalid email address";
                  } else {
                    return "Invalid email address";
                  }
                },
                maxLength: 30,
                decoration: InputDecoration(
                  hintText: 'Email',
                  hintStyle: TextStyle(
                    fontSize: 16,
                    color: Color(COLOR_SUBTITLE),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: BorderSide(
                      width: 0,
                      style: BorderStyle.none,
                    ),
                  ),
                  filled: true,
                  fillColor: Color(COLOR_BACKGROUND),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              InkWell(
                onTap: () {
                  if (_formKey.currentState.validate()) {
                    FocusScope.of(context).requestFocus(FocusNode());
                    EasyLoading.show(status: 'loading...');
                    _ForgotPassword();
                  } else {
                    commonToast(context, "Invalid credentials");
                  }
                },
                child: Container(
                  height: 40,
                  decoration: BoxDecoration(
                    color: Color(COLOR_PRIMARY),
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
                      "Get Reset Link",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(COLOR_SECONDARY),
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
