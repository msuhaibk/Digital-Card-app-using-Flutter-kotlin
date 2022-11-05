import 'dart:convert';
import 'dart:io';

import 'package:fliqcard/Helpers/constants.dart';
import 'package:fliqcard/Helpers/helper.dart';
import 'package:fliqcard/Helpers/size_config.dart';
import 'package:fliqcard/UI/Auth/LoginScreen.dart';
import 'package:fliqcard/UI/Auth/SelectScreen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:connectivity/connectivity.dart';
import 'package:video_player/video_player.dart';
import 'package:fliqcard/Models/VcardParser.dart';
import 'UI/MainScreen.dart';
import 'UI/NoInternet.dart';
import 'View Models/CustomViewModel.dart';

import 'package:home_widget/home_widget.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // final providerListener = Provider.of<CustomViewModel>(context);
  // var data = CustomViewModel();
  // var x = data.getData();
  // print(x.toString());
  HomeWidget.registerBackgroundCallback(backgroundCallback);
  runApp(App());
}

// var bytes = "aduaad";

int _counter = 20;

// Called when Doing Background Work initiated from Widget
Future<void> backgroundCallback(Uri uri) async {
  if (uri.host == 'updatecounter') {
    var x;
    // int _counter;
    await HomeWidget.getWidgetData<String>('_vcardata', defaultValue: "")
        .then((value) {
      x = jsonEncode(value);
      print(x);
    });
    await HomeWidget.saveWidgetData<String>('_vcardata', x);
    await HomeWidget.updateWidget(
        name: 'AppWidgetProvider', iOSName: 'AppWidgetProvider');
  }
}

String _getBannerLink(VcardParser vcardParser) {
  return vcardParser.bannerImagePath != "" &&
          vcardParser.bannerImagePath.contains("mp4")
      ? vcardParser.bannerImagePath
      : "";
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: APP_TITLE,
      debugShowCheckedModeBanner: false,
      home: MultiProvider(
          providers: [
            ChangeNotifierProvider(
                create: (context) => CustomViewModel(),
                child: MaterialApp(
                    debugShowCheckedModeBanner: false,
                    home: VideoIntroScreen())),
          ],
          child: MaterialApp(
              debugShowCheckedModeBanner: false, home: VideoIntroScreen())),
      builder: EasyLoading.init(),
    );
  }
}

class VideoIntroScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _VideoIntroScreenState();
}

class _VideoIntroScreenState extends State<VideoIntroScreen>
    with TickerProviderStateMixin {
  VideoPlayerController _controller;
  bool _visible = false;

  Future initTask() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var id = prefs.getString("id") ?? "null";

    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      if (id != null && id != "null") {
        pushReplacement(context, MainScreen());
      }
    } else if (connectivityResult == ConnectivityResult.wifi) {
      if (id != null && id != "null") {
        pushReplacement(context, MainScreen());
      }
    } else {
      if (id != null && id != "null") {
        pushReplacement(context, NoInternet(id));
      } else {
        pushReplacement(context, NoInternet("0"));
      }
    }
  }

  @override
  void initState() {
    super.initState();
    initTask();
    if (_controller != null) {
      _controller.dispose();
      _controller = null;
    }
    _controller = VideoPlayerController.network(
        "https://fliqcard.com/digitalcard/assets/img/appdata/intro.mp4");
    _controller.initialize().then((_) {
      _controller.setLooping(true);
      setState(() {
        _controller.setVolume(0.0);
        _controller.play();
        _visible = true;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    if (_controller != null) {
      _controller.dispose();
      _controller = null;
    }
  }

  _getVideoBackground() {
    return AnimatedOpacity(
      opacity: 1.0,
      duration: Duration(milliseconds: 1000),
      child: VideoPlayer(_controller),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: SizeConfig.screenHeight,
        color: Colors.white,
        child: Stack(
          children: [
            _visible == true
                ? _getVideoBackground()
                : Container(
                    color: Colors.white,
                    child: Center(
                      child: new CircularProgressIndicator(
                        strokeWidth: 5,
                        backgroundColor: Color(COLOR_PRIMARY),
                        valueColor: AlwaysStoppedAnimation<Color>(
                            Color(COLOR_BACKGROUND)),
                      ),
                    ),
                  ),
            Positioned(
              bottom: 15,
              right: 15,
              child: InkWell(
                onTap: () {
                  pushReplacement(context, OnBoardingPage());
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Color(COLOR_SECONDARY),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Next  ',
                          style: TextStyle(
                              fontSize: 24,
                              color: Color(COLOR_PRIMARY),
                              fontWeight: FontWeight.w700)),
                      Icon(Icons.arrow_forward, color: Color(COLOR_PRIMARY))
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OnBoardingPage extends StatefulWidget {
  @override
  _OnBoardingPageState createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context) {
    pushReplacement(context, SelectScreen());
  }

  Widget _buildImage(String assetName, [double width = 350]) {
    return Image.asset('$assetName', width: width);
  }

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(fontSize: 19.0, color: Color(COLOR_SUBTITLE));

    const pageDecoration = const PageDecoration(
      titleTextStyle: TextStyle(
          fontSize: 28.0,
          fontWeight: FontWeight.w700,
          color: Color(COLOR_PRIMARY)),
      bodyTextStyle: bodyStyle,
      descriptionPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: Colors.white,
      imagePadding: EdgeInsets.zero,
    );

    return IntroductionScreen(
      key: introKey,
      globalBackgroundColor: Color(COLOR_BACKGROUND),
      pages: [
        PageViewModel(
          title: "It is the next evolution.",
          body:
              "FliQCard is the Convenience and Simplicity of being extremely up-to-date with your latest contact information. Innovative to adapt the current work challenges by building a bridge between Business and Technology providing complete solution for your needs.",
          image: _buildImage('assets/logo.png'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Go Paperless. Go Green.",
          body:
              "Go paperless and go green is the new mantra for today’s businesses that want to attain efficiency and speed in their processes. The challenge is to reduce paper dependence.",
          image: _buildImage('assets/logo.png'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Save trees, live an active lifestyle.",
          body:
              "Saving trees would lead to a greener and healthier environment and in turn, lead to us being healthier and more active.",
          image: _buildImage('assets/logo.png'),
          decoration: pageDecoration,
        ),
      ],
      onDone: () => _onIntroEnd(context),
      onSkip: () => _onIntroEnd(context),
      // You can override onSkip callback
      showSkipButton: true,
      skipFlex: 0,
      nextFlex: 0,
      //rtl: true, // Display as right-to-left
      skip: const Text(
        'Skip',
        style: TextStyle(color: Color(COLOR_SECONDARY)),
      ),
      next: const Icon(Icons.arrow_forward, color: Color(COLOR_SECONDARY)),
      done: const Text('Done',
          style: TextStyle(
              fontWeight: FontWeight.w600, color: Color(COLOR_SECONDARY))),
      curve: Curves.fastLinearToSlowEaseIn,
      controlsMargin: const EdgeInsets.all(16),
      controlsPadding: kIsWeb
          ? const EdgeInsets.all(12.0)
          : const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0),
        activeColor: Color(COLOR_SECONDARY),
        color: Color(0xFFBDBDBD),
        activeSize: Size(22.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
      dotsContainerDecorator: const ShapeDecoration(
        color: Colors.black87,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    HomeWidget.widgetClicked.listen((Uri uri) => loadData());
    loadData(); // This will load data from widget every time app is opened
  }

  void loadData() async {
    await HomeWidget.getWidgetData<int>('_counter', defaultValue: 0)
        .then((value) {
      _counter = value;
    });
    setState(() {});
  }

  Future<void> updateAppWidget() async {
    await HomeWidget.saveWidgetData<int>('_counter', _counter);
    await HomeWidget.updateWidget(
        name: 'AppWidgetProvider', iOSName: 'AppWidgetProvider');
  }

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
    updateAppWidget();
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.

    // final providerListener =
    //     Provider.of<CustomViewModel>(context, listen: false);

    // bytes = providerListener.vcardData.address;
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}


// class MyHomePage extends StatefulWidget {
//   MyHomePage({Key key, this.title}) : super(key: key);

//   // This widget is the home page of your application. It is stateful, meaning
//   // that it has a State object (defined below) that contains fields that affect
//   // how it looks.

//   // This class is the configuration for the state. It holds the values (in this
//   // case the title) provided by the parent (in this case the App widget) and
//   // used by the build method of the State. Fields in a Widget subclass are
//   // always marked "final".

//   final String title;

//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   int _counter = 0;

//   String _image = "asdnaasdasdasdasdsadsadkklj";

//   @override
//   void initState() {
//     super.initState();
//     HomeWidget.widgetClicked.listen((Uri uri) => loadData());
//     loadData(); // This will load data from widget every time app is opened
//   }

//   void loadData() async {
//     await HomeWidget.getWidgetData<String>('_image', defaultValue: "")
//         .then((value) {
//       _image = value;
//       updateAppWidget();
//       //baad me lagaya this above
//     });
//     setState(() {});
//   }

//   Future<void> updateAppWidget() async {
// //    await HomeWidget.saveWidgetData<String>('_counter', _counter);
//     await HomeWidget.saveWidgetData<String>('_image', "abuasdasj12312");
//     await HomeWidget.updateWidget(
//         name: 'AppWidgetProvider', iOSName: 'AppWidgetProvider');
//   }

//   void _incrementCounter() {
//     setState(() {
//       // This call to setState tells the Flutter framework that something has
//       // changed in this State, which causes it to rerun the build method below
//       // so that the display can reflect the updated values. If we changed
//       // _counter without calling setState(), then the build method would not be
//       // called again, and so nothing would appear to happen.
//       _counter++;
//       _image = "testoiioioo";
//     });
//     updateAppWidget();
//   }

//   @override
//   Widget build(BuildContext context) {
//     // This method is rerun every time setState is called, for instance as done
//     // by the _incrementCounter method above.

//     final providerListener =
//         Provider.of<CustomViewModel>(context, listen: false);

//     bytes = providerListener.vcardData.address;
//     //
//     // The Flutter framework has been optimized to make rerunning build methods
//     // fast, so that you can just rebuild anything that needs updating rather
//     // than having to individually change instances of widgets.
//     return Scaffold(
//       appBar: AppBar(
//         // Here we take the value from the MyHomePage object that was created by
//         // the App.build method, and use it to set our appbar title.
//         title: Text(widget.title),
//       ),
//       body: Center(
//         // Center is a layout widget. It takes a single child and positions it
//         // in the middle of the parent.
//         child: Column(
//           // Column is also a layout widget. It takes a list of children and
//           // arranges them vertically. By default, it sizes itself to fit its
//           // children horizontally, and tries to be as tall as its parent.
//           //
//           // Invoke "debug painting" (press "p" in the console, choose the
//           // "Toggle Debug Paint" action from the Flutter Inspector in Android
//           // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
//           // to see the wireframe for each widget.
//           //
//           // Column has various properties to control how it sizes itself and
//           // how it positions its children. Here we use mainAxisAlignment to
//           // center the children vertically; the main axis here is the vertical
//           // axis because Columns are vertical (the cross axis would be
//           // horizontal).
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Text(
//               'You have pushed the button this many times:',
//             ),
//             Text(
//               '$_counter',
//               style: Theme.of(context).textTheme.headline4,
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _incrementCounter,
//         tooltip: 'Increment',
//         child: Icon(Icons.add),
//       ), // This trailing comma makes auto-formatting nicer for build methods.
//     );
//   }
// }
