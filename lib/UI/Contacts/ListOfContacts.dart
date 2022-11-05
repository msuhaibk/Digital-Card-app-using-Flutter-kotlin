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

class ListOfContacts extends StatefulWidget {
  final category_name;

  ListOfContacts(this.category_name);

  @override
  _ListOfContactsState createState() => _ListOfContactsState();
}

class _ListOfContactsState extends State<ListOfContacts> {
  var created = "";
  bool _isloaded = false;
  bool _isSearchBarOpen = false;
  TextEditingController searchTextController = new TextEditingController();

  FocusNode focusSearch = FocusNode();

  void _launchURL(String _url) async {
    await canLaunch(_url) ? await launch(_url) : throw 'Could not launch $_url';
  }

  Future getFilterContacts() async {
    if (widget.category_name == "All") {
      Provider.of<CustomViewModel>(context, listen: false)
          .getAllContacts()
          .then((value) {
        setState(() {
          if (value == "success") {
            setState(() {
              _isloaded = true;
            });
          } else {
            commonToast(context, value);
          }
        });
      });
    } else {
      Provider.of<CustomViewModel>(context, listen: false)
          .getFilterContacts(widget.category_name, "")
          .then((value) {
        setState(() {
          if (value == "success") {
            setState(() {
              _isloaded = true;
            });
          } else {
            commonToast(context, value);
          }
        });
      });
    }
  }

  Future<void> getSearchedContacts() async {
    setState(() {
      _isloaded = false;
    });

    Provider.of<CustomViewModel>(context, listen: false)
        .getFilterContacts(
            widget.category_name, searchTextController.text.toLowerCase())
        .then((value) {
      setState(() {
        if (value == "success") {
          setState(() {
            _isloaded = true;
          });
        } else {
          commonToast(context, value);
        }
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getFilterContacts();
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
            child: _isSearchBarOpen == false
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            InkWell(
                              onTap: () {
                                if (_isSearchBarOpen == true) {
                                  setState(() {
                                    _isSearchBarOpen = false;
                                    searchTextController.clear();
                                  });
                                  getSearchedContacts();
                                } else {
                                  pop(context);
                                }
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
                            commonTitle(
                                context, widget.category_name + " contacts"),
                          ],
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              _isSearchBarOpen = true;
                              focusSearch.requestFocus();
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.all(2),
                            child: Icon(
                              Icons.search,
                              color: Color(COLOR_PRIMARY),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                : Column(
                    children: [
                      Container(
                        child: TextField(
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.done,
                          focusNode: focusSearch,
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                              fontSize: 14),
                          decoration: InputDecoration(
                            hintText: "Search in " + widget.category_name,
                            filled: true,
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: const BorderRadius.all(
                                const Radius.circular(10.0),
                              ),
                            ),
                            fillColor: Colors.grey.shade100,
                            prefixIcon: InkWell(
                              onTap: () {
                                if (_isSearchBarOpen == true) {
                                  setState(() {
                                    _isSearchBarOpen = false;
                                    searchTextController.clear();
                                  });
                                  getSearchedContacts();
                                } else {
                                  pop(context);
                                }
                              },
                              child: Icon(
                                Icons.arrow_back,
                                color: Colors.grey,
                                size: 30,
                              ),
                            ),
                            suffixIconConstraints:
                                BoxConstraints.tightFor(height: 50),
                            suffixIcon: GestureDetector(
                              onTap: () {
                                setState(() {
                                  searchTextController.clear();
                                });
                                getSearchedContacts();
                              },
                              child: Padding(
                                  padding: EdgeInsetsDirectional.only(end: 10),
                                  child: Icon(
                                    Icons.clear,
                                    size: 30,
                                  )),
                            ),
                          ),
                          onEditingComplete: () {
                            getSearchedContacts();
                            focusSearch.unfocus();
                          },
                          controller: searchTextController,
                        ),
                      )
                    ],
                  ),
          ),
        ),
      ),
      body: Container(
        width: double.infinity,
        child: providerListener.FilterContactsList.length > 0
            ? ListView.builder(
                itemCount: providerListener.FilterContactsList.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
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
                                      left: 10, right: 80, top: 15, bottom: 15),
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
                                          commonTitleBigBoldWhite(
                                              context,
                                              providerListener
                                                      .FilterContactsList[index]
                                                      .name ??
                                                  ""),
                                          commonTitleSmallWhite(
                                              context,
                                              providerListener
                                                      .FilterContactsList[index]
                                                      .category ??
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
                                      providerListener.FilterContactsList[index]
                                                      .company !=
                                                  "" &&
                                              providerListener
                                                      .FilterContactsList[index]
                                                      .company !=
                                                  null
                                          ? Row(
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
                                                            .FilterContactsList[
                                                                index]
                                                            .company ??
                                                        ""),
                                              ],
                                            )
                                          : SizedBox(
                                              height: 1,
                                            ),
                                      InkWell(
                                        onTap: () {
                                          _launchURL("tel:" +
                                                  providerListener
                                                      .FilterContactsList[index]
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
                                                        .FilterContactsList[index]
                                                        .phone ??
                                                    ""),
                                          ],
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          _launchURL("mailto:" +
                                                  providerListener
                                                      .FilterContactsList[index]
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
                                                        .FilterContactsList[index]
                                                        .email ??
                                                    ""),
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
                                                      .FilterContactsList[index]
                                                      .notes ??
                                                  ""),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                providerListener.FilterContactsList[index].tags !=
                                        ""
                                    ? providerListener
                                                .FilterContactsList[index].tags !=
                                            null
                                        ? ChipsChoice<String>.multiple(
                                            choiceItems:
                                                C2Choice.listFrom<String, String>(
                                              source: providerListener
                                                  .FilterContactsList[index].tags
                                                  .split(","),
                                              value: (i, v) => v,
                                              label: (i, v) => v,
                                              tooltip: (i, v) => v,
                                            ),
                                            wrapped: true,
                                            textDirection: TextDirection.ltr,
                                            onChanged: (List<String> value) {},
                                            value: [],
                                          )
                                        : SizedBox(
                                            height: 1,
                                          )
                                    : SizedBox(
                                        height: 1,
                                      ),
                                providerListener.memberShip == null ? Container():Divider(
                                  color: Colors.grey.shade700,
                                  thickness: 3,
                                ),
                                providerListener.memberShip == null ? Container():ExpandableNotifier(  // <-- Provides ExpandableController to its children
                                  child:Expandable(           // <-- Driven by ExpandableController from ExpandableNotifier
                                  collapsed: ExpandableButton(  // <-- Expands when tapped on the cover photo
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 20, right: 10, top: 20),
                                          child: Container(
                                              width: SizeConfig.screenWidth - 100,
                                              child: commonTitleSmallWhite(context,
                                                  "To Schedule followup select date, time and submit")),
                                        ),
                                        Icon(
                                          Icons.arrow_drop_down,
                                          color: Colors.white,
                                        )
                                      ],
                                    ),
                                  ),
                                  expanded: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 20, right: 10, top: 20),
                                              child: Container(
                                                  width: SizeConfig.screenWidth - 100,
                                                  child: commonTitleSmallWhite(context,
                                                      "To Schedule followup select date, time and submit")),
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
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 15, vertical: 20),
                                          child: InkWell(
                                            onTap: () {},
                                            child: Row(
                                              children: [
                                                Container(
                                                  width: SizeConfig.screenWidth - 140,
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.all(
                                                        Radius.circular(3)),
                                                    color: Color(COLOR_SECONDARY),
                                                  ),
                                                  child: DateTimePicker(
                                                    type: DateTimePickerType
                                                        .dateTimeSeparate,
                                                    dateMask: 'd MMM, yyyy',
                                                    initialValue:
                                                    DateTime.now().toString(),
                                                    firstDate: DateTime(2021),
                                                    lastDate: DateTime(2500),
                                                    icon: Padding(
                                                      padding: const EdgeInsets.all(8.0),
                                                      child: Icon(
                                                        Icons.event,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                    dateLabelText: 'Date',
                                                    timeLabelText: "Hour",
                                                    selectableDayPredicate: (date) {
                                                      return true;
                                                    },
                                                    onChanged: (val) {
                                                      print(val);
                                                      print(val.replaceAll(" ", "T"));
                                                      created = val.replaceAll(" ", "T");
                                                    },
                                                    validator: (val) {
                                                      print(val);

                                                      return null;
                                                    },
                                                    onSaved: (val) => print(val),
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
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: InkWell(
                                                    onTap: () {
                                                      if (created != "") {
                                                        Provider.of<CustomViewModel>(
                                                            context,
                                                            listen: false)
                                                            .AddFollowup(
                                                            providerListener
                                                                .userData.id,
                                                            providerListener
                                                                .FilterContactsList[
                                                            index]
                                                                .name,
                                                            providerListener
                                                                .FilterContactsList[
                                                            index]
                                                                .email,
                                                            providerListener
                                                                .FilterContactsList[
                                                            index]
                                                                .phone,
                                                            created,
                                                            "")
                                                            .then((value) {
                                                          setState(() {
                                                            created = "";
                                                          });
                                                          commonToast(context, value);
                                                        });
                                                      } else {
                                                        commonToast(context,
                                                            "To Schedule followup select date, time and submit");
                                                      }
                                                    },
                                                    child: Container(
                                                      width: 60,
                                                      height: 60,
                                                      decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.all(
                                                            Radius.circular(3)),
                                                        color: Color(COLOR_SECONDARY),
                                                      ),
                                                      child: Center(
                                                        child: Padding(
                                                          padding:
                                                          const EdgeInsets.all(8.0),
                                                          child: Text(
                                                            "Add",
                                                            style: TextStyle(
                                                                color:
                                                                Color(COLOR_PRIMARY),
                                                                fontSize: 18),
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
                                      ]
                                  ),
                                ),),
                                SizedBox(height: 20,),
                                providerListener
                                            .FilterContactsList[index].userId !=
                                        "0"
                                    ? InkWell(
                                        onTap: () {
                                          _launchURL((apiUrl +
                                              "/../visitcard.php?id=" +
                                              providerListener
                                                  .FilterContactsList[index]
                                                  .userId +
                                              "&c_id=" +
                                              providerListener
                                                  .FilterContactsList[index].id));
                                          Provider.of<CustomViewModel>(context,
                                                  listen: false)
                                              .getLatestContacts();
                                        },
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 20.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Icon(
                                                    Icons.remove_red_eye,
                                                    color: Color(COLOR_SECONDARY),
                                                    size: 25,
                                                  ),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  Container(
                                                    child: Center(
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets.all(
                                                                8.0),
                                                        child: Text(
                                                          "View FliQCard",
                                                          style: TextStyle(
                                                              color: Colors.white,
                                                              fontSize: 15),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              providerListener
                                                              .FilterContactsList[
                                                                  index]
                                                              .updated_at !=
                                                          "" &&
                                                      providerListener
                                                              .FilterContactsList[
                                                                  index]
                                                              .updated_at !=
                                                          null
                                                  ? DateTime.now()
                                                                  .difference(DateTime.parse(
                                                                      providerListener
                                                                          .FilterContactsList[
                                                                              index]
                                                                          .updated_at))
                                                                  .inDays <
                                                              6 &&
                                                          providerListener
                                                                  .FilterContactsList[
                                                                      index]
                                                                  .viewed ==
                                                              "0"
                                                      ? Container(
                                                          padding:
                                                              EdgeInsets.all(5),
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius.all(
                                                                    Radius
                                                                        .circular(
                                                                            5)),
                                                            color: Colors.grey,
                                                          ),
                                                          child: Text(
                                                            "Updated at " +
                                                                providerListener
                                                                    .FilterContactsList[
                                                                        index]
                                                                    .updated_at,
                                                            style: TextStyle(
                                                                color:
                                                                    Colors.white),
                                                          ),
                                                        )
                                                      : SizedBox(
                                                          height: 1,
                                                        )
                                                  : SizedBox(
                                                      height: 1,
                                                    ),
                                            ],
                                          ),
                                        ),
                                      )
                                    : SizedBox(
                                        height: 1,
                                      ),
                                Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Row(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          push(
                                              context,
                                              UpdateContactScreen(
                                                "contacts",
                                                  index,
                                                  providerListener
                                                      .FilterContactsList[index]
                                                      .id,
                                                  providerListener
                                                      .FilterContactsList[index]
                                                      .tags,
                                                  providerListener
                                                      .FilterContactsList[index]
                                                      .notes,
                                                  providerListener
                                                          .FilterContactsList[
                                                              index]
                                                          .category ??
                                                      ""));
                                        },
                                        child: Container(
                                          height: 40.0,
                                          width: 40.0,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: NetworkImage(apiUrl +
                                                  "/../../assets/images/editing.png"),
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          EasyLoading.show(status: 'loading...');
                                          Provider.of<CustomViewModel>(context,
                                                  listen: false)
                                              .deleteContact(providerListener
                                                  .FilterContactsList[index].id)
                                              .then((value) {
                                            setState(() {
                                              EasyLoading.dismiss();
                                              Provider.of<CustomViewModel>(
                                                      context,
                                                      listen: false)
                                                  .getLatestContacts();
                                              pop(context);
                                            });
                                          });
                                        },
                                        child: Container(
                                          width: 80,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(15)),
                                            color: Colors.red,
                                          ),
                                          child: Center(
                                            child: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Text(
                                                "Delete",
                                                style: TextStyle(
                                                    color: Colors.white,
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
