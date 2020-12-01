
import 'dart:async';

import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapEvent extends StatefulWidget {

  @override
  State<MapEvent> createState() {

    String event_name, description;
    double latitude, longitude;

    return MapSampleState(event_name,description,latitude,longitude);
  }
}


class MapSampleState extends State<MapEvent> {

  MapSampleState(this.event_name,this.description,this.latitude,this.longitude);

  GoogleMapController _googleMapController;

  final Set<Marker> _markers = HashSet<Marker>();

  //final dbRef = FirebaseDatabase.instance.reference().child("");

  static int next_marker_id = 1;

  String event_name, description;
  double latitude, longitude;

  void _onMapCreated(GoogleMapController controller){
    _googleMapController = controller;
    setState((){
          _markers.add(
              Marker(
                  markerId:MarkerId((next_marker_id++).toString()),
                  position: LatLng(latitude,longitude),
                  infoWindow: InfoWindow(
                    title: event_name,
                    snippet: description)
          ));
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      mapType: MapType.normal,
      initialCameraPosition: CameraPosition(
        target: LatLng(5,5),
        zoom:14,
      ),
      onMapCreated: _onMapCreated,
      markers: _markers,
    );
  }
}