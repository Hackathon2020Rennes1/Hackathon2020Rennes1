import 'package:flutter/cupertino.dart';
import 'package:flutter_map/flutter_map.dart';
import 'dart:collection';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:latlong/latlong.dart' as lt;
import 'package:flutter_map/src/layer/marker_layer.dart' as ml;


class flutterMapEvent extends StatelessWidget{

  flutterMapEvent({
      @required this.eventName,
      @required this.description,
      @required this.latitude,
      @required this.longitude}){}

  final String eventName, description;
  final double latitude, longitude;

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: MapOptions(
        center: lt.LatLng(latitude, longitude),
        zoom: 13.0,
      ),
      layers: [
        TileLayerOptions(
            urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
            subdomains: ['a', 'b', 'c']
        ),
        MarkerLayerOptions(
          markers: [
            ml.Marker(
              width: 80.0,
              height: 80.0,
              point: lt.LatLng(latitude, longitude),
              builder: (ctx) =>
                  Container(
                    child: Text(eventName),
                  ),
            ),
          ],
        ),
      ],
    );
  }
}