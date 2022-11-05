import 'package:fliqcard/Helpers/constants.dart';
import 'package:fliqcard/Helpers/helper.dart';
import 'package:fliqcard/UI/Staff/AddEditStaff.dart';
import 'package:fliqcard/View%20Models/CustomViewModel.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../CardListingStaff.dart';

class TeamListScreen extends StatefulWidget {
  @override
  _TeamListScreenState createState() => _TeamListScreenState();
}

class _TeamListScreenState extends State<TeamListScreen> {
  bool _enabled = true;

  void _launchURL(String _url) async {
    await canLaunch(_url) ? await launch(_url) : throw 'Could not launch $_url';
  }

  Future initTask() {
    Future.delayed(const Duration(seconds: 1), () async {
      setState(() {
        _enabled = false;
      });
    });
  }

  Future DeletStaff(String id) {
    Provider.of<CustomViewModel>(context, listen: false)
        .DeletStaff(id)
        .then((value) {
      setState(() {
        setState(() {
          _enabled = false;
        });
        if (value == "success") {
          commonToast(context, value);
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

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(COLOR_BACKGROUND),
        title: commonTitle(context, "Team List"),
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
        actions: [
          InkWell(
            onTap: () {
              push(context, AddEditStaff("0", "", "", "", ""));
            },
            child: providerListener.userData.isStaff != "1"
                ? Row(
                    children: [
                      SizedBox(width: 15),
                      Icon(
                        Icons.add,
                        color: Colors.black87,
                      ),
                      SizedBox(width: 10),
                      commonTitleSmallBold(context, 'Add Staff'),
                      SizedBox(width: 10),
                    ],
                  )
                : Container(),
          )
        ],
      ),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
        child: _enabled == true
            ? Column(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Expanded(
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
                  )
                ],
              )
            : providerListener.teamList.length > 0
                ? ListView.builder(
                    itemCount: providerListener.teamList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        color: Color(0xaaa6d5ed),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            ListTile(
                              title: Text(
                                  providerListener.teamList[index].fullname ??
                                      "",
                                  style: TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.w500,
                                      color: Color(COLOR_TITLE))),
                              subtitle: Text(
                                  (providerListener.teamList[index].email ??
                                          "") +
                                      "\n" +
                                      (providerListener
                                              .teamList[index].department ??
                                          "")),
                              trailing: providerListener
                                              .teamList[index].updatedAt !=
                                          "" &&
                                      providerListener
                                              .teamList[index].updatedAt !=
                                          null
                                  ? DateTime.now()
                                              .difference(DateTime.parse(
                                                  providerListener
                                                      .teamList[index]
                                                      .updatedAt))
                                              .inDays <
                                          7
                                      ? Container(
                                          padding: EdgeInsets.all(5),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(5)),
                                            color: Colors.red,
                                          ),
                                          child: Text(
                                            providerListener
                                                .teamList[index].updatedAt,
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        )
                                      : Text("")
                                  : Text(""),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                providerListener.userData.isStaff == "0"
                                    ? InkWell(
                                        onTap: () {
                                          push(
                                              context,
                                              AddEditStaff(
                                                  providerListener
                                                      .teamList[index].id
                                                      .toString(),
                                                  providerListener
                                                      .teamList[index].fullname
                                                      .toString(),
                                                  providerListener
                                                          .teamList[index]
                                                          .department ??
                                                      "",
                                                  providerListener
                                                          .teamList[index]
                                                          .phone ??
                                                      "",
                                                  providerListener
                                                          .teamList[index]
                                                          .email ??
                                                      ""));
                                        },
                                        child: Padding(
                                          padding: EdgeInsets.all(10),
                                          child: Icon(
                                            Icons.edit_outlined,
                                          ),
                                        ),
                                      )
                                    : SizedBox(
                                        height: 1,
                                      ),
                                providerListener.userData.isStaff == "0"
                                    ? InkWell(
                                        onTap: () {
                                          setState(() {
                                            _enabled = true;
                                          });
                                          DeletStaff(providerListener
                                              .teamList[index].id);
                                        },
                                        child: Padding(
                                          padding: EdgeInsets.all(10),
                                          child: Icon(
                                            Icons.delete_outline,
                                          ),
                                        ),
                                      )
                                    : SizedBox(
                                        height: 1,
                                      ),
                                InkWell(
                                  onTap: () {
                                    _launchURL(
                                        "https://fliqcard.com/digitalcard/dashboard/visitcard.php?id=" +
                                            (providerListener
                                                    .teamList[index].id ??
                                                ""));
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.all(10),
                                    child: Icon(
                                      Icons.remove_red_eye_outlined,
                                    ),
                                  ),
                                ),
                                providerListener.userData.isStaff == "1"
                                    ? InkWell(
                                        onTap: () {
                                          var now = new DateTime.now();
                                          var formatter =
                                              new DateFormat('yyyy-MM-dd');
                                          String formattedDate =
                                              formatter.format(now);

                                          _launchURL((apiUrl +
                                              "/../attendance.php?start_at=" +
                                              formattedDate +
                                              "&end_at=" +
                                              formattedDate +
                                              "&user_id=" +
                                              (providerListener
                                                      .teamList[index].id ??
                                                  "") +
                                              "&staff_name=" +
                                              (providerListener.teamList[index]
                                                      .fullname ??
                                                  "") +
                                              "&isfromapp=yes"));
                                        },
                                        child: Padding(
                                          padding: EdgeInsets.all(10),
                                          child: Icon(
                                            Icons.calendar_today,
                                            color: Color(COLOR_PRIMARY),
                                          ),
                                        ),
                                      )
                                    : SizedBox(
                                        height: 1,
                                      ),
                                InkWell(
                                  onTap: () {
                                    push(
                                        context,
                                        CardListingStaff(providerListener
                                            .teamList[index].id));
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.all(10),
                                    child: Icon(
                                      Icons.credit_card_sharp,
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      );
                    })
                : Container(
                    margin: EdgeInsets.only(bottom: 0),
                    child: Center(
                        child: commonTitle(context, "No results Found!"))),
      ),
    );
  }
}
