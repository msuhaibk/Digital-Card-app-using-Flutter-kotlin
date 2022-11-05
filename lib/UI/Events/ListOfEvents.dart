import 'package:animated_radio_buttons/animated_radio_buttons.dart';
import 'package:chips_choice/chips_choice.dart';
import 'package:date_time_picker/date_time_picker.dart';
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

class ListOfEvents extends StatefulWidget {
  @override
  _ListOfEventsState createState() => _ListOfEventsState();
}

class _ListOfEventsState extends State<ListOfEvents> {
  bool _isloaded = false;
  bool _isSearchBarOpen = false;
  TextEditingController searchTextController = new TextEditingController();

  FocusNode focusSearch = FocusNode();

  void _launchURL(String _url) async {
    await canLaunch(_url) ? await launch(_url) : throw 'Could not launch $_url';
  }

  Future getEvents() async {
    setState(() {
      _isloaded = false;
    });

    Provider.of<CustomViewModel>(context, listen: false)
        .getEvents()
        .then((value) {
      setState(() {
        if (value == "success") {
          setState(() {
            _isloaded = true;
          });
        } else {
          // commonToast(context, value);
        }
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getEvents();
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
                      commonTitle(context, "Events"),
                    ],
                  ),
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          _launchURL(apiUrl +
                              "/../create_event.php?user_id=" +
                              providerListener.userData.id);
                        },
                        child: Row(
                          children: [
                            SizedBox(width: 15),
                            Icon(
                              Icons.add,
                              color: Colors.black87,
                            ),
                            SizedBox(width: 10),
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          getEvents();
                        },
                        child: Row(
                          children: [
                            SizedBox(width: 15),
                            Icon(
                              Icons.refresh,
                              color: Colors.black87,
                            ),
                            SizedBox(width: 10),
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
      body: Container(
        width: double.infinity,
        child: providerListener.eventsList.length > 0
            ? ListView.builder(
                itemCount: providerListener.eventsList.length,
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
                                    left: 10, right: 0, top: 15, bottom: 15),
                                child: Card(
                                  color: Color(COLOR_SECONDARY),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(50),
                                          bottomRight: Radius.circular(50))),
                                  elevation: 2,
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
                                        commonTitleSmallBold(
                                            context,
                                            providerListener
                                                    .eventsList[index].title ??
                                                ""),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 20, right: 20),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
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
                                              providerListener.eventsList[index]
                                                      .venue ??
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
                                                          .eventsList[index]
                                                          .updatedAt ??
                                                      "")
                                                  .replaceAll(" ", ", ")
                                                  .replaceAll("T", ", ")),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20.0,
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        _launchURL(apiUrl +
                                            "/../../event.php?id=" +
                                            providerListener
                                                .eventsList[index].id);
                                      },
                                      child: Icon(
                                        Icons.remove_red_eye,
                                        color: Colors.white,
                                        size: 30,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        _launchURL(apiUrl +
                                            "/../create_event.php?action=edit&user_id=" +
                                            providerListener
                                                .eventsList[index].userId +
                                            "&" +
                                            "id=" +
                                            providerListener
                                                .eventsList[index].id);
                                      },
                                      child: Icon(
                                        Icons.edit,
                                        color: Colors.white,
                                        size: 30,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Provider.of<CustomViewModel>(context,
                                                listen: false)
                                            .DeleteEvent(providerListener
                                                .eventsList[index].id)
                                            .then((value) {
                                          commonToast(context, value);
                                          getEvents();
                                        });
                                      },
                                      child: Icon(
                                        Icons.delete,
                                        color: Colors.white,
                                        size: 40,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    InkWell(
                                      onTap: () {



                                        _launchURL(apiUrl +
                                            "/../share_event.php?id="+(providerListener.eventsList[index].id??"")+"&title="+(providerListener.eventsList[index].title??"")+"&schedued_at="+(providerListener.eventsList[index].updatedAt??"")+"&organizer="+(providerListener.eventsList[index].organizer??"")+"&email="+(providerListener.eventsList[index].email??"")+"&user_id=" +
                                            providerListener
                                                .eventsList[index].userId);
                                      },
                                      child: Icon(
                                        Icons.share,
                                        color: Colors.white,
                                        size: 30,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ));
                })
            : Container(
                height: 200,
                margin: EdgeInsets.only(bottom: 0),
                child:
                    Center(child: commonTitle(context, "No results Found!"))),
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
