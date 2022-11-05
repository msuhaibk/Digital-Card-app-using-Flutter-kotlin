import 'package:fliqcard/Helpers/constants.dart';
import 'package:fliqcard/Helpers/helper.dart';
import 'package:fliqcard/UI/MainScreen.dart';
import 'package:fliqcard/View%20Models/CustomViewModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';

import 'ContactsScreen.dart';
import 'ListOfContacts.dart';
import 'ListOfShared.dart';

String category_name = "Work";

class UpdateContactScreen extends StatefulWidget {
  final fromWhere, index, id, tags, notes, category;

  UpdateContactScreen(this.fromWhere, this.index, this.id, this.tags,
      this.notes, this.category);

  @override
  _UpdateContactScreenState createState() => _UpdateContactScreenState();
}

class _UpdateContactScreenState extends State<UpdateContactScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController tagsController = TextEditingController();
  TextEditingController notesController = TextEditingController();

  Future UpdateContact() async {
    Provider.of<CustomViewModel>(context, listen: false)
        .UpdateContact(widget.index, widget.id, tagsController.text.toString(),
            notesController.text.toString(), category_name ?? "")
        .then((value) {
      setState(() {
        Provider.of<CustomViewModel>(context, listen: false)
            .getLatestContacts()
            .then((value) {
          /* if (widget.fromWhere == "contacts") {
            EasyLoading.dismiss();
            pop(context);
            pushReplacement(context, MainScreen());
          } else {
            EasyLoading.dismiss();

            pop(context);
            pushReplacement(context, MainScreen());
          }*/
          EasyLoading.dismiss();
          print("aaaaaaaaaaaaaaaaaaaaaaaaaaaaa");
          print(widget.fromWhere);
          pop(context);
          if (widget.fromWhere != null) {
            if (widget.fromWhere == "contacts") {
              pushReplacement(context, ListOfContacts(category_name ?? "All"));
            } else {
              pushReplacement(context, ListOfShared(category_name ?? "All"));
            }
          }
        });
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      tagsController.text = widget.tags ?? "";

      notesController.text = widget.notes ?? "";
      category_name = widget.category ?? "";
    });
  }

  @override
  Widget build(BuildContext context) {
    final providerListener = Provider.of<CustomViewModel>(context);

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(COLOR_BACKGROUND),
          title: commonTitle(context, "Manage Contact"),
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
          child: SingleChildScrollView(
            child: Container(
              width: double.infinity,
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: 16,
                    ),
                    commonTitle(context, "Category"),
                    SizedBox(
                      height: 16,
                    ),
                    Container(
                      height: 50,
                      decoration: ShapeDecoration(
                        color: Colors.grey.withOpacity(0.1),
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            width: 0,
                            style: BorderStyle.none,
                          ),
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          hint: Padding(
                            child: commonSubTitle(context, category_name),
                            padding: EdgeInsets.only(left: 15, top: 5),
                          ),
                          items: <String>[
                            'Client',
                            'Family',
                            'Friend',
                            'Business',
                            'Vendor',
                            'Other'
                          ].map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: new Text(value),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              category_name = value;
                            });
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    commonTitleSmall(
                        context,
                        providerListener.memberShip != null
                            ? "Tags (comma separated values)"
                            : "Tags (go premium for tags)"),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      readOnly:
                          providerListener.memberShip != null ? false : true,
                      controller: tagsController,
                      minLines: 3,
                      maxLines: 10,
                      decoration: InputDecoration(
                        hintText: '',
                        hintStyle: TextStyle(
                            fontSize: 16, color: Color(COLOR_SUBTITLE)),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: BorderSide(
                            width: 0,
                            style: BorderStyle.none,
                          ),
                        ),
                        filled: true,
                        fillColor: providerListener.memberShip == null
                            ? Colors.grey.withOpacity(0.3)
                            : Colors.grey.withOpacity(0.1),
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 15),
                      ),
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    commonTitleSmall(
                        context,
                        providerListener.memberShip != null
                            ? "Notes"
                            : "Notes (go premium for Notes)"),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      readOnly:
                      providerListener.memberShip != null ? false : true,
                      controller: notesController,
                      decoration: InputDecoration(
                        hintText: '',
                        hintStyle: TextStyle(
                            fontSize: 16, color: Color(COLOR_SUBTITLE)),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: BorderSide(
                            width: 0,
                            style: BorderStyle.none,
                          ),
                        ),
                        filled: true,
                        fillColor: providerListener.memberShip == null
                            ? Colors.grey.withOpacity(0.3)
                            : Colors.grey.withOpacity(0.1),
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                      ),
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    InkWell(
                      onTap: () {
                        EasyLoading.show(status: 'loading...');

                        UpdateContact();
                      },
                      child: Container(
                        height: 40,
                        decoration: BoxDecoration(
                          color: Color(COLOR_SECONDARY),
                          borderRadius: BorderRadius.all(
                            Radius.circular(25),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Color(COLOR_SECONDARY).withOpacity(0.2),
                              spreadRadius: 3,
                              blurRadius: 4,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Center(
                          child: Text(
                            "Save ",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Color(COLOR_PRIMARY),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 24,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
