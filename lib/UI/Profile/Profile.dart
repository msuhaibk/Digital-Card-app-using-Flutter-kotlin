import 'package:fliqcard/Helpers/constants.dart';
import 'package:fliqcard/Helpers/helper.dart';
import 'package:fliqcard/Helpers/size_config.dart';
import 'package:fliqcard/UI/Auth/ForgotScreen.dart';
import 'package:fliqcard/UI/Auth/SelectScreen.dart';
import 'package:fliqcard/UI/Profile/ChangePassword.dart';
import 'package:fliqcard/UI/Profile/TransactionHistory.dart';
import 'package:fliqcard/View%20Models/CustomViewModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatefulWidget {

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  int counter = 0;
  @override
  Widget build(BuildContext context) {

    final providerListener = Provider.of<CustomViewModel>(context);


    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(COLOR_BACKGROUND),
        title: commonTitle(context, "Profile"),
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
      body:Container(
      color: Color(COLOR_BACKGROUND),
      height: double.infinity,
      child:
          SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(COLOR_SECONDARY),Color(COLOR_PRIMARY)],
                    ),
                  ),
                  child: Column(
                      children: [
                        SizedBox(height: 20.0,),
                        CircleAvatar(
                          radius: 40.0,
                          backgroundImage: AssetImage('assets/logo.png'),
                          backgroundColor: Colors.white,
                        ),
                        SizedBox(height: 20.0,),
                        Text(providerListener.userData.email,
                            style: TextStyle(
                              color:Colors.white,
                              fontSize: 20.0,
                            )),
                        SizedBox(height: 10.0,),
                        /*Text('FLutter Developer',
                          style: TextStyle(
                            color:Colors.white,
                            fontSize: 15.0,
                          ),),*/
                        Container(
                          margin:EdgeInsets.all(10.0),
                          child: Card(
                              child: Padding(
                                padding:EdgeInsets.all(16.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Container(
                                        child:Column(
                                          children: [
                                            Text('Plans',
                                              style: TextStyle(
                                                  color: Colors.grey[400],
                                                  fontSize: 14.0
                                              ),),
                                            SizedBox(height: 5.0,),
                                            Text(providerListener.memberShip!=null?providerListener.memberShip.plan:"BASIC",
                                              style: TextStyle(
                                                fontSize: 15.0,
                                              ),)
                                          ],
                                        )
                                    ),

                                    Container(
                                        child:Column(
                                          children: [
                                            Text('Exiry Date',
                                              style: TextStyle(
                                                  color: Colors.grey[400],
                                                  fontSize: 14.0
                                              ),),
                                            SizedBox(height: 5.0,),
                                            Text(providerListener.memberShip!=null?providerListener.memberShip.endDate:"Unlimited",
                                              style: TextStyle(
                                                fontSize: 15.0,
                                              ),)
                                          ],
                                        )
                                    ),
                                  ],
                                ),
                              )
                          ),
                        )
                      ]
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(bottom: 100),
                  child: Center(
                      child:Card(
                          color: Colors.grey.shade200,
                          margin: EdgeInsets.fromLTRB(0.0, 45.0, 0.0, 0.0),
                          child: Container(
                              margin: EdgeInsets.all(10),
                              width: (SizeConfig.screenWidth)-100,
                              child: Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Account",
                                      style: TextStyle(
                                        fontSize: 17.0,
                                        fontWeight: FontWeight.w800,
                                      ),),
                                    Divider(color: Colors.grey[300],),
                                    providerListener.userData.isStaff=="0"? InkWell(
                                      onTap: (){
                                        push(context, TransactionHistory());
                                      },
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Icon(
                                            Icons.payment,
                                            color: Color(COLOR_PRIMARY),
                                            size: 35,
                                          ),
                                          SizedBox(width: 20.0,),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text("Transactions",
                                                style: TextStyle(
                                                  fontSize: 15.0,
                                                  color: Color(COLOR_TITLE),
                                                ),),
                                              Text("Payments History",
                                                style: TextStyle(
                                                  fontSize: 12.0,
                                                  color: Color(COLOR_SUBTITLE),
                                                ),)
                                            ],
                                          )

                                        ],
                                      ),
                                    ):SizedBox(height: 1),
                                    SizedBox(height: 20.0,),
                                    InkWell(
                                      onTap: (){
                                        push(context, ForgotScreen());
                                      },
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Icon(
                                            Icons.vpn_key,
                                            color: Color(COLOR_PRIMARY),
                                            size: 35,
                                          ),
                                          SizedBox(width: 20.0,),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text("Forgot Password",
                                                style: TextStyle(
                                                  fontSize: 15.0,
                                                  color: Color(COLOR_TITLE),
                                                ),),
                                              Text("Reset password if forgotten",
                                                style: TextStyle(
                                                  fontSize: 12.0,
                                                  color: Color(COLOR_SUBTITLE),
                                                ),)
                                            ],
                                          )

                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 20.0,),
                                    InkWell(
                                      onTap: () async {
                                        SharedPreferences prefs = await SharedPreferences.getInstance();
                                        prefs.remove('id');
                                        pushReplacement(context, SelectScreen());
                                      },
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Icon(
                                            Icons.power_settings_new_sharp,
                                            color: Color(COLOR_PRIMARY),
                                            size: 35,
                                          ),
                                          SizedBox(width: 20.0,),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text("LogOut",
                                                style: TextStyle(
                                                  fontSize: 15.0,
                                                  color: Color(COLOR_TITLE),
                                                ),),

                                            ],
                                          )

                                        ],
                                      ),
                                    ),

                                    SizedBox(height: 20.0,),

                                  ],
                                ),
                              )
                          )
                      )
                  ),
                ),
              ],
            ),
          )
    ),);
  }
}