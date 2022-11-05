import 'dart:async';

import 'package:fliqcard/Helpers/constants.dart';
import 'package:fliqcard/Helpers/helper.dart';
import 'package:fliqcard/UI/Staff/AddEditStaff.dart';
import 'package:fliqcard/View%20Models/CustomViewModel.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';

void _launchURL(String _url) async {
  await canLaunch(_url) ? await launch(_url) : throw 'Could not launch $_url';
}

class TempReceivedCards extends StatefulWidget {
  @override
  _TempReceivedCardsState createState() => _TempReceivedCardsState();
}

class _TempReceivedCardsState extends State<TempReceivedCards> {
  bool _enabled = true;

  Timer _timer;
  int _start = 40;

  void startTimer() {
    const oneSec = const Duration(seconds: 10);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        print("startTimer");
        if (_start == 0) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            _start = _start - 10;
            GetSharedCards();
          });
        }
      },
    );
  }

  Future GetSharedCards() {
    Provider.of<CustomViewModel>(context, listen: false)
        .GetSharedCards()
        .then((value) {
      setState(() {
        setState(() {
          _enabled = false;
        });
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startTimer();
    GetSharedCards();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final providerListener = Provider.of<CustomViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(COLOR_BACKGROUND),
        title: commonTitle(context, "Received Cards"),
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
            : providerListener.tempsharedcardsList.length > 0
                ? ListView.builder(
                    itemCount: providerListener.tempsharedcardsList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        color: Color(COLOR_SECONDARY),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            ListTile(
                              trailing: Text((providerListener
                                      .tempsharedcardsList[index].created_at ??
                                  "")),
                              title: Text(
                                  providerListener
                                          .tempsharedcardsList[index].name ??
                                      "",
                                  style: TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.w500,
                                      color: Color(COLOR_TITLE))),
                              subtitle: Text((providerListener
                                      .tempsharedcardsList[index].email ??
                                  "")),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                InkWell(
                                  onTap: () {
                                    Provider.of<CustomViewModel>(context,
                                            listen: false)
                                        .UpdateStatus(
                                            2,
                                            providerListener
                                                .tempsharedcardsList[index]
                                                .myId)
                                        .then((value) {
                                      setState(() {
                                        Provider.of<CustomViewModel>(context,
                                                listen: false)
                                            .GetSharedCards()
                                            .then((value) => _enabled = false);
                                        pop(context);
                                      });
                                    });
                                  },
                                  child: Padding(
                                      padding: EdgeInsets.all(10),
                                      child: commonTitleSmallBold(
                                          context, "Discard")),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                InkWell(
                                  onTap: () {
                                    _launchURL(apiUrl +
                                        "/../visitcard.php?id=" +
                                        providerListener
                                            .tempsharedcardsList[index].myId);
                                    Provider.of<CustomViewModel>(context,
                                            listen: false)
                                        .UpdateStatus(
                                            1,
                                            providerListener
                                                .tempsharedcardsList[index]
                                                .myId)
                                        .then((value) {
                                      setState(() {
                                        Provider.of<CustomViewModel>(context,
                                                listen: false)
                                            .GetSharedCards()
                                            .then((value) => _enabled = false);
                                        pop(context);
                                      });
                                    });
                                  },
                                  child: Padding(
                                      padding: EdgeInsets.all(10),
                                      child: commonTitleSmallBold(
                                          context, "Accept & Visit")),
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
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: commonTitleSmallBold(context,
                              "Shared FliQCards from Nearby users will be listed here!"),
                        ),
                        commonTitle(context, "Receiving..."),
                        SizedBox(
                          height: 1,
                        )
                      ],
                    ))),
      ),
    );
  }
}
