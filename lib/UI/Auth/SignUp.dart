import 'package:fliqcard/Helpers/constants.dart';
import 'package:fliqcard/Helpers/helper.dart';
import 'package:fliqcard/Helpers/size_config.dart';
import 'package:fliqcard/UI/Auth/LoginScreen.dart';
import 'package:fliqcard/UI/MainScreen.dart';
import 'package:fliqcard/View%20Models/CustomViewModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
//import 'package:searchable_dropdown/searchable_dropdown.dart';
import 'package:url_launcher/url_launcher.dart';

import 'SelectScreen.dart';

class SignUp extends StatefulWidget {


  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController fullnameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  String country="";
  bool _obscureText = true;

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  void _launchURL(String _url) async {
    await canLaunch(_url) ? await launch(_url) : throw 'Could not launch $_url';
  }

  Future registerAccount() {
    Provider.of<CustomViewModel>(context, listen: false)
        .registerAccount(
      fullnameController.text,
      phoneController.text,
      country,
      emailController.text,
      passwordController.text,
    )
        .then((value) {
      setState(() {
        EasyLoading.dismiss();
        if (value == "success") {
         /* commonToast(context,
              "Please verify account, Email verification link sent to your email");*/

          commonToast(context,
              "Account created successfully, Please login!");

          pushReplacement(context, SelectScreen());
        } else {
          commonToast(context, value);
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
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          /* Text(
            "Sign Up",
            style: TextStyle(
              fontSize: 16,
              color: Color(COLOR_SECONDARY),
              height: 2,
            ),
          ),*/
          Text(
            "Sign Up",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(COLOR_SECONDARY),
              letterSpacing: 2,
              height: 1,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          TextFormField(
            controller: fullnameController,
            validator: (fullname) {
              if (fullname != "") {
                return null;
              } else {
                return "Full Name required";
              }
            },
            decoration: InputDecoration(
              hintText: 'Full Name',
              hintStyle: TextStyle(fontSize: 16, color: Color(COLOR_PRIMARY)),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
                borderSide: BorderSide(
                  width: 0,
                  style: BorderStyle.none,
                ),
              ),
              filled: true,
              fillColor: Colors.grey.withOpacity(0.1),
              contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
            controller: phoneController,
            validator: (phone) {
              if (phone != "") {
                return null;
              } else {
                return "Phone Number required";
              }
            },
            decoration: InputDecoration(
              hintText: 'Phone Number',
              hintStyle: TextStyle(fontSize: 16, color: Color(COLOR_PRIMARY)),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
                borderSide: BorderSide(
                  width: 0,
                  style: BorderStyle.none,
                ),
              ),
              filled: true,
              fillColor: Colors.grey.withOpacity(0.1),
              contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
            ),
          ),
          SizedBox(
            height: 10,
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
            decoration: InputDecoration(
              hintText: 'Email',
              hintStyle: TextStyle(fontSize: 16, color: Color(COLOR_PRIMARY)),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
                borderSide: BorderSide(
                  width: 0,
                  style: BorderStyle.none,
                ),
              ),
              filled: true,
              fillColor: Colors.grey.withOpacity(0.1),
              contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
            controller: passwordController,
            obscureText: _obscureText,
            validator: (password) {
              if (password != "" && password.length > 5) {
                return null;
              } else {
                return "Password must be 6 digits or more";
              }
            },
            decoration: InputDecoration(
              suffixIcon: GestureDetector(
                  onTap: () {
                    _toggle();
                  },
                  child: Icon(
                    _obscureText ? Icons.visibility_off : Icons.visibility,
                    color: Colors.grey,
                  )),
              hintText: 'Password',
              hintStyle: TextStyle(fontSize: 16, color: Color(COLOR_PRIMARY)),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
                borderSide: BorderSide(
                  width: 0,
                  style: BorderStyle.none,
                ),
              ),
              filled: true,
              fillColor: Colors.grey.withOpacity(0.1),
              contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
            ),
          ),
          Container(
            height: 80,
            width: SizeConfig.screenWidth,
            decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  width: 0,
                  style: BorderStyle.none,
                ),
                borderRadius: BorderRadius.circular(25),
              ),
            ),
            child:/* DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                hint: Padding(
                  child: Text(country,
                      style: GoogleFonts.poppins(
                          textStyle: TextStyle(fontSize: 15.0, color: Colors.black))),
                  padding: EdgeInsets.only(left: 15, top: 5),
                ),
                items: countriesList
                    .map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: new Text(value),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    country = value;
                  });
                },
              ),
            ),*/
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
//                SearchableDropdown.single(
//                  items:  countriesList
//                      .map((String value) {
//                    return DropdownMenuItem<String>(
//                      value: value,
//                      child: new Text(value),
//                    );
//                  }).toList(),
//                  underline: Container(
//                    height: 1.0,
//                    decoration: BoxDecoration(
//                        border:
//                        Border(bottom: BorderSide(color: Color(COLOR_SECONDARY), width: 3.0))),
//                  ),
//                  hint: Container(
//                    child: Text("Select Country"??"",
//                        style: GoogleFonts.poppins(
//                            textStyle: TextStyle(fontSize: 15.0, color: Colors.black))),
//                    padding: EdgeInsets.only(left: 15, top: 10, bottom: 10, right: 20),
//                  ),
//                  onChanged: (value) {
//                    setState(() {
//                      country = value;
//                      print(value);
//                    });
//                  },
//                  displayClearIcon: false,
//
//                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Column(
              children: [
                Text(
                  "By clicking on submit you are agree to our",
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(COLOR_PRIMARY),
                    height: 2,
                  ),
                ),
                InkWell(
                  onTap: () {
                    _launchURL(termsandconditions);
                  },
                  child: Text(
                    "terms and conditions.",
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.blueAccent,
                      height: 2,
                    ),
                  ),
                ),
              ],
            ),
          ),
          InkWell(
            onTap: () {
              if (_formKey.currentState.validate()) {
                EasyLoading.show(status: 'loading...');

                registerAccount();
              } else {
                commonToast(context, "Invalid credentials");
              }
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
                  "SIGN UP",
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
            height: 40,
          ),
          /* Text(
          "Or Signup with",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16,
            color: Color(COLOR_SECONDARY),
            height: 1,
          ),
        ),

        SizedBox(
          height: 16,
        ),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            Icon(
              Entypo.facebook_with_circle,
              size: 32,
              color: Color(COLOR_SECONDARY),
            ),

            SizedBox(
              width: 24,
            ),

            Icon(
              Entypo.google__with_circle,
              size: 32,
              color: Color(COLOR_SECONDARY),
            ),

          ],
        )*/
        ],
      ),
    );
  }
}
