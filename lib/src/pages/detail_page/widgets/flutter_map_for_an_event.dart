
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map/src/layer/marker_layer.dart' as ml;
import 'package:latlong/latlong.dart' as lt;

class LocationLabel extends StatelessWidget {

  LocationLabel(this.eventName,this.description,this.height);

  String eventName, description;
  double height;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children:[
              Container(
                  height:height-20,
                  child:ListView(
                      children:[
                        Text(eventName),
                        Divider(color: Colors.grey, thickness: 2),
                        Text(description),
                      ]
                  )
              ),
              Divider(color: Colors.green, thickness: 4)
            ],
          ),
        );
  }
}

class flutterMapEvent extends StatelessWidget {
  flutterMapEvent({@required this.eventName, @required this.description, @required this.latitude, @required this.longitude, Key key})
      : super(key: key);

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
              width: 10.0,
              height: 10,
              point: lt.LatLng(latitude, longitude),
              builder: (ctx) => Container(
                width: 300.0,
                height: 300.0,
                decoration: BoxDecoration(
                  color: Colors.green,
                  shape: BoxShape.circle,
                ),
              ),
            ),
            ml.Marker(
              width: 120.0,
              height: 90.0,
              point: lt.LatLng(latitude, longitude),
              builder: (ctx) =>
              LocationLabel(eventName,description,90),
                anchorPos: ml.AnchorPos.align(AnchorAlign.top)
            ),
          ],
        ),
      ],
    );
  }
}
