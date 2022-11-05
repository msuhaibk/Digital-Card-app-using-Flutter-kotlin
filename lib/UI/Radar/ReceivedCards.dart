import 'package:fliqcard/Helpers/constants.dart';
import 'package:fliqcard/Helpers/helper.dart';
import 'package:fliqcard/UI/Staff/AddEditStaff.dart';
import 'package:fliqcard/View%20Models/CustomViewModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';

void _launchURL(String _url) async {
  await canLaunch(_url) ? await launch(_url) : throw 'Could not launch $_url';
}

class ReceivedCards extends StatefulWidget {
  @override
  _ReceivedCardsState createState() => _ReceivedCardsState();
}

class _ReceivedCardsState extends State<ReceivedCards> {
  bool _enabled = true;

  Future GetDistinctSharedCards() {
    Provider.of<CustomViewModel>(context, listen: false)
        .GetDistinctSharedCards()
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
    GetDistinctSharedCards();
  }

  @override
  Widget build(BuildContext context) {

    final providerListener = Provider.of<CustomViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(COLOR_BACKGROUND),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [

            commonTitle(context, "Radar FliQ"),
          ],
        ),
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
            : providerListener.sharedcardsList.length > 0
                ? ListView.builder(
                    itemCount: providerListener.sharedcardsList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        color: Color(COLOR_SECONDARY),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            ListTile(
                              trailing: Text((providerListener
                                      .sharedcardsList[index].created_at ??
                                  "")),
                              title: Text(
                                  providerListener
                                          .sharedcardsList[index].name ??
                                      "",
                                  style: TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.w500,
                                      color: Color(COLOR_TITLE))),
                              subtitle: Text(providerListener
                                      .sharedcardsList[index].email ??
                                  ""),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                InkWell(
                                  onTap: () {
                                    _launchURL(apiUrl +
                                        "/../visitcard.php?id=" +
                                        providerListener
                                            .sharedcardsList[index].myId);
                                  },
                                  child: Padding(
                                      padding: EdgeInsets.all(10),
                                      child: commonTitleSmallBold(
                                          context, "View FliQCard")),
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
