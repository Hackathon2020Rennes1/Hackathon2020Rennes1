import 'dart:async';
import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapEvent extends StatefulWidget {
  MapEvent({
    @required this.eventName,
    @required this.description,
    @required this.latitude,
    @required this.longitude,
    Key key,
  }) : super(key: key);

  final String eventName, description;
  final double latitude, longitude;

  @override
  State<MapEvent> createState() => MapEventState();
}

class MapEventState extends State<MapEvent> {
  //GoogleMapController _googleMapController;
  Completer<GoogleMapController> _googleMapController = Completer();

  final Set<Marker> _markers = HashSet<Marker>();

  static int nextMarkerId = 1;

  void _onMapCreated(GoogleMapController controller) {
    _googleMapController.complete(controller);
    setState(() {
      _markers
        ..clear()
        ..add(Marker(
            markerId: MarkerId((nextMarkerId++).toString()),
            position: LatLng(widget.latitude, widget.longitude),
            infoWindow: InfoWindow(title: widget.eventName, snippet: widget.description)));
    });
  }

  @override
  Widget build(BuildContext context) {
    /*return GoogleMap(
      initialCameraPosition: CameraPosition(
        target: LatLng(widget.latitude, widget.longitude),
        zoom: 14,
      ),
      onMapCreated: _onMapCreated,
      markers: _markers,
    );*/

    /*return Scaffold(
        body: GoogleMap(
          initialCameraPosition: CameraPosition(
            target: LatLng(widget.latitude, widget.longitude),
            zoom: 14,
          ),
          onMapCreated: _onMapCreated,
          markers: _markers,
        )
    );*/

    return Scaffold(
        body: Row(children: [
      Expanded(child: Text("TEST")),
      Expanded(
          child: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(50, 50),
          zoom: 14,
        ),
        onMapCreated: _onMapCreated,
        markers: _markers,
      ))
    ]));
  }
}
