import 'package:fete_ta_science/src/pages/detail_page/model/event.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map/src/layer/marker_layer.dart' as ml;
import 'package:latlong/latlong.dart' as lt;

class LocationLabel extends StatelessWidget {
  LocationLabel(this.event, this.height);

  EventMapData event;

  double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
              height: height - 20,
              child: ListView(children: [
                Text(event.name),
                //Divider(color: Colors.grey, thickness: 2),
                //Text(event.description),
              ])),
          Divider(color: Colors.green, thickness: 4)
        ],
      ),
    );
  }
}

class flutterMapEvent extends StatefulWidget {
  flutterMapEvent({
    @required this.events,
    @required this.latitude,
    @required this.longitude,
    this.onPositionCranged = null,
    Key key,
  }) : super(key: key);

  final double latitude, longitude;

  List<EventMapData> events;

  void Function(MapPosition position, bool hasGesture) onPositionCranged;

  @override
  State<flutterMapEvent> createState() => flutterMapEventState();
}

class flutterMapEventState extends State<flutterMapEvent> {
  var _markers = List<ml.Marker>();

  void update() {
    for (var e in widget.events) {
      _markers.add(ml.Marker(
        width: 12.0,
        height: 12,
        point: lt.LatLng(e.latitude, e.longitude),
        builder: (ctx) => Container(
          width: 300.0,
          height: 300.0,
          decoration: BoxDecoration(
            color: Colors.green,
            shape: BoxShape.circle,
          ),
        ),
      ));
      /*
      ml.Marker(
              width: 120.0,
              height: 90.0,
              point: lt.LatLng(latitude, longitude),
              builder: (ctx) =>
              LocationLabel(eventName,description,90),
                anchorPos: ml.AnchorPos.align(AnchorAlign.top)
            ),
       */
    }
  }

  @override
  void initState() {
    update();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: MapOptions(
          center: lt.LatLng(widget.latitude, widget.longitude),
          zoom: 13.0,
          onPositionChanged: (MapPosition position, bool hasGesture) {
            if (widget.onPositionCranged != null) {
              widget.onPositionCranged(position, hasGesture);
              update();
            }
          }),
      layers: [
        TileLayerOptions(urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png", subdomains: ['a', 'b', 'c']),
        MarkerLayerOptions(
          markers: _markers,
        ),
      ],
    );
  }
}
