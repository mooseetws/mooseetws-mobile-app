
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:mooseetws/mapview.dart';
import 'package:mooseetws/services/httpservice.dart';
import 'package:mooseetws/services/storageservice.dart';


FirebaseMessaging fireBaseMessaging = FirebaseMessaging();
String fcmToken;

class WelcomeView extends StatefulWidget {
  @override
  State<WelcomeView> createState() => WelcomeViewState();
}

class WelcomeViewState extends State<WelcomeView> {
  final nameControler = TextEditingController();
  final vnumberController = TextEditingController();
  final emailControler = TextEditingController();
  final cnumberController = TextEditingController();

  @override
  void initState() {
    super.initState();
    initFCMListeners();
    getToken().then((token) {
      setState(() {
        fcmToken  = token;
        print ("token in init is "+ token);
        WidgetsBinding.instance.addPostFrameCallback((_) async {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => MainMapView()
              )
          );
        });
      });
    });
  }

  void initFCMListeners() {
    if (Platform.isIOS) initIosPermission();

    fireBaseMessaging.getToken().then((token) {
      fcmToken = token;
      print("***** token is ***** " + token);
    });

    fireBaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print('on message $message');
      },
      onResume: (Map<String, dynamic> message) async {
        print('on resume $message');
      },
      onLaunch: (Map<String, dynamic> message) async {
        print('on launch $message');
      },
    );
  }

  void initIosPermission() {
    fireBaseMessaging.requestNotificationPermissions(
        IosNotificationSettings(sound: true, badge: true, alert: true)
    );
    fireBaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });
  }

  Future<String> getToken() async {
    return StorageService().getFCMToken();
  }

  @override
  Widget build(BuildContext context) {
    if (fcmToken != null) {
      return Scaffold(
        body: Text("Loading...")
      );
    }
    return Scaffold(
      backgroundColor: const Color(0xff4e92df),
      body: Container(
        child:Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 10.0, bottom: 10.0),
              child: Row (
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                 Text(
                   "Moose", style: TextStyle(fontSize: 25.0, color: Colors.white),
                 ),
                 Text(
                   "ETWS", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0, color: Colors.white),
                 ),
               ],
              )
            ),
            Center(
              child: Image.asset(
                "assets/images/app_icon.png",
                width: 128,
                height: 128,
              ),
            ),
            Padding(
                padding: EdgeInsets.only(left: 30.0, bottom: 10.0, top: 20.0, right: 30.0),
                child: Text(
                  "Register your license plate to get notified",  textAlign: TextAlign.center, style: TextStyle(fontSize: 20.0, color: Colors.white),
                ),
            ),
            Flexible(
              child: Padding(
                padding: EdgeInsets.only(left: 40.0, bottom: 40.0, top: 40.0, right: 40.0),
                child: TextField(
                  cursorColor: Colors.white,
                  decoration: InputDecoration(
                    filled: true,
                    border: OutlineInputBorder(

                    ),
                    hintText: 'Enter License Plate Number',
                    fillColor: Colors.white,
                  ),
                ),
              ),
            ),
            Center(
              child: MaterialButton(
                height: 40.0,
                minWidth: 250.0,
                color: Colors.white,
                textColor: Colors.black,
                onPressed: () {
                  BackendClient().postMyInfo(fcmToken, "1234");
                  Navigator.pushReplacementNamed(context, '/mapScreen');
                },
                child: new Text('Sign in'),
              ),
            ),
          ],
        )
      )
    );
  }
}