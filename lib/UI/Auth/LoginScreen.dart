import 'package:fliqcard/Helpers/constants.dart';
import 'package:fliqcard/Helpers/helper.dart';
import 'package:fliqcard/UI/MainScreen.dart';
import 'package:fliqcard/View%20Models/CustomViewModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';

import 'ForgotScreen.dart';

class LoginScreen extends StatefulWidget {


  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _obscureText = true;
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  bool isEmailValid(String email) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    return regex.hasMatch(email);
  }

  Future loginAccount() {
    Provider.of<CustomViewModel>(context, listen: false)
        .loginAccount(
      emailController.text,
      passwordController.text,
    )
        .then((value) {
      setState(() {
        EasyLoading.dismiss();
        if(value=="success"){
          pushReplacement(context, MainScreen());
        }else{
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
      child:Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          "Welcome to",
          style: TextStyle(
            fontSize: 16,
            color: Color(COLOR_PRIMARY),
            height: 2,
          ),
        ),
        Text(
          APP_TITLE,
          style: TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.bold,
            color: Color(COLOR_PRIMARY),
            letterSpacing: 2,
            height: 1,
          ),
        ),
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
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
          ),
        ),
        SizedBox(
          height: 16,
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
          maxLength: 20,
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
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
          ),
        ),
        SizedBox(
          height: 24,
        ),
        InkWell(
          onTap: (){
            if (_formKey.currentState.validate()) {
              FocusScope.of(context).requestFocus(FocusNode());
              EasyLoading.show(status: 'loading...');
              loginAccount();
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
              "LOGIN",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(COLOR_SECONDARY),
              ),
            ),
          ),
        ),),
        SizedBox(
          height: 30,
        ),
        InkWell(
          onTap: (){
                push(context, ForgotScreen());
          },
          child: Container(
            child: Text(
              "Forgot password? Reset Now",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(COLOR_PRIMARY),
                height: 1,
              ),
            ),
          ),
        ),

      ],
    ),);
  }
}
