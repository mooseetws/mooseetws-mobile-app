import 'package:flutter/material.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

void main() => runApp(MooseTWS());


class MooseTWS extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Google Maps Demo',
      home: MainMapView(),
    );
  }
}

class MainMapView extends StatefulWidget {
  @override
  State<MainMapView> createState() => MainMapViewState();
}

class MainMapViewState extends State<MainMapView> {
  Completer<GoogleMapController> _controller = Completer();

  CameraPosition initialPosition = CameraPosition(target: LatLng(61.9241, 25.7482));

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: GoogleMap(
        mapType: MapType.normal,
        myLocationButtonEnabled: true,
        myLocationEnabled: true,
        initialCameraPosition: initialPosition,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
          getCurrentLocation();
        },
      )
    );
  }

  getCurrentLocation() async {
    Position position = await Geolocator().getLastKnownPosition(desiredAccuracy: LocationAccuracy.high);
    initialPosition = CameraPosition(target: LatLng(position.latitude, position.longitude), zoom: 13.0);
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(initialPosition));
  }
}