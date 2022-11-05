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

class ViewComments extends StatefulWidget {
  final email;

  ViewComments(this.email);

  @override
  _ViewCommentsState createState() => _ViewCommentsState();
}

class _ViewCommentsState extends State<ViewComments> {
  bool _isloaded = false;
  bool _isSearchBarOpen = false;
  TextEditingController searchTextController = new TextEditingController();

  FocusNode focusSearch = FocusNode();

  void _launchURL(String _url) async {
    await canLaunch(_url) ? await launch(_url) : throw 'Could not launch $_url';
  }

  Future getComments() async {
    setState(() {
      _isloaded = false;
    });
    Provider.of<CustomViewModel>(context, listen: false)
        .getComments(widget.email)
        .then((value) {
      setState(() {
        if (value == "success") {
          setState(() {
            _isloaded = true;
          });
        } else {}
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getComments();
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
                      commonTitle(context, "Comments"),
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
        child: providerListener.commentsList.length > 0
            ? ListView.builder(
                itemCount: providerListener.commentsList.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      color: Color(COLOR_SECONDARY),
                      elevation: 5,
                      child: Stack(
                        children: [
                          Column(
                            children: <Widget>[
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: Container(
                                      width: SizeConfig.screenWidth - 80,
                                      child: Text(
                                          providerListener.commentsList[index]
                                                  .description ??
                                              "",
                                          textAlign: TextAlign.start,
                                          style: GoogleFonts.poppins(
                                              textStyle: TextStyle(
                                                  fontSize: 14.0,
                                                  color: Colors.black87))),
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    InkWell(
                                      onTap: () {},
                                      child: Center(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            providerListener.commentsList[index]
                                                    .createdAt ??
                                                "",
                                            style: TextStyle(
                                                color: Colors.black87,
                                                fontSize: 15,
                                                fontWeight: FontWeight.w600),
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
                })
            : Container(
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
