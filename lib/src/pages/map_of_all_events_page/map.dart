
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fete_ta_science/src/pages/detail_page/model/event.dart';
import 'package:fete_ta_science/src/pages/detail_page/widgets/events_flutter_map.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map/src/geo/latlng_bounds.dart';
import 'package:latlong/latlong.dart';


class MapEvents extends StatefulWidget {
  MapEvents({ Key key, }) : super(key: key);

  @override
  State<MapEvents> createState() => MapEventsState();

}



class MapEventsState extends State<MapEvents> {

  List<EventMapData> events = List<EventMapData>();

  double longitudeMin = 5.244869 - 1;
  double longitudeMax = 5.244869 + 1;

  double latitudeMin = 46.214168 - 1;
  double latitudeMax = 46.214168 + 1;


  void updateEventList(LatLngBounds bounds){
    //print("MapEvents.update");
    longitudeMin = min(bounds.west,bounds.east);
    longitudeMax = max(bounds.west,bounds.east);
    latitudeMin = min(bounds.north,bounds.south);
    latitudeMax = max(bounds.north,bounds.south);
    /*print("latitudeMin = "+latitudeMin.toString());
    print("latitudeMax = "+latitudeMax.toString());
    print("longitudeMin = "+longitudeMin.toString());
    print("longitudeMax = "+longitudeMax.toString());*/

    FirebaseFirestore.instance
        .collection('events')
        .get()
        .then((query){
      events.clear();
      for(var e in query.docs){
        var a = e['geometry']['coordinates'];
        double lat = double.parse(a[1].toString());
        double lon = double.parse(a[0].toString());
        if(latitudeMin <= lat && lat <= latitudeMax
            && longitudeMin <= lon && lon <= longitudeMax)
          events.add(EventMapData.fromDocumentSnapshot(e));
      }
      print("events.size final = "+events.length.toString());
      //setState(() { });
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: const Color(0xff2E4053),
      body: SafeArea(
        child: Container(
            child: Column(children: [
              Expanded(child:
                flutterMapEvent(
                  //events:buildEvents(),
                  events:events,
                  bounds: LatLngBounds(
                      LatLng(latitudeMin, longitudeMin),
                      LatLng(latitudeMax, longitudeMax)
                  ),
                  onPositionCranged: (MapPosition position, bool hasGesture) {
                    updateEventList(position.bounds);
                  },
                  onReady: (MapController mc)async{
                    if(!_firstLoad) return;
                    _firstLoad = false;
                    updateEventList(mc.bounds);
                    setState(() { });
                  },
                )
              )
            ])),
      ),
    );
  }
  bool _firstLoad = true;
}