import 'package:flutter/cupertino.dart';
import 'package:flutter_map/flutter_map.dart';
import 'dart:collection';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:latlong/latlong.dart' as lt;
import 'package:flutter_map/src/layer/marker_layer.dart' as ml;


class EventData{
  EventData(this.eventName,this.description,this.latitude,this.longitude);

  final String eventName, description;
  final double latitude, longitude;

  @override
  String toString(){
    return eventName;
  }
}


class flutterMapEventsTour extends StatefulWidget {

  flutterMapEventsTour({
    @required this.events,
    Key key,
  }) : super(key: key);

  List<EventData> events;

  @override
  State<flutterMapEventsTour> createState() => flutterMapEventsTourState();
}

class flutterMapEventsTourState extends State<flutterMapEventsTour> {

  List<ml.Marker> _markers;

  double latitudeCenter;
  double longitudeCenter;

  @override
  void initState() {

    for(var e in widget.events){
      _markers.add(
          ml.Marker(
            width: 80.0,
            height: 80.0,
            point: lt.LatLng(e.latitude, e.longitude),
            builder: (ctx) =>
                Container(
                  child: Text(e.eventName),
                ),
          )
      );
    }

    for(var e in widget.events){
      latitudeCenter += e.latitude;
      longitudeCenter += e.longitude;
    }

    latitudeCenter /= widget.events.length;
    longitudeCenter /= widget.events.length;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return FlutterMap(
      options: MapOptions(
        center: lt.LatLng(latitudeCenter, longitudeCenter),
        zoom: 13.0,
      ),
      layers: [
        TileLayerOptions(
            urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
            subdomains: ['a', 'b', 'c']
        ),
        PolylineLayerOptions(polylines: []),
        MarkerLayerOptions(
          markers: _markers,
        ),
      ],
    );
  }
}