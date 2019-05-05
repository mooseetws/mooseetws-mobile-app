import 'package:flutter/material.dart';
import 'package:mooseetws/mapview.dart';
import 'package:mooseetws/welcomeview.dart';

void main() => runApp(MooseTWS());

class MooseTWS extends StatefulWidget {
  @override
  State<MooseTWS> createState() => MooseTWSState();
}

class MooseTWSState extends State<MooseTWS> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
        title: 'MooseeTWS',
        theme: ThemeData(
          primarySwatch: Colors.grey,
          fontFamily: 'SpaceMono',
        ),
        routes: {
          '/': (context) => WelcomeView(),
          '/mapScreen': (context) => MainMapView(),
        }
    );
  }
}