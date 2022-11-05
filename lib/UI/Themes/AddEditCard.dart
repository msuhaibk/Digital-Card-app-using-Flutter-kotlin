import 'dart:io';

import 'package:animated_radio_buttons/animated_radio_buttons.dart';
import 'package:fliqcard/Helpers/constants.dart';
import 'package:fliqcard/Helpers/helper.dart';
import 'package:fliqcard/Helpers/size_config.dart';
import 'package:fliqcard/UI/GoPremiumScrenn.dart';
import 'package:fliqcard/UI/MainScreen.dart';
import 'package:fliqcard/UI/Pricing/PricingScreen.dart';
import 'package:fliqcard/UI/Staff/StaffListScreen.dart';
import 'package:fliqcard/UI/Themes/ThemeSelector.dart';
import 'package:fliqcard/View%20Models/CustomViewModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_circle_color_picker/flutter_circle_color_picker.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class AddEditCard extends StatefulWidget {
  String slug,
      fullname,
      jobTitle,
      description,
      email,
      company,
      phone,
      phone2,
      telephone,
      whatsapp,
      website,
      address,
      mapLink,
      twitter,
      facebook,
      linkedIn,
      ytb,
      instagram,
      bgColor,
      cardColor,
      fontColor,
      material;

  AddEditCard(
      this.slug,
      this.fullname,
      this.jobTitle,
      this.description,
      this.email,
      this.company,
      this.phone,
      this.phone2,
      this.telephone,
      this.whatsapp,
      this.website,
      this.address,
      this.mapLink,
      this.twitter,
      this.facebook,
      this.linkedIn,
      this.ytb,
      this.instagram,
      this.bgColor,
      this.cardColor,
      this.fontColor,
      this.material);

  @override
  _AddEditCardState createState() => _AddEditCardState();
}

class _AddEditCardState extends State<AddEditCard> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController fullnameCotroller = TextEditingController();
  TextEditingController slugController = TextEditingController();
  TextEditingController jobTitleCotroller = TextEditingController();
  TextEditingController descriptionCotroller = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController companyController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController phone2Controller = TextEditingController();
  TextEditingController telephoneController = TextEditingController();
  TextEditingController whatsappController = TextEditingController();
  TextEditingController websiteController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController mapLinkController = TextEditingController();
  TextEditingController twitterController = TextEditingController();
  TextEditingController facebookController = TextEditingController();
  TextEditingController linkedInController = TextEditingController();
  TextEditingController ytbController = TextEditingController();
  TextEditingController instagramController = TextEditingController();
  TextEditingController marketingMaterialsController = TextEditingController();

  String bgColor = "#180202";
  String cardColor = "#E26522";
  String fontColor = "#ffffff";
  int pageIndex = 0;
  var errorMessage = "";
  var slug_error = "";

  final bgcolorController = CircleColorPickerController(
    initialColor: Color(COLOR_PRIMARY),
  );

  final cardcolorController = CircleColorPickerController(
    initialColor: Color(COLOR_PRIMARY),
  );

  final fontcolorController = CircleColorPickerController(
    initialColor: Color(COLOR_PRIMARY),
  );

  int myVar = 0;

  File _banner;
  File _logo;
  File _profile;

  final picker = ImagePicker();

  Future _pickBannerImage() async {
    try {
      final pickedFile = await picker.getImage(source: ImageSource.gallery);

      setState(() {
        if (pickedFile != null) {
          _banner = File(pickedFile.path);
        } else {
          print('No image selected.');
        }
      });
    } catch (e) {
      print(e);
    }
  }

  Future _pickLogoImage() async {
    try {
      final pickedFile = await picker.getImage(source: ImageSource.gallery);

      setState(() {
        if (pickedFile != null) {
          _logo = File(pickedFile.path);
        } else {
          print('No image selected.');
        }
      });
    } catch (e) {
      print(e);
    }
  }

  Future _pickProfileImage() async {
    try {
      final pickedFile = await picker.getImage(source: ImageSource.gallery);

      setState(() {
        if (pickedFile != null) {
          _profile = File(pickedFile.path);
        } else {
          print('No image selected.');
        }
      });
    } catch (e) {
      print(e);
    }
  }

  Future _pickVideo() async {
    try {
      final pickedFile = await picker.getVideo(source: ImageSource.gallery);

      setState(() {
        if (pickedFile != null) {
          _banner = File(pickedFile.path);
        } else {
          print('No image selected.');
        }
      });
    } catch (e) {
      print(e);
    }
  }

  Future saveCard(String operation) {
    Provider.of<CustomViewModel>(context, listen: false)
        .updateVcard(
            operation,
            slugController.text ?? "",
            fullnameCotroller.text ?? "",
            jobTitleCotroller.text ?? "",
            descriptionCotroller.text ?? "",
            emailController.text ?? "",
            companyController.text ?? "",
            whatsappController.text ?? "",
            websiteController.text ?? "",
            addressController.text ?? "",
            mapLinkController.text ?? "",
            twitterController.text ?? "",
            facebookController.text ?? "",
            linkedInController.text ?? "",
            ytbController.text ?? "",
            instagramController.text ?? "",
            phoneController.text ?? "",
            phone2Controller.text ?? "",
            telephoneController.text ?? "",
            marketingMaterialsController.text ?? "",
            bgColor.toString(),
            cardColor.toString(),
            fontColor.toString(),
            _banner,
            _logo,
            _profile)
        .then((value) {
      setState(() {
        // commonToast(context, value);
        errorMessage = value;
        Provider.of<CustomViewModel>(context, listen: false)
            .getData()
            .then((value) {
          EasyLoading.dismiss();
          Provider.of<CustomViewModel>(context, listen: false)
              .setBottomIndex(1);
          pushReplacement(context, ThemeSelector());
        });
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      pageIndex = 0;
      slugController.text = widget.slug;
      fullnameCotroller.text = widget.fullname;
      jobTitleCotroller.text = widget.jobTitle;
      descriptionCotroller.text = widget.description;
      emailController.text = widget.email;
      companyController.text = widget.company;
      phoneController.text = widget.phone;
      phone2Controller.text = widget.phone2;
      telephoneController.text = widget.telephone;
      whatsappController.text = widget.whatsapp;
      websiteController.text = widget.website;
      addressController.text = widget.address;
      mapLinkController.text = widget.mapLink;
      marketingMaterialsController.text = widget.material;
      twitterController.text = widget.twitter;
      facebookController.text = widget.facebook;
      linkedInController.text = widget.linkedIn;
      ytbController.text = widget.ytb;
      instagramController.text = widget.instagram;
      bgColor = widget.bgColor;
      cardColor = widget.cardColor;
      fontColor = widget.fontColor;
    });
  }

  @override
  Widget build(BuildContext context) {
    final providerListener = Provider.of<CustomViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(COLOR_BACKGROUND),
        title: commonTitle(context, "Manage Card"),
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
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.grey.shade200,
        ),
        height: 120,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  pageIndex != 0
                      ? InkWell(
                          onTap: () {
                            setState(() {
                              errorMessage = "";
                              pageIndex = pageIndex - 1;
                            });
                          },
                          child: Container(
                            height: 40,
                            width: 80,
                            margin: EdgeInsets.only(bottom: 20),
                            decoration: BoxDecoration(
                              color: Color(COLOR_SECONDARY),
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
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
                                "Back ",
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Color(COLOR_PRIMARY),
                                ),
                              ),
                            ),
                          ),
                        )
                      : SizedBox(
                          width: 1,
                        ),
                  SizedBox(
                    width: 10,
                  ),
                  pageIndex != 2
                      ? InkWell(
                          onTap: () {
                            if (_formKey.currentState.validate()) {
                              setState(() {
                                errorMessage = "";
                                pageIndex = pageIndex + 1;
                              });
                            } else {
                              //  commonToast(context, "Please fill required data");
                              setState(() {
                                errorMessage = "Please fill required data";
                              });
                            }
                          },
                          child: Container(
                            height: 40,
                            width: 80,
                            margin: EdgeInsets.only(bottom: 20),
                            decoration: BoxDecoration(
                              color: Color(COLOR_SECONDARY),
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
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
                                "Next ",
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Color(COLOR_PRIMARY),
                                ),
                              ),
                            ),
                          ),
                        )
                      : SizedBox(
                          width: 1,
                        ),
                  SizedBox(
                    width: 10,
                  ),
                  pageIndex == 2
                      ? InkWell(
                          onTap: () {
                            if (providerListener.vcardData != null) {
                              EasyLoading.show(status: 'loading...');
                              saveCard("save");
                            } else {
                              EasyLoading.show(status: 'loading...');
                              saveCard("add");
                            }
                          },
                          child: Container(
                            height: 40,
                            width: 80,
                            margin: EdgeInsets.only(bottom: 20),
                            decoration: BoxDecoration(
                              color: Color(COLOR_SECONDARY),
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
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
                                  fontSize: 15,
                                  color: Color(COLOR_PRIMARY),
                                ),
                              ),
                            ),
                          ),
                        )
                      : SizedBox(
                          width: 1,
                        ),
                ],
              ),
              Container(
                width: SizeConfig.screenWidth,
                child: Text(
                  errorMessage ?? "",
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: Colors.red,
                      fontSize: 14,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Container(
        width: SizeConfig.screenWidth,
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Visibility(
                  visible: pageIndex == 0,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 16,
                      ),
                      TextFormField(
                        controller: slugController,
                        readOnly:
                            providerListener.memberShip == null ? true : false,
                        decoration: InputDecoration(
                          hintText: 'Personalized link (eg. fullname)',
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
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                        ),
                        onChanged: (value) {
                          setState(() {
                            if (providerListener.slug_list.contains(value)) {
                              slug_error =
                                  "Please select another personalized link";
                            } else {
                              slug_error = "";
                            }
                          });
                        },
                      ),
                      slug_error == ""
                          ? Container()
                          : Container(
                              width: SizeConfig.screenWidth,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(slug_error,
                                    style: GoogleFonts.poppins(
                                        textStyle: TextStyle(
                                            fontSize: 12.0,
                                            color: Colors.red))),
                              ),
                            ),
                      providerListener.memberShip == null
                          ? InkWell(
                              onTap: () {
                                push(context, PricingScreen(1));
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: redText(context,
                                    "Go premium, to use this feature."),
                              ),
                            )
                          : providerListener.memberShip != null
                              ? slug_error == ""
                                  ? InkWell(
                                      onTap: () {
                                        Clipboard.setData(ClipboardData(
                                            text:
                                                "https://fliqcard.com/id.php?name=" +
                                                    slugController.text));
                                      },
                                      child: Container(
                                        padding: EdgeInsets.all(2),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            commonTitleSmall(
                                                context, "Copy Link"),
                                            Icon(
                                              FlutterIcons.copy1_ant,
                                              color: Color(COLOR_PRIMARY),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  : Container()
                              : SizedBox(
                                  width: 1,
                                ),
                      SizedBox(
                        height: 25,
                      ),
                      TextFormField(
                        controller: fullnameCotroller,
                        validator: (value) {
                          if (value != "") {
                            return null;
                          } else {
                            return "Field required!";
                          }
                        },
                        decoration: InputDecoration(
                          hintText: 'Name',
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
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      TextFormField(
                        controller: jobTitleCotroller,
                        decoration: InputDecoration(
                          hintText: 'Job title (Optional)',
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
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      TextFormField(
                        readOnly: true,
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
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.email,
                            color: Colors.black54,
                            size: 20,
                          ),
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
                          fillColor: Colors.grey.withOpacity(0.1),
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      TextFormField(
                        controller: companyController,
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.home_work_rounded,
                            color: Colors.black54,
                            size: 20,
                          ),
                          hintText: 'Company (Optional)',
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
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      TextFormField(
                        controller: phoneController,
                        validator: (value) {
                          if (value != "") {
                            return null;
                          } else {
                            return "Field required!";
                          }
                        },
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.phone_android_sharp,
                            color: Colors.black54,
                            size: 20,
                          ),
                          hintText: 'Primary Phone Number',
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
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      TextFormField(
                        controller: phone2Controller,
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.phone_android_sharp,
                            color: Colors.black54,
                            size: 20,
                          ),
                          hintText: 'Secondary Phone Number (optional)',
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
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      TextFormField(
                        controller: telephoneController,
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.phone,
                            color: Colors.black54,
                            size: 20,
                          ),
                          hintText: 'Telephone Number (optional)',
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
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Divider(),
                      TextFormField(
                        controller: whatsappController,
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            FlutterIcons.whatsapp_faw,
                            color: Colors.black54,
                            size: 20,
                          ),
                          hintText: 'WhatsApp Number (optional)',
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
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: commonSubTitleSmall(context,
                            "(Country code and number without any characters \neg. 91 1234567890)"),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Divider(),
                      TextFormField(
                        controller: websiteController,
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            FlutterIcons.earth_ant,
                            color: Colors.black54,
                            size: 20,
                          ),
                          hintText: 'Website',
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
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: commonSubTitleSmall(context,
                            "Website (Eg. www.google.com, google.com) without http or https"),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Divider(),
                      TextFormField(
                        controller: addressController,
                        decoration: InputDecoration(
                          hintText: 'Address (optional)',
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
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      TextFormField(
                        controller: descriptionCotroller,
                        decoration: InputDecoration(
                          hintText: 'Bio (Optional)',
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
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      TextFormField(
                        controller: mapLinkController,
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.location_on,
                            color: Colors.black54,
                            size: 20,
                          ),
                          hintText: 'Google Map Link (optional)',
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
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      TextFormField(
                        controller: twitterController,
                        decoration: InputDecoration(
                          prefixIcon: Icon(FlutterIcons.logo_twitter_ion,
                              color: Colors.blue),
                          hintText: 'Twitter Link (optional)',
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
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      TextFormField(
                        controller: facebookController,
                        decoration: InputDecoration(
                          prefixIcon: Icon(FlutterIcons.logo_facebook_ion,
                              color: Colors.blueAccent),
                          hintText: 'Facebook Link (optional)',
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
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      TextFormField(
                        controller: linkedInController,
                        decoration: InputDecoration(
                          prefixIcon: Icon(FlutterIcons.logo_linkedin_ion,
                              color: Color(COLOR_PRIMARY)),
                          hintText: 'LinkedIn Link (optional)',
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
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      TextFormField(
                        controller: ytbController,
                        decoration: InputDecoration(
                          prefixIcon: Icon(FlutterIcons.logo_youtube_ion,
                              color: Colors.red),
                          hintText: 'YouTube Link (optional)',
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
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      TextFormField(
                        controller: instagramController,
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            FlutterIcons.logo_instagram_ion,
                            color: Colors.purple,
                            size: 28,
                          ),
                          hintText: 'Instagram Link (optional)',
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
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      TextFormField(
                        controller: marketingMaterialsController,
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.link,
                            color: Colors.blue,
                            size: 28,
                          ),
                          hintText: 'Marketing Materials Link (optional)',
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
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                        ),
                      ),
                    ],
                  ),
                ),
                Visibility(
                  visible: pageIndex == 1,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                              width: 100,
                              child: commonTitleSmall(
                                  context, '1. Background Color (optional)')),
                          CircleColorPicker(
                            controller: bgcolorController,
                            onChanged: (color) {
                              if (providerListener.memberShip == null) {
                                /* commonToast(context,
                                    "Go premium, to use this feature.");*/
                                setState(() {
                                  errorMessage =
                                      "Go premium, to use this feature.";
                                });
                              } else {
                                setState(() => bgColor = color
                                    .toString()
                                    .replaceAll("Color(0xff", "#")
                                    .replaceAll(")", ""));
                              }
                            },
                            size: const Size(200, 200),
                            strokeWidth: 4,
                            thumbSize: 12,
                          ),
                        ],
                      ),
                      Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                              width: 100,
                              child: commonTitleSmall(
                                  context, '2. Card Color (optional)')),
                          CircleColorPicker(
                            controller: cardcolorController,
                            onChanged: (color) {
                              if (providerListener.memberShip == null) {
                                /* commonToast(context,
                                    "Go premium, to use this feature.");*/
                                setState(() {
                                  errorMessage =
                                      "Go premium, to use this feature.";
                                });
                              } else {
                                setState(() => cardColor = color
                                    .toString()
                                    .replaceAll("Color(0xff", "#")
                                    .replaceAll(")", ""));
                              }
                            },
                            size: const Size(200, 200),
                            strokeWidth: 4,
                            thumbSize: 12,
                          ),
                        ],
                      ),
                      Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                              width: 100,
                              child:
                                  commonTitleSmall(context, '3. Font Color')),
                          Column(
                            children: [
                              CircleColorPicker(
                                controller: fontcolorController,
                                onChanged: (color) {
                                  if (providerListener.memberShip == null) {
                                    /*   commonToast(context,
                                        "Go premium, to use this feature.");*/
                                    setState(() {
                                      errorMessage =
                                          "Go premium, to use this feature.";
                                    });
                                  } else {
                                    setState(() => fontColor = color
                                        .toString()
                                        .replaceAll("Color(0xff", "#")
                                        .replaceAll(")", ""));
                                  }
                                },
                                size: const Size(200, 200),
                                strokeWidth: 4,
                                thumbSize: 12,
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 16,
                      ),
                    ],
                  ),
                ),
                Visibility(
                  visible: pageIndex == 2,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      commonTitleSmall(context,
                          "Banner Video (mp4 only, recommended size less than 5 MB) \nOR\n Image recommended (600 X 300, 2:1)"),
                      SizedBox(
                        height: 20,
                      ),
                      commonTitleSmallBold(context, "Select Image OR Video"),
                      Row(
                        children: [
                          SizedBox(
                            width: 10,
                          ),
                          AnimatedRadioButtons(
                            value: myVar,
                            backgroundColor: Colors.transparent,
                            layoutAxis: Axis.vertical,
                            buttonRadius: 25.0,
                            items: [
                              AnimatedRadioButtonItem(
                                  label: "Image",
                                  color: Color(COLOR_PRIMARY),
                                  fillInColor: Color(COLOR_SECONDARY)),
                              AnimatedRadioButtonItem(
                                  label: "Video",
                                  color: Color(COLOR_PRIMARY),
                                  fillInColor: Color(COLOR_SECONDARY)),
                            ],
                            onChanged: (value) {
                              setState(() {
                                if (value == 1 &&
                                    providerListener.memberShip == null) {
                                  /* commonToast(
                                      context, "Go premium, to add video.");*/
                                  setState(() {
                                    errorMessage = "Go premium, to add video.";
                                  });
                                } else {
                                  myVar = value;
                                  print(value);
                                }
                              });
                            },
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          myVar == 0
                              ? Container(
                                  child: Column(children: <Widget>[
                                  RaisedButton(
                                    onPressed: () {
                                      _pickBannerImage();
                                    },
                                    child: Text("Choose Image"),
                                  ),
                                ]))
                              : Container(
                                  child: Column(children: <Widget>[
                                  RaisedButton(
                                    onPressed: () {
                                      _pickVideo();
                                    },
                                    child: Text("Choose Video"),
                                  ),
                                ])),
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                            width: 200,
                            child: Column(
                              children: [
                                _banner != null
                                    ? commonTitleSmall(context,
                                        _banner.path.split("/").last ?? "")
                                    : SizedBox(
                                        width: 1,
                                      ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      providerListener.vcardData != null
                          ? providerListener.vcardData.bannerImagePath != "" &&
                                  providerListener.vcardData.bannerImagePath !=
                                      null &&
                                  !providerListener.vcardData.bannerImagePath
                                      .contains("mp4")
                              ? Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 70.0,
                                      height: 70.0,
                                      decoration: BoxDecoration(
                                        color: const Color(0xff7c94b6),
                                        image: DecorationImage(
                                          image: NetworkImage(apiUrl +
                                              "../../" +
                                              providerListener
                                                  .vcardData.bannerImagePath),
                                          fit: BoxFit.fill,
                                        ),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5.0)),
                                        border: Border.all(
                                          color: Color(int.parse(
                                              providerListener
                                                  .vcardData.fontcolor
                                                  .replaceAll("#", "0xff"))),
                                          width: 2.0,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 50,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Provider.of<CustomViewModel>(context,
                                                listen: false)
                                            .deleteBanner()
                                            .then((value) {
                                          setState(() {
                                            providerListener
                                                .vcardData.bannerImagePath = "";
                                            errorMessage = value;
                                          });
                                          // commonToast(context, value);
                                        });
                                      },
                                      child: Container(
                                        height: 40,
                                        width: 80,
                                        margin: EdgeInsets.only(bottom: 20),
                                        decoration: BoxDecoration(
                                          color: Colors.red,
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(10),
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Color(COLOR_SECONDARY)
                                                  .withOpacity(0.2),
                                              spreadRadius: 3,
                                              blurRadius: 4,
                                              offset: Offset(0, 3),
                                            ),
                                          ],
                                        ),
                                        child: Center(
                                          child: Text(
                                            "Delete",
                                            style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              : SizedBox(
                                  height: 1,
                                )
                          : SizedBox(
                              height: 1,
                            ),
                      SizedBox(
                        height: 16,
                      ),
                      Divider(),
                      commonTitleSmall(context,
                          "Logo (Image Only, recommended 512 X 512, 1:1)"),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              child: Column(children: <Widget>[
                            RaisedButton(
                              onPressed: () {
                                _pickLogoImage();
                              },
                              child: Text("Choose Image"),
                            ),
                          ])),
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                            width: 200,
                            child: Column(
                              children: [
                                _logo != null
                                    ? commonTitleSmall(context,
                                        _logo.path.split("/").last ?? "")
                                    : SizedBox(
                                        width: 1,
                                      ),
                              ],
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      providerListener.vcardData != null
                          ? providerListener.vcardData.logoImagePath != "" &&
                                  providerListener.vcardData.logoImagePath !=
                                      null
                              ? Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 70.0,
                                      height: 70.0,
                                      decoration: BoxDecoration(
                                        color: const Color(0xff7c94b6),
                                        image: DecorationImage(
                                          image: NetworkImage(apiUrl +
                                              "../../" +
                                              providerListener
                                                  .vcardData.logoImagePath),
                                          fit: BoxFit.fill,
                                        ),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5.0)),
                                        border: Border.all(
                                          color: Color(int.parse(
                                              providerListener
                                                  .vcardData.fontcolor
                                                  .replaceAll("#", "0xff"))),
                                          width: 2.0,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 50,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Provider.of<CustomViewModel>(context,
                                                listen: false)
                                            .deleteLogo()
                                            .then((value) {
                                          setState(() {
                                            providerListener
                                                .vcardData.logoImagePath = "";
                                            errorMessage = value;
                                          });
                                          // commonToast(context, value);
                                        });
                                      },
                                      child: Container(
                                        height: 40,
                                        width: 80,
                                        margin: EdgeInsets.only(bottom: 20),
                                        decoration: BoxDecoration(
                                          color: Colors.red,
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(10),
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Color(COLOR_SECONDARY)
                                                  .withOpacity(0.2),
                                              spreadRadius: 3,
                                              blurRadius: 4,
                                              offset: Offset(0, 3),
                                            ),
                                          ],
                                        ),
                                        child: Center(
                                          child: Text(
                                            "Delete",
                                            style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              : SizedBox(
                                  height: 1,
                                )
                          : SizedBox(
                              height: 1,
                            ),
                      SizedBox(
                        height: 16,
                      ),
                      Divider(),
                      commonTitleSmall(context,
                          "Profile (Image Only, recommended 512 X 512, 1:1)"),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              child: Column(children: <Widget>[
                            RaisedButton(
                              onPressed: () {
                                _pickProfileImage();
                              },
                              child: Text("Choose Image"),
                            ),
                          ])),
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                            width: 200,
                            child: Column(
                              children: [
                                _profile != null
                                    ? commonTitleSmall(context,
                                        _profile.path.split("/").last ?? "")
                                    : SizedBox(
                                        width: 1,
                                      ),
                              ],
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      providerListener.vcardData != null
                          ? providerListener.vcardData.profileImagePath != "" &&
                                  providerListener.vcardData.profileImagePath !=
                                      null
                              ? Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 70.0,
                                      height: 70.0,
                                      decoration: BoxDecoration(
                                        color: const Color(0xff7c94b6),
                                        image: DecorationImage(
                                          image: NetworkImage(apiUrl +
                                              "../../" +
                                              providerListener
                                                  .vcardData.profileImagePath),
                                          fit: BoxFit.fill,
                                        ),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5.0)),
                                        border: Border.all(
                                          color: Color(int.parse(
                                              providerListener
                                                  .vcardData.fontcolor
                                                  .replaceAll("#", "0xff"))),
                                          width: 2.0,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 50,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Provider.of<CustomViewModel>(context,
                                                listen: false)
                                            .deleteProfile()
                                            .then((value) {
                                          setState(() {
                                            providerListener.vcardData
                                                .profileImagePath = "";
                                            errorMessage = value;
                                          });
                                          //commonToast(context, value);
                                        });
                                      },
                                      child: Container(
                                        height: 40,
                                        width: 80,
                                        margin: EdgeInsets.only(bottom: 20),
                                        decoration: BoxDecoration(
                                          color: Colors.red,
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(10),
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Color(COLOR_SECONDARY)
                                                  .withOpacity(0.2),
                                              spreadRadius: 3,
                                              blurRadius: 4,
                                              offset: Offset(0, 3),
                                            ),
                                          ],
                                        ),
                                        child: Center(
                                          child: Text(
                                            "Delete",
                                            style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
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
                SizedBox(
                  height: 50,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
