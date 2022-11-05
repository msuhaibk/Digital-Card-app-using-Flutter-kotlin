import 'package:fliqcard/Helpers/constants.dart';
import 'package:fliqcard/Helpers/helper.dart';
import 'package:fliqcard/UI/GoPremiumWidget.dart';
import 'package:fliqcard/UI/MainScreen.dart';
import 'package:fliqcard/UI/Staff/StaffListScreen.dart';
import 'package:fliqcard/View%20Models/CustomViewModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';

class AddEditStaff extends StatefulWidget {
  final id, fullname, department, phone, email;

  AddEditStaff(this.id, this.fullname, this.department, this.phone, this.email);

  @override
  _AddEditStaffState createState() => _AddEditStaffState();
}

class _AddEditStaffState extends State<AddEditStaff> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController fullnameController = TextEditingController();
  TextEditingController departmentController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future updateStaff() {
    Provider.of<CustomViewModel>(context, listen: false)
        .updateStaff(
      widget.id,
      fullnameController.text,
      departmentController.text,
      phoneController.text,
      emailController.text,
      passwordController.text,
    )
        .then((value) {
      setState(() {
        EasyLoading.dismiss();
        if (value == "success") {
          pushReplacement(context, StaffListScreen());
          commonToast(context, "Contact Saved");
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

    setState(() {
      fullnameController.text = widget.fullname;
      departmentController.text = widget.department;
      phoneController.text = widget.phone;
      emailController.text = widget.email;
    });
  }

  @override
  Widget build(BuildContext context) {
    final providerListener = Provider.of<CustomViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(COLOR_BACKGROUND),
        title: commonTitle(context, "Manage Staff Account"),
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
        child: SingleChildScrollView(
          child: providerListener.memberShip != null
              ? (widget.id == "0" &&
                      providerListener.memberShip.plan == "EXECUTIVE" &&
                      providerListener.staffList.length > 3)
                  ? Column(children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: commonTitleSmall(
                            context, "Go premium to add more staffs!"),
                      ),
                      GoPremiumWidget(context, 2),
                    ])
                  : (widget.id == "0" &&
              providerListener.memberShip.plan == "CORPORATE" &&
              providerListener.staffList.length > 24)
              ? Column(children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: commonTitleSmall(
                  context, "Go premium to add more staffs!"),
            ),
            GoPremiumWidget(context, 2),
          ])
              :(widget.id == "0" &&
              providerListener.memberShip.plan == "CORPORATE PLUS" &&
              providerListener.staffList.length >= int.parse(providerListener.memberShip.staffCount??"0"))
              ? Column(children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: commonTitleSmall(
                  context, "Go premium to add more staffs!"),
            ),
            GoPremiumWidget(context, 2),
          ])
              : Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                            height: 16,
                          ),
                          TextFormField(
                            controller: fullnameController,
                            decoration: InputDecoration(
                              hintText: 'Full Name',
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
                              fillColor: Colors.grey.withOpacity(0.1),
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 0),
                            ),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          TextFormField(
                            controller: departmentController,
                            decoration: InputDecoration(
                              hintText: 'Deaprtment',
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
                              fillColor: Colors.grey.withOpacity(0.1),
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 0),
                            ),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          TextFormField(
                            controller: phoneController,
                            maxLength: 15,
                            decoration: InputDecoration(
                              hintText: 'Phone Number',
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
                              fillColor: Colors.grey.withOpacity(0.1),
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 0),
                            ),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          TextFormField(
                            readOnly: widget.id == "0" ? false : true,
                            controller: emailController,
                            validator: (email) {
                              if (email != "") {
                                if (isEmailValid(email)) {
                                  return null;
                                } else
                                  return "Invalid email address";
                              } else {
                                return "Invalid email address";
                              }
                            },
                            maxLength: 30,
                            decoration: InputDecoration(
                              hintText: 'Email',
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
                              fillColor: widget.id == "0"
                                  ? Colors.grey.withOpacity(0.1)
                                  : Colors.grey.withOpacity(0.7),
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 0),
                            ),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          TextFormField(
                            controller: passwordController,
                            validator: (password) {
                              if (password != "" && password.length > 5) {
                                return null;
                              } else {
                                return "Password must be 6 digits or more";
                              }
                            },
                            maxLength: 20,
                            decoration: InputDecoration(
                              hintText: 'Password',
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
                              fillColor: Colors.grey.withOpacity(0.1),
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 0),
                            ),
                          ),
                          SizedBox(
                            height: 24,
                          ),
                          InkWell(
                            onTap: () {
                              if (_formKey.currentState.validate()) {
                                EasyLoading.show(status: 'loading...');
                                updateStaff();
                              } else {
                                commonToast(context, "Invalid credentials");
                              }
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
                                    color:
                                        Color(COLOR_SECONDARY).withOpacity(0.2),
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
                    )
              : SizedBox(
                  height: 1,
                ),
        ),
      ),
    );
  }
}
