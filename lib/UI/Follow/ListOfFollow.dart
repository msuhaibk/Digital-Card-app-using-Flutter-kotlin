import 'package:animated_radio_buttons/animated_radio_buttons.dart';
import 'package:chips_choice/chips_choice.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:expandable/expandable.dart';
import 'package:fliqcard/Helpers/constants.dart';
import 'package:fliqcard/Helpers/helper.dart';
import 'package:fliqcard/Helpers/size_config.dart';
import 'package:fliqcard/UI/Contacts/UpdateContactScreen.dart';
import 'package:fliqcard/View%20Models/CustomViewModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';

import 'ViewComments.dart';

class ListOfFollow extends StatefulWidget {
  @override
  _ListOfFollowState createState() => _ListOfFollowState();
}

class _ListOfFollowState extends State<ListOfFollow> {
  var created = "";
  bool _isloaded = false;
  bool _isSearchBarOpen = false;
  TextEditingController searchTextController = new TextEditingController();

  FocusNode focusSearch = FocusNode();
  int _selectedTab = 0;

  void _launchURL(String _url) async {
    await canLaunch(_url) ? await launch(_url) : throw 'Could not launch $_url';
  }

  Future getFollowup() async {
    setState(() {
      _isloaded = false;
    });

    Provider.of<CustomViewModel>(context, listen: false)
        .getFollowup(_selectedTab == 0 ? "pending" : "complete")
        .then((value) {
      setState(() {
        if (value == "success") {
          setState(() {
            _isloaded = true;
          });
        } else {
          //commonToast(context, value);
        }
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getFollowup();
  }

  @override
  Widget build(BuildContext context) {
    final providerListener = Provider.of<CustomViewModel>(context);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 15),
          child: Padding(
            padding: EdgeInsets.only(left: 20, right: 20, top: 20),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          pop(context);
                        },
                        child: Container(
                          padding: EdgeInsets.all(2),
                          child: Icon(
                            Icons.arrow_back_ios,
                            size: 20,
                            color: Color(COLOR_PRIMARY),
                          ),
                        ),
                      ),
                      commonTitle(context, " Follow Up"),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: Container(
        width: double.infinity,
        child: Column(
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
                          label: "Pending",
                          color: Color(COLOR_PRIMARY),
                          fillInColor: Color(COLOR_SECONDARY)),
                      AnimatedRadioButtonItem(
                          label: "Complete",
                          color: Color(COLOR_PRIMARY),
                          fillInColor: Colors.white70),
                    ],
                    onChanged: (value) {
                      setState(() {
                        print(value);
                        _selectedTab = value;
                        getFollowup();
                      });
                    },
                  ),
                ],
              ),
            ),
            providerListener.followupList.length > 0
                ? Container(
                    height: SizeConfig.screenHeight - 150,
                    child: ListView.builder(
                        itemCount: providerListener.followupList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              color: Color(COLOR_PRIMARY),
                              child: Stack(
                                children: [
                                  Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Container(
                                        padding: EdgeInsets.only(
                                            left: 10,
                                            right: 0,
                                            top: 15,
                                            bottom: 15),
                                        child: Container(
                                          margin: EdgeInsets.only(
                                              left: 10, bottom: 10, top: 10),
                                          width: SizeConfig.screenWidth,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              commonTitleBigBoldWhite(
                                                  context,
                                                  providerListener
                                                          .followupList[index]
                                                          .name ??
                                                      ""),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: 20, right: 20, bottom: 20),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                _launchURL("tel:" +
                                                        providerListener
                                                            .followupList[index]
                                                            .phone ??
                                                    "");
                                              },
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Icon(
                                                    Icons.circle,
                                                    color: Colors.white,
                                                    size: 14,
                                                  ),
                                                  SizedBox(
                                                    width: 20.0,
                                                  ),
                                                  commonTitleSmallWhite(
                                                      context,
                                                      providerListener
                                                              .followupList[
                                                                  index]
                                                              .phone ??
                                                          ""),
                                                ],
                                              ),
                                            ),
                                            InkWell(
                                              onTap: () {
                                                _launchURL("mailto:" +
                                                        providerListener
                                                            .followupList[index]
                                                            .email ??
                                                    "");
                                              },
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Icon(
                                                    Icons.circle,
                                                    color: Colors.white,
                                                    size: 14,
                                                  ),
                                                  SizedBox(
                                                    width: 20.0,
                                                  ),
                                                  commonTitleSmallWhite(
                                                      context,
                                                      providerListener
                                                              .followupList[
                                                                  index]
                                                              .email ??
                                                          ""),
                                                ],
                                              ),
                                            ),
                                            InkWell(
                                              onTap: () {},
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Icon(
                                                    Icons.circle,
                                                    color: Colors.white,
                                                    size: 14,
                                                  ),
                                                  SizedBox(
                                                    width: 20.0,
                                                  ),
                                                  commonTitleSmallWhite(
                                                      context,
                                                      (providerListener
                                                                  .followupList[
                                                                      index]
                                                                  .createdAt ??
                                                              "")
                                                          .replaceAll(
                                                              "T", ", ")),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: 20.0,
                                            ),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                commonTitleSmallWhite(
                                                    context,
                                                    providerListener
                                                            .followupList[index]
                                                            .about ??
                                                        ""),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      Divider(
                                        color: Colors.grey.shade700,
                                        thickness: 3,
                                      ),
                                      ExpandableNotifier(
                                        // <-- Provides ExpandableController to its children
                                        child: Expandable(
                                          // <-- Driven by ExpandableController from ExpandableNotifier
                                          collapsed: ExpandableButton(
                                            // <-- Expands when tapped on the cover photo
                                            child: Row(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 20,
                                                          right: 10,
                                                          top: 20),
                                                  child: Container(
                                                      width: SizeConfig
                                                              .screenWidth -
                                                          100,
                                                      child: commonTitleSmallWhite(
                                                          context,
                                                          "To reschedule followup select date, time and submit")),
                                                ),
                                                Icon(
                                                  Icons.arrow_drop_down,
                                                  color: Colors.white,
                                                )
                                              ],
                                            ),
                                          ),
                                          expanded: Column(children: [
                                            Row(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 20,
                                                          right: 10,
                                                          top: 20),
                                                  child: Container(
                                                      width: SizeConfig
                                                              .screenWidth -
                                                          100,
                                                      child: commonTitleSmallWhite(
                                                          context,
                                                          "To reschedule followup select date, time and submit")),
                                                ),
                                                ExpandableButton(
                                                    // <-- Collapses when tapped on
                                                    child: Icon(
                                                  Icons.arrow_drop_up,
                                                  color: Colors.white,
                                                )),
                                              ],
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                left: 10,
                                                top: 20,
                                              ),
                                              child: InkWell(
                                                onTap: () {},
                                                child: Row(
                                                  children: [
                                                    Container(
                                                      width: SizeConfig
                                                              .screenWidth -
                                                          140,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    3)),
                                                        color: Color(
                                                            COLOR_SECONDARY),
                                                      ),
                                                      child: DateTimePicker(
                                                        type: DateTimePickerType
                                                            .dateTimeSeparate,
                                                        dateMask: 'd MMM, yyyy',
                                                        initialValue:
                                                            DateTime.now()
                                                                .toString(),
                                                        firstDate:
                                                            DateTime(2021),
                                                        lastDate:
                                                            DateTime(2500),
                                                        icon: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Icon(
                                                            Icons.event,
                                                            color: Colors.black,
                                                          ),
                                                        ),
                                                        dateLabelText: 'Date',
                                                        timeLabelText: "Hour",
                                                        selectableDayPredicate:
                                                            (date) {
                                                          return true;
                                                        },
                                                        onChanged: (val) {
                                                          print(val);
                                                          print(val.replaceAll(
                                                              " ", "T"));
                                                          created =
                                                              val.replaceAll(
                                                                  " ", "T");
                                                        },
                                                        validator: (val) {
                                                          print(val);

                                                          return null;
                                                        },
                                                        onSaved: (val) =>
                                                            print(val),
                                                      ), /*Center(
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets.all(
                                                                  8.0),
                                                          child: Text(
                                                            "Reschedule",
                                                            style: TextStyle(
                                                                color: Colors.black87,
                                                                fontSize: 15),
                                                          ),
                                                        ),
                                                      ),*/
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: InkWell(
                                                        onTap: () {
                                                          if (created != "") {
                                                            Provider.of<CustomViewModel>(
                                                                    context,
                                                                    listen:
                                                                        false)
                                                                .RescheduleFollowup(
                                                                    providerListener
                                                                        .followupList[
                                                                            index]
                                                                        .id,
                                                                    providerListener
                                                                        .followupList[
                                                                            index]
                                                                        .userId,
                                                                    created)
                                                                .then((value) {
                                                              setState(() {
                                                                created = "";
                                                              });
                                                              commonToast(
                                                                  context,
                                                                  value);
                                                              getFollowup();
                                                            });
                                                          } else {
                                                            commonToast(context,
                                                                "To reschedule followup select date, time and submit");
                                                          }
                                                        },
                                                        child: Container(
                                                          width: 100,
                                                          height: 60,
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            3)),
                                                            color: Color(
                                                                COLOR_SECONDARY),
                                                          ),
                                                          child: Center(
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: Text(
                                                                "Reschedule",
                                                                style: TextStyle(
                                                                    color: Color(
                                                                        COLOR_PRIMARY),
                                                                    fontSize:
                                                                        13,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ]),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(20.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                push(
                                                    context,
                                                    ViewComments(
                                                        providerListener
                                                            .followupList[index]
                                                            .email));
                                              },
                                              child: Icon(
                                                Icons.remove_red_eye,
                                                color: Colors.white,
                                                size: 40,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 20,
                                            ),
                                            _selectedTab != 0
                                                ? Container(
                                                    height: 0,
                                                  )
                                                : InkWell(
                                                    onTap: () {
                                                      Provider.of<CustomViewModel>(
                                                              context,
                                                              listen: false)
                                                          .CompleteFollowup(
                                                              providerListener
                                                                  .followupList[
                                                                      index]
                                                                  .id)
                                                          .then((value) {
                                                        commonToast(
                                                            context, value);
                                                        getFollowup();
                                                      });
                                                    },
                                                    child: Container(
                                                      width: 80,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    15)),
                                                        color: Colors.green,
                                                      ),
                                                      child: Center(
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Text(
                                                            "Done",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 15),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                            _selectedTab != 0
                                                ? Container(
                                                    height: 0,
                                                  )
                                                : SizedBox(
                                                    width: 20,
                                                  ),
                                            _selectedTab != 0
                                                ? Container(
                                                    height: 0,
                                                  )
                                                : InkWell(
                                                    onTap: () {
                                                      Provider.of<CustomViewModel>(
                                                              context,
                                                              listen: false)
                                                          .CancelFollowup(
                                                              providerListener
                                                                  .followupList[
                                                                      index]
                                                                  .id)
                                                          .then((value) {
                                                        commonToast(
                                                            context, value);
                                                        getFollowup();
                                                      });
                                                    },
                                                    child: Container(
                                                      width: 80,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    15)),
                                                        color: Colors.red,
                                                      ),
                                                      child: Center(
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Text(
                                                            "Delete",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 15),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ));
                        }),
                  )
                : Container(
                    height: 200,
                    margin: EdgeInsets.only(bottom: 0),
                    child: Center(
                        child: commonTitle(context, "No results Found!"))),
          ],
        ),
      ),
    );
  }
}

class MyBullet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Container(
      height: 10.0,
      width: 10.0,
      decoration: new BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
    );
  }
}
