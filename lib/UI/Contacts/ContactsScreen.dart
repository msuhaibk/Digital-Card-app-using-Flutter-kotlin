import 'package:animated_radio_buttons/animated_radio_buttons.dart';
import 'package:fliqcard/Helpers/constants.dart';
import 'package:fliqcard/Helpers/helper.dart';
import 'package:fliqcard/Helpers/size_config.dart';
import 'package:fliqcard/UI/Contacts/ListOfContacts.dart';
import 'package:fliqcard/UI/Contacts/ListOfShared.dart';
import 'package:fliqcard/View%20Models/CustomViewModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../GoPremiumWidget.dart';

int _selectedTab = 0;

class ContactsScreen extends StatefulWidget {
  @override
  _ContactsScreenState createState() => _ContactsScreenState();
}

class _ContactsScreenState extends State<ContactsScreen> {
  bool _enabled = true;

  Future initTask() {
    /* Future.delayed(const Duration(milliseconds: 500), () async {

    });
*/
    Provider.of<CustomViewModel>(context, listen: false)
        .getLatestContacts()
        .then((value) {
      setState(() {
        _enabled = false;
      });
    });
  }

  Future getLatestContacts(String category) async {
    setState(() {
      _enabled = true;
    });

    Provider.of<CustomViewModel>(context, listen: false)
        .getLatestContacts()
        .then((value) {
      setState(() {
        _enabled = false;
        if (value == "success") {
          _selectedTab == 0
              ? push(context, ListOfContacts(category))
              : push(context, ListOfShared(category));
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
    initTask();
  }

  @override
  Widget build(BuildContext context) {
    final providerListener = Provider.of<CustomViewModel>(context);

    return Container(
      width: SizeConfig.screenWidth,
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
      child: Column(
        children: <Widget>[
          _enabled == true
              ? Container(
                  height: SizeConfig.screenWidth,
                  child: Container(
                    child: Shimmer.fromColors(
                      baseColor: Colors.grey[300],
                      highlightColor: Colors.grey[100],
                      enabled: _enabled,
                      child: ListView.builder(
                        itemBuilder: (_, __) => Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 48.0,
                                height: 48.0,
                                color: Colors.white,
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8.0),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      width: double.infinity,
                                      height: 8.0,
                                      color: Colors.white,
                                    ),
                                    const Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 2.0),
                                    ),
                                    Container(
                                      width: double.infinity,
                                      height: 8.0,
                                      color: Colors.white,
                                    ),
                                    const Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 2.0),
                                    ),
                                    Container(
                                      width: 40.0,
                                      height: 8.0,
                                      color: Colors.white,
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        itemCount: 6,
                      ),
                    ),
                  ),
                )
              : Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        children: [
                          AnimatedRadioButtons(
                            value: _selectedTab,
                            backgroundColor: Colors.transparent,
                            layoutAxis: Axis.horizontal,
                            buttonRadius: 25.0,
                            items: [
                              AnimatedRadioButtonItem(
                                  label: "Sent FliQ",
                                  color: Color(COLOR_PRIMARY),
                                  fillInColor: Color(COLOR_SECONDARY)),
                              AnimatedRadioButtonItem(
                                  label: "Received FliQ",
                                  color: Color(COLOR_PRIMARY),
                                  fillInColor: Colors.white70),
                            ],
                            onChanged: (value) {
                              setState(() {
                                print(value);
                                _selectedTab = value;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    (_selectedTab == 0
                                ? providerListener.contactsList.length
                                : providerListener.sharedList.length) ==
                            0
                        ? Container()
                        : InkWell(
                            onTap: () {
                              getLatestContacts("New");
                            },
                            child: Card(
                              color: _selectedTab == 0
                                  ? Color(COLOR_SECONDARY)
                                  : Colors.white70,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  ListTile(
                                    leading: Icon(
                                      FlutterIcons.new_box_mco,
                                    ),
                                    title: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("New",
                                            style: TextStyle(
                                                fontSize: 19.0,
                                                fontWeight: FontWeight.w500,
                                                color: Color(COLOR_PRIMARY))),
                                        Container(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                  ((_selectedTab == 0
                                                                  ? (providerListener
                                                                          .contactsNEW_COUNT ??
                                                                      0)
                                                                  : (providerListener
                                                                          .sharedNEW_COUNT ??
                                                                      0)) /
                                                              (_selectedTab == 0
                                                                  ? providerListener
                                                                      .contactsList
                                                                      .length
                                                                  : providerListener
                                                                      .sharedList
                                                                      .length) *
                                                              100.0)
                                                          .roundToDouble()
                                                          .toString() +
                                                      " %",
                                                  style: TextStyle(
                                                      fontSize: 15.0,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Color(
                                                          COLOR_PRIMARY))),
                                              new LinearPercentIndicator(
                                                width:
                                                    SizeConfig.screenWidth / 4,
                                                lineHeight: 5.0,
                                                percent: ((_selectedTab == 0
                                                        ? (providerListener
                                                                .contactsNEW_COUNT ??
                                                            0)
                                                        : (providerListener
                                                                .sharedNEW_COUNT ??
                                                            0)) /
                                                    (_selectedTab == 0
                                                        ? providerListener
                                                            .contactsList.length
                                                        : providerListener
                                                            .sharedList
                                                            .length)),
                                                backgroundColor: Colors.grey,
                                                progressColor:
                                                    Color(COLOR_PRIMARY),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    trailing: Icon(Icons.arrow_forward_ios),
                                  ),
                                ],
                              ),
                            ),
                          ),
                    (_selectedTab == 0
                                ? providerListener.contactsList.length
                                : providerListener.sharedList.length) ==
                            0
                        ? Container()
                        : InkWell(
                            onTap: () {
                              getLatestContacts("All");
                            },
                            child: Card(
                              color: _selectedTab == 0
                                  ? Color(COLOR_SECONDARY)
                                  : Colors.white70,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  ListTile(
                                    leading: Icon(Icons.all_inbox),
                                    title: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("All",
                                            style: TextStyle(
                                                fontSize: 19.0,
                                                fontWeight: FontWeight.w500,
                                                color: Color(COLOR_PRIMARY))),
                                        Container(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                  ((_selectedTab == 0
                                                                  ? (providerListener
                                                                          .contactsALL_COUNT ??
                                                                      0)
                                                                  : (providerListener
                                                                          .sharedALL_COUNT ??
                                                                      0)) /
                                                              (_selectedTab == 0
                                                                  ? providerListener
                                                                      .contactsList
                                                                      .length
                                                                  : providerListener
                                                                      .sharedList
                                                                      .length) *
                                                              100.0)
                                                          .roundToDouble()
                                                          .toString() +
                                                      " %",
                                                  style: TextStyle(
                                                      fontSize: 15.0,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Color(
                                                          COLOR_PRIMARY))),
                                              new LinearPercentIndicator(
                                                width:
                                                    SizeConfig.screenWidth / 4,
                                                lineHeight: 5.0,
                                                percent: ((_selectedTab == 0
                                                        ? (providerListener
                                                                .contactsALL_COUNT ??
                                                            0)
                                                        : (providerListener
                                                                .sharedALL_COUNT ??
                                                            0)) /
                                                    (_selectedTab == 0
                                                        ? providerListener
                                                            .contactsList.length
                                                        : providerListener
                                                            .sharedList
                                                            .length)),
                                                backgroundColor: Colors.grey,
                                                progressColor:
                                                    Color(COLOR_PRIMARY),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    //subtitle: Text('100'),
                                    trailing: Icon(Icons.arrow_forward_ios),
                                  ),
                                ],
                              ),
                            ),
                          ),
                    (_selectedTab == 0
                                ? providerListener.contactsList.length
                                : providerListener.sharedList.length) ==
                            0
                        ? Container(
                            child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Text("No Contacts yet!"),
                          ))
                        : InkWell(
                            onTap: () {
                              getLatestContacts("Client");
                            },
                            child: Card(
                              color: _selectedTab == 0
                                  ? Color(COLOR_SECONDARY)
                                  : Colors.white70,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  ListTile(
                                    leading: Icon(Icons.trending_up_sharp),
                                    title: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Client",
                                            style: TextStyle(
                                                fontSize: 19.0,
                                                fontWeight: FontWeight.w500,
                                                color: Color(COLOR_PRIMARY))),
                                        Container(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                  ((_selectedTab == 0
                                                                  ? (providerListener
                                                                          .contactsCLIENT_COUNT ??
                                                                      0)
                                                                  : (providerListener
                                                                          .sharedCLIENT_COUNT ??
                                                                      0)) /
                                                              (_selectedTab == 0
                                                                  ? providerListener
                                                                      .contactsList
                                                                      .length
                                                                  : providerListener
                                                                      .sharedList
                                                                      .length) *
                                                              100.0)
                                                          .roundToDouble()
                                                          .toString() +
                                                      " %",
                                                  style: TextStyle(
                                                      fontSize: 15.0,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Color(
                                                          COLOR_PRIMARY))),
                                              new LinearPercentIndicator(
                                                width:
                                                    SizeConfig.screenWidth / 4,
                                                lineHeight: 5.0,
                                                percent: ((_selectedTab == 0
                                                        ? (providerListener
                                                                .contactsCLIENT_COUNT ??
                                                            0)
                                                        : (providerListener
                                                                .sharedCLIENT_COUNT ??
                                                            0)) /
                                                    (_selectedTab == 0
                                                        ? providerListener
                                                            .contactsList.length
                                                        : providerListener
                                                            .sharedList
                                                            .length)),
                                                backgroundColor: Colors.grey,
                                                progressColor:
                                                    Color(COLOR_PRIMARY),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    // subtitle: Text('100'),
                                    trailing: Icon(Icons.arrow_forward_ios),
                                  ),
                                ],
                              ),
                            ),
                          ),
                    (_selectedTab == 0
                                ? providerListener.contactsList.length
                                : providerListener.sharedList.length) ==
                            0
                        ? Container()
                        : InkWell(
                            onTap: () {
                              getLatestContacts("Family");
                            },
                            child: Card(
                              color: _selectedTab == 0
                                  ? Color(COLOR_SECONDARY)
                                  : Colors.white70,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  ListTile(
                                    leading: Icon(Icons.family_restroom),
                                    title: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Family",
                                            style: TextStyle(
                                                fontSize: 19.0,
                                                fontWeight: FontWeight.w500,
                                                color: Color(COLOR_PRIMARY))),
                                        Container(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                  ((_selectedTab == 0
                                                                  ? (providerListener
                                                                          .contactsFAMILY_COUNT ??
                                                                      0)
                                                                  : (providerListener
                                                                          .sharedFAMILY_COUNT ??
                                                                      0)) /
                                                              (_selectedTab == 0
                                                                  ? providerListener
                                                                      .contactsList
                                                                      .length
                                                                  : providerListener
                                                                      .sharedList
                                                                      .length) *
                                                              100.0)
                                                          .roundToDouble()
                                                          .toString() +
                                                      " %",
                                                  style: TextStyle(
                                                      fontSize: 15.0,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Color(
                                                          COLOR_PRIMARY))),
                                              new LinearPercentIndicator(
                                                width:
                                                    SizeConfig.screenWidth / 4,
                                                lineHeight: 5.0,
                                                percent: ((_selectedTab == 0
                                                        ? (providerListener
                                                                .contactsFAMILY_COUNT ??
                                                            0)
                                                        : (providerListener
                                                                .sharedFAMILY_COUNT ??
                                                            0)) /
                                                    (_selectedTab == 0
                                                        ? providerListener
                                                            .contactsList.length
                                                        : providerListener
                                                            .sharedList
                                                            .length)),
                                                backgroundColor: Colors.grey,
                                                progressColor:
                                                    Color(COLOR_PRIMARY),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    // subtitle: Text('100'),
                                    trailing: Icon(Icons.arrow_forward_ios),
                                  ),
                                ],
                              ),
                            ),
                          ),
                    (_selectedTab == 0
                                ? providerListener.contactsList.length
                                : providerListener.sharedList.length) ==
                            0
                        ? Container()
                        : InkWell(
                            onTap: () {
                              getLatestContacts("Friend");
                            },
                            child: Card(
                              color: _selectedTab == 0
                                  ? Color(COLOR_SECONDARY)
                                  : Colors.white70,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  ListTile(
                                    leading: Icon(Icons.group),
                                    title: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Friend",
                                            style: TextStyle(
                                                fontSize: 19.0,
                                                fontWeight: FontWeight.w500,
                                                color: Color(COLOR_PRIMARY))),
                                        Container(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                  ((_selectedTab == 0
                                                                  ? (providerListener
                                                                          .contactsFRIEND_COUNT ??
                                                                      0)
                                                                  : (providerListener
                                                                          .sharedFRIEND_COUNT ??
                                                                      0)) /
                                                              (_selectedTab == 0
                                                                  ? providerListener
                                                                      .contactsList
                                                                      .length
                                                                  : providerListener
                                                                      .sharedList
                                                                      .length) *
                                                              100.0)
                                                          .roundToDouble()
                                                          .toString() +
                                                      " %",
                                                  style: TextStyle(
                                                      fontSize: 15.0,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Color(
                                                          COLOR_PRIMARY))),
                                              new LinearPercentIndicator(
                                                width:
                                                    SizeConfig.screenWidth / 4,
                                                lineHeight: 5.0,
                                                percent: ((_selectedTab == 0
                                                        ? (providerListener
                                                                .contactsFRIEND_COUNT ??
                                                            0)
                                                        : (providerListener
                                                                .sharedFRIEND_COUNT ??
                                                            0)) /
                                                    (_selectedTab == 0
                                                        ? providerListener
                                                            .contactsList.length
                                                        : providerListener
                                                            .sharedList
                                                            .length)),
                                                backgroundColor: Colors.grey,
                                                progressColor:
                                                    Color(COLOR_PRIMARY),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    // subtitle: Text('100'),
                                    trailing: Icon(Icons.arrow_forward_ios),
                                  ),
                                ],
                              ),
                            ),
                          ),
                    (_selectedTab == 0
                                ? providerListener.contactsList.length
                                : providerListener.sharedList.length) ==
                            0
                        ? Container()
                        : InkWell(
                            onTap: () {
                              getLatestContacts("Business");
                            },
                            child: Card(
                              color: _selectedTab == 0
                                  ? Color(COLOR_SECONDARY)
                                  : Colors.white70,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  ListTile(
                                    leading: Icon(Icons.business_sharp),
                                    title: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Bussiness",
                                            style: TextStyle(
                                                fontSize: 19.0,
                                                fontWeight: FontWeight.w500,
                                                color: Color(COLOR_PRIMARY))),
                                        Container(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                  ((_selectedTab == 0
                                                                  ? (providerListener
                                                                          .contactsBUSINESS_COUNT ??
                                                                      0)
                                                                  : (providerListener
                                                                          .sharedBUSINESS_COUNT ??
                                                                      0)) /
                                                              (_selectedTab == 0
                                                                  ? providerListener
                                                                      .contactsList
                                                                      .length
                                                                  : providerListener
                                                                      .sharedList
                                                                      .length) *
                                                              100.0)
                                                          .roundToDouble()
                                                          .toString() +
                                                      " %",
                                                  style: TextStyle(
                                                      fontSize: 15.0,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Color(
                                                          COLOR_PRIMARY))),
                                              new LinearPercentIndicator(
                                                width:
                                                    SizeConfig.screenWidth / 4,
                                                lineHeight: 5.0,
                                                percent: ((_selectedTab == 0
                                                        ? (providerListener
                                                                .contactsBUSINESS_COUNT ??
                                                            0)
                                                        : (providerListener
                                                                .sharedBUSINESS_COUNT ??
                                                            0)) /
                                                    (_selectedTab == 0
                                                        ? providerListener
                                                            .contactsList.length
                                                        : providerListener
                                                            .sharedList
                                                            .length)),
                                                backgroundColor: Colors.grey,
                                                progressColor:
                                                    Color(COLOR_PRIMARY),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    // subtitle: Text('100'),
                                    trailing: Icon(Icons.arrow_forward_ios),
                                  ),
                                ],
                              ),
                            ),
                          ),
                    (_selectedTab == 0
                                ? providerListener.contactsList.length
                                : providerListener.sharedList.length) ==
                            0
                        ? Container()
                        : InkWell(
                            onTap: () {
                              getLatestContacts("Vendor");
                            },
                            child: Card(
                              color: _selectedTab == 0
                                  ? Color(COLOR_SECONDARY)
                                  : Colors.white70,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  ListTile(
                                    leading: Icon(Icons.directions_walk),
                                    title: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Vendor",
                                            style: TextStyle(
                                                fontSize: 19.0,
                                                fontWeight: FontWeight.w500,
                                                color: Color(COLOR_PRIMARY))),
                                        Container(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                  ((_selectedTab == 0
                                                                  ? (providerListener
                                                                          .contactsVENDOR_COUNT ??
                                                                      0)
                                                                  : (providerListener
                                                                          .sharedVENDOR_COUNT ??
                                                                      0)) /
                                                              (_selectedTab == 0
                                                                  ? providerListener
                                                                      .contactsList
                                                                      .length
                                                                  : providerListener
                                                                      .sharedList
                                                                      .length) *
                                                              100.0)
                                                          .roundToDouble()
                                                          .toString() +
                                                      " %",
                                                  style: TextStyle(
                                                      fontSize: 15.0,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Color(
                                                          COLOR_PRIMARY))),
                                              new LinearPercentIndicator(
                                                width:
                                                    SizeConfig.screenWidth / 4,
                                                lineHeight: 5.0,
                                                percent: ((_selectedTab == 0
                                                        ? (providerListener
                                                                .contactsVENDOR_COUNT ??
                                                            0)
                                                        : (providerListener
                                                                .sharedVENDOR_COUNT ??
                                                            0)) /
                                                    (_selectedTab == 0
                                                        ? providerListener
                                                            .contactsList.length
                                                        : providerListener
                                                            .sharedList
                                                            .length)),
                                                backgroundColor: Colors.grey,
                                                progressColor:
                                                    Color(COLOR_PRIMARY),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    // subtitle: Text('100'),
                                    trailing: Icon(Icons.arrow_forward_ios),
                                  ),
                                ],
                              ),
                            ),
                          ),
                    (_selectedTab == 0
                                ? providerListener.contactsList.length
                                : providerListener.sharedList.length) ==
                            0
                        ? Container()
                        : InkWell(
                            onTap: () {
                              getLatestContacts("Other");
                            },
                            child: Card(
                              color: _selectedTab == 0
                                  ? Color(COLOR_SECONDARY)
                                  : Colors.white70,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  ListTile(
                                    leading: Icon(
                                      FlutterIcons.dots_horizontal_circle_mco,
                                    ),
                                    title: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Other",
                                            style: TextStyle(
                                                fontSize: 19.0,
                                                fontWeight: FontWeight.w500,
                                                color: Color(COLOR_PRIMARY))),
                                        Container(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                  ((_selectedTab == 0
                                                                  ? (providerListener
                                                                          .contactsOTHER_COUNT ??
                                                                      0)
                                                                  : (providerListener
                                                                          .sharedOTHER_COUNT ??
                                                                      0)) /
                                                              (_selectedTab == 0
                                                                  ? providerListener
                                                                      .contactsList
                                                                      .length
                                                                  : providerListener
                                                                      .sharedList
                                                                      .length) *
                                                              100.0)
                                                          .roundToDouble()
                                                          .toString() +
                                                      " %",
                                                  style: TextStyle(
                                                      fontSize: 15.0,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Color(
                                                          COLOR_PRIMARY))),
                                              new LinearPercentIndicator(
                                                width:
                                                    SizeConfig.screenWidth / 4,
                                                lineHeight: 5.0,
                                                percent: ((_selectedTab == 0
                                                        ? (providerListener
                                                                .contactsOTHER_COUNT ??
                                                            0)
                                                        : (providerListener
                                                                .sharedOTHER_COUNT ??
                                                            0)) /
                                                    (_selectedTab == 0
                                                        ? providerListener
                                                            .contactsList.length
                                                        : providerListener
                                                            .sharedList
                                                            .length)),
                                                backgroundColor: Colors.grey,
                                                progressColor:
                                                    Color(COLOR_PRIMARY),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    //subtitle: Text('100'),
                                    trailing: Icon(Icons.arrow_forward_ios),
                                  ),
                                ],
                              ),
                            ),
                          ),
                  ],
                ),
        ],
      ),
    );
  }
}
