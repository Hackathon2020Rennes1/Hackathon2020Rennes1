

import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapEvent extends StatefulWidget {

  @override
  State<MapEvent> createState() => MapSampleState();
}


class MapSampleState extends State<MapEvent> {

  //MapSampleState(this.eventName,this.description,this.latitude,this.longitude);
  MapSampleState(){
    eventName = 'eventName';
    description = 'description';
    latitude = 2;
    longitude = 2;
  }
  GoogleMapController _googleMapController;

  final Set<Marker> _markers = HashSet<Marker>();

  //final dbRef = FirebaseDatabase.instance.reference().child("");

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
      //mapType: MapType.normal,
      initialCameraPosition: CameraPosition(
        target: LatLng(latitude,longitude),
        zoom:14,
      ),
      onMapCreated: _onMapCreated,
      markers: _markers,
    );
  }
}