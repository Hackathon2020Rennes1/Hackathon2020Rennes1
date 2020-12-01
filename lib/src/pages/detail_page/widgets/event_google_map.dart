

import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
//import 'package:firebase_database/firebase_database.dart';

class MapEvent extends StatefulWidget {

  @override
  State<MapEvent> createState() => MapEventState();
}


class MapEventState extends State<MapEvent> {

  //MapSampleState(this.eventName,this.description,this.latitude,this.longitude);
  MapEventState(){
    eventName = 'eventName';
    description = 'description';
    latitude = 2;
    longitude = 2;
  }
  GoogleMapController _googleMapController;

  final Set<Marker> _markers = HashSet<Marker>();

  static int nextMarkerId = 1;

  String eventName, description;
  double latitude, longitude;

  void _onMapCreated(GoogleMapController controller){
    _googleMapController = controller;
    setState((){
          _markers.add(
              Marker(
                  markerId:MarkerId((nextMarkerId++).toString()),
                  position: LatLng(latitude,longitude),
                  infoWindow: InfoWindow(
                    title: eventName,
                    snippet: description)
          ));
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      initialCameraPosition: CameraPosition(
        target: LatLng(latitude,longitude),
        zoom:14,
      ),
      onMapCreated: _onMapCreated,
      markers: _markers,
    );
  }
}