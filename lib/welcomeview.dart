import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';


FirebaseMessaging fireBaseMessaging = FirebaseMessaging();

class WelcomeView extends StatefulWidget {
  @override
  State<WelcomeView> createState() => WelcomeViewState();
}

class WelcomeViewState extends State<WelcomeView> {
  final nameControler = TextEditingController();

  @override
  void initState() {
    super.initState();
    initFCMListeners();
  }

  void initFCMListeners() {
    if (Platform.isIOS) initIosPermission();

    fireBaseMessaging.getToken().then((token) {
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

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Padding(
        padding:  EdgeInsets.all(10.0),
        child:Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 0.0, bottom: 10.0),
              child:Text(
              "Vehicle Number", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
            ),),
            Padding(
              padding: EdgeInsets.only(left: 10.0),
              child: TextField(
                controller: nameControler,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(vertical: 5.0),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 30.0),
              child: MaterialButton(
                height: 40.0,
                minWidth: 250.0,
                color: Colors.blue[900],
                textColor: Colors.white,
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/mapScreen');
                },
                child: new Text('Submit'),
              ),
            ),
          ],
        )
      )
    );
  }
}