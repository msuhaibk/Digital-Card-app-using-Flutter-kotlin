import 'package:fliqcard/Helpers/constants.dart';
import 'package:fliqcard/Helpers/helper.dart';
import 'package:fliqcard/Helpers/size_config.dart';
import 'package:fliqcard/View%20Models/CustomViewModel.dart';
import 'package:fliqcard/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:snapclip_pageview/snapclip_pageview.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

void _launchURL(String _url) async {
  try {
    await launch(_url);
  } catch (e) {
    print('Could not launch');
  }
}

SharedPreferences prefs;

class PricingScreen extends StatefulWidget {
  int temp;

  PricingScreen(this.temp);

  @override
  _PricingScreenState createState() => _PricingScreenState();
}

class _PricingScreenState extends State<PricingScreen> {
  Future launchPricing() async {
    prefs = await SharedPreferences.getInstance();

    /*try {
      await launch("https://fliqcard.com/digitalcard/pricing2.php?id=" +
              (prefs.getString('id') ?? ""))
          .whenComplete(() {
        print("aaaaaaaaaaa");
        if (widget.temp == 2) {
          pop(context);
          pop(context);
        } else {
          pop(context);
        }

        pushReplacement(context, OnBoardingPage());
      });
    } catch (e) {
      print('Could not launch');
      commonToast(context, 'Could not launch');
    }*/
    /* try {
      await launch("https://fliqcard.com/digitalcard/pricing2.php?id=" +
              (prefs.getString('id') ?? ""))
          .whenComplete(() {
        print("aaaaaaaaaaa");
        if (widget.temp == 2) {
          pop(context);
          pop(context);
        } else {
          pop(context);
        }

        pushReplacement(context, OnBoardingPage());
      });
    } catch (e) {
      print('Could not launch');
      commonToast(context, 'Could not launch');
    }*/
  }

  @override
  void initState() {
    super.initState();
    // launchPricing();
  }

  /* Future _ActivatePlan(String plan, String plan_id) {
    EasyLoading.show(status: 'loading...');
    Provider.of<CustomViewModel>(context, listen: false)
        .ActivatePlan("1234456", plan, plan_id, "Test")
        .then((value) {
      setState(() {
        commonToast(context, value);
        if (value == "error") {
          commonToast(context, value);
        } else {
          Provider.of<CustomViewModel>(context, listen: false)
              .getData()
              .then((value) {
            EasyLoading.dismiss();
            if(widget.temp==2){
              pop(context);
              pop(context);
            }else{
              pop(context);
            }

          });
        }
      });
    });
  }*/

  @override
  Widget build(BuildContext context) {
    final providerListener = Provider.of<CustomViewModel>(context);

    return
        /*  appBar: AppBar(
        backgroundColor: Color(COLOR_BACKGROUND),
        title: commonTitle(context, "Pricing Plan"),
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
      ),*/
        Scaffold(
      appBar: AppBar(
        backgroundColor: Color(COLOR_BACKGROUND),
        title: commonTitle(context, "Back to home"),
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
      //TODO
      body: Container(
        child: WebView(
          initialUrl:
              ("https://fliqcard.com/digitalcard/pricing2.php?id=" +
                  (providerListener.userData.id ?? "")),
          javascriptMode: JavascriptMode.unrestricted,
          onPageStarted: (String url) {
            print('Page started loading: $url');
            if ((url ?? "") == "https://fliqcard.com/digitalcard/" || (url ?? "") == "https://fliqcard.com/digitalcard/index.php") {
              if (widget.temp == 2) {
                pop(context);
                pop(context);
              } else {
                pop(context);
              }

              pushReplacement(context, OnBoardingPage());
            }
          },
          onPageFinished: (String url) {
            print('Page finished loading: $url');
          },
          gestureNavigationEnabled: true,
        ),
      ),
    );
  }
/*
  BackgroundWidget buildBackground(_, index) {
    return BackgroundWidget(
      key: Key(index.toString()),
      child: Container(
        color: Color(COLOR_SECONDARY),
      ),
      index: index,
    );
  }

  PageViewItem buildChild(_, int index) {
    switch (index) {
      case 0:
        return PageViewItem(
          key: Key(index.toString()),
          child: Container(
            width: SizeConfig.screenWidth,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 15,
                  ),
                  commonTitleBigBold(context, "BASIC"),
                  SizedBox(
                    height: 15,
                  ),
                  commonTitleSmall(context,
                      "1. Create a digital business card for yourself"),
                  commonTitleSmall(
                      context, "2. Share your card via QR code, email, text"),
                  commonTitleSmall(
                      context, "3. Address book with unlimited contacts"),
                  commonTitleSmall(context, "4. Virtual backgrounds"),
                  commonTitleSmall(context, "5. Email signatures"),
                  SizedBox(
                    height: 50,
                  ),
                  InkWell(
                    onTap: () {
                      pop(context);
                    },
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                        border: Border.all(color: Color(COLOR_PRIMARY)),
                        borderRadius: BorderRadius.all(
                          Radius.circular(25),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          "GO Back",
                          style: TextStyle(
                            fontSize: 24,
                            color: Color(COLOR_PRIMARY),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          height: SizeConfig.screenHeight / 1.3,
          index: index,
        );
        break;
      case 1:
        return PageViewItem(
          key: Key(index.toString()),
          child: Container(
            width: SizeConfig.screenWidth,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 15,
                  ),
                  commonTitleBigBold(context, "EXECUTIVE"),
                  commonTitleSmallBold(context, "\$3 per Month"),
                  commonSubTitleSmall(context, "\$25 for 1 year"),
                  SizedBox(
                    height: 15,
                  ),
                  commonTitleSmall(context,
                      "1. Create 2 digital business card for yourself"),
                  commonTitleSmall(
                      context, "2. Share your card via QR code, email, text"),
                  commonTitleSmall(
                      context, "3. Address book with unlimited contacts"),
                  commonTitleSmall(context, "4. Virtual backgrounds"),
                  commonTitleSmall(context, "5. Email signatures"),
                  commonTitleSmall(context, "6. Include a profile video"),
                  commonTitleSmall(context, "7. Social media share"),
                  commonTitleSmall(context, "8. Custom colors Design"),
                  commonTitleSmall(context, "9. Personalized link"),
                  commonTitleSmall(context, "10. Card Listing"),
                  commonTitleSmall(context, "11. Give Tag To Your Contact"),
                  commonTitleSmall(context, "12. Acces to all premium themes"),
                  SizedBox(
                    height: 50,
                  ),
                  InkWell(
                    onTap: () {
                      _ActivatePlan("EXECUTIVE", "3");
                    },
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                        border: Border.all(color: Color(COLOR_PRIMARY)),
                        borderRadius: BorderRadius.all(
                          Radius.circular(25),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          "Activate",
                          style: TextStyle(
                            fontSize: 24,
                            color: Color(COLOR_PRIMARY),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          height: SizeConfig.screenHeight / 1.3,
          index: index,
        );
        break;
      case 2:
        return PageViewItem(
          key: Key(index.toString()),
          child: Container(
              width: SizeConfig.screenWidth,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: 15,
                    ),
                    commonTitleBigBold(context, "CORPORATE"),
                    commonTitleSmallBold(context, "\$10 per Month"),
                    commonSubTitleSmall(context, "\$108 for 1 year"),
                    SizedBox(
                      height: 15,
                    ),
                    commonTitleSmall(context,
                        "1. Create a digital business card for yourself"),
                    commonTitleSmall(
                        context, "2. Create 25 FliQCard for your business"),
                    commonTitleSmall(
                        context, "3. Share your card via QR code, email, text"),
                    commonTitleSmall(
                        context, "4. Address book with unlimited contacts"),
                    commonTitleSmall(context, "5. Virtual backgrounds"),
                    commonTitleSmall(context, "6. Email signatures"),
                    commonTitleSmall(context, "7. Include a profile video"),
                    commonTitleSmall(context, "8. Social media share"),
                    commonTitleSmall(context, "9. Custom colors Design"),
                    commonTitleSmall(context, "10. Personalized link"),
                    commonTitleSmall(context, "11. Card Listing"),
                    commonTitleSmall(context, "12. Give Tag To Your Contact"),
                    commonTitleSmall(
                        context, "13. Acces to all premium themes"),
                    commonTitleSmall(context, "14. Business-level support"),
                    commonTitleSmall(context, "15. Staff management"),
                    SizedBox(
                      height: 50,
                    ),
                    InkWell(
                      onTap: () {
                        _ActivatePlan("CORPORATE", "4");
                      },
                      child: Container(
                        height: 40,
                        decoration: BoxDecoration(
                          border: Border.all(color: Color(COLOR_PRIMARY)),
                          borderRadius: BorderRadius.all(
                            Radius.circular(25),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            "Activate",
                            style: TextStyle(
                              fontSize: 24,
                              color: Color(COLOR_PRIMARY),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )),
          height: SizeConfig.screenHeight / 1.2,
          index: index,
        );
    }
  }*/
}
