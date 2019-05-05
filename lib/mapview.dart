import 'package:flutter/material.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mooseetws/data/MooseList.dart';
import 'dart:io';

import 'services/httpservice.dart';

class MainMapView extends StatefulWidget {
  @override
  State<MainMapView> createState() => MainMapViewState();
}

class MainMapViewState extends State<MainMapView> {
  Completer<GoogleMapController> mapController = Completer();
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};


  CameraPosition initialPosition = CameraPosition(
      target: LatLng(61.9241, 25.7482));

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Row(
        children: <Widget>[
          Expanded(
            child: GoogleMap(
              mapType: MapType.normal,
              myLocationButtonEnabled: true,
              myLocationEnabled: true,
              initialCameraPosition: initialPosition,
              onMapCreated: (GoogleMapController controller) {
                mapController.complete(controller);
                getCurrentLocation();
                addMarker();
              },
              markers: Set<Marker>.of(markers.values),
            ),
          ),
        ],
      ),
    );
  }

  addMarker () {
    Future<List<MooseLocation>> mooseLocation = BackendClient().getMooseList();
    mooseLocation.then((result) {
      for (int i = 0; i < result.length; i++) {
        MarkerId markerId = MarkerId(i.toString());
        final Marker marker = Marker(
          markerId: markerId,
          position: LatLng(result[i].lat, result[i].lan),
          infoWindow: InfoWindow(title: "Alert ", snippet: 'MoooSee'),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
          onTap: () {},
        );

        setState(() {
          markers[markerId] = marker;
        });
      }
    });
  }

  getCurrentLocation() async {
    Position position = await Geolocator().getLastKnownPosition(
        desiredAccuracy: LocationAccuracy.high);
    initialPosition = CameraPosition(
        target: LatLng(position.latitude, position.longitude), zoom: 13.0);
    final GoogleMapController controller = await mapController.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(initialPosition));
  }
}