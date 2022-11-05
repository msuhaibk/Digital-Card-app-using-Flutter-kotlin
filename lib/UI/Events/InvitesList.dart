import 'package:chips_choice/chips_choice.dart';
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

class InvitesList extends StatefulWidget {
  @override
  _InvitesListState createState() => _InvitesListState();
}

class _InvitesListState extends State<InvitesList> {
  TextEditingController searchTextController = new TextEditingController();

  FocusNode focusSearch = FocusNode();

  void _launchURL(String _url) async {
    await canLaunch(_url) ? await launch(_url) : throw 'Could not launch $_url';
  }

  Future getInvites() async {
    Provider.of<CustomViewModel>(context, listen: false)
        .getInvites()
        .then((value) {});
  }

  @override
  void initState() {
    super.initState();
    getInvites();
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
                      commonTitle(context, "Upcoming events"),
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
        child: providerListener.invitesList.length > 0
            ? ListView.builder(
                itemCount: providerListener.invitesList.length,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () {
                      _launchURL(
                          "https://fliqcard.com/digitalcard/event.php?id=" +
                              providerListener.invitesList[index].eventId);
                    },
                    child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        color: Colors.white,
                        elevation: 5,
                        child: Stack(
                          children: [
                            Column(
                              children: <Widget>[
                                Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(20.0),
                                      child: Container(
                                        width: SizeConfig.screenWidth - 80,
                                        child: Text(
                                            providerListener.invitesList[index]
                                                    .organizer ??
                                                "",
                                            textAlign: TextAlign.start,
                                            style: GoogleFonts.poppins(
                                                textStyle: TextStyle(
                                                    fontSize: 14.0,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black87))),
                                      ),
                                    ),
                                    Container(
                                      width: SizeConfig.screenWidth - 80,
                                      child: Text(
                                          ("Invited you for " +
                                                      providerListener
                                                          .invitesList[index]
                                                          .title ??
                                                  "") +
                                              "\n\n\nScheduled on ",
                                          textAlign: TextAlign.start,
                                          style: GoogleFonts.poppins(
                                              textStyle: TextStyle(
                                                  fontSize: 14.0,
                                                  color: Colors.black87))),
                                    ),
                                    Container(
                                      width: SizeConfig.screenWidth - 80,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                              providerListener
                                                      .invitesList[index]
                                                      .scheduedAt ??
                                                  "",
                                              textAlign: TextAlign.start,
                                              style: GoogleFonts.poppins(
                                                  textStyle: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 14.0,
                                                      color: Colors.black87))),
                                          Text("View",
                                              textAlign: TextAlign.start,
                                              style: GoogleFonts.poppins(
                                                  textStyle: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 18.0,
                                                      color: Colors.red))),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                              ],
                            ),
                          ],
                        )),
                  );
                })
            : Container(
                margin: EdgeInsets.only(bottom: 0),
                child:
                    Center(child: commonTitle(context, "No results Found!"))),
      ),
    );
  }
}
