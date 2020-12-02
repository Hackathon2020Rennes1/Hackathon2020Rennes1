
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fete_ta_science/src/pages/detail_page/model/event.dart';
import 'package:fete_ta_science/src/pages/detail_page/widgets/flutter_map_for_an_event.dart';
import 'package:fete_ta_science/src/pages/tour_page/widgets/event_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';

//.where((e){
/*   var a = e['geometry']['coordinates'];
            double lat = double.parse(a[1].toString());
            double lon = double.parse(a[0].toString());
            return latitudeMin <= lat && lat <= latitudeMax
                && longitudeMin <= lon && lon <= longitudeMax;
        })
        .get()
        .then((q) { for(var doc in q.docs) events.add(EventMapData.fromDocumentSnapshot(doc)); })
        .catchError((onError)=>{});*/

/* snapshot.data.docs
            .where((document) =>
            document['fields']['nom_du_lieu']*/

//.then((q) { for(var doc in q) events.add(EventMapData.fromDocumentSnapshot(doc)); });
//.get()

class MapEvents extends StatelessWidget {
  MapEvents({ Key key }) : super(key: key);

  void update(MapPosition position, bool hasGesture){
    print("MapEvents.update");
    longitudeMin = min(position.bounds.west,position.bounds.east);
    longitudeMax = max(position.bounds.west,position.bounds.east);
    latitudeMin = min(position.bounds.north,position.bounds.south);
    latitudeMax = max(position.bounds.north,position.bounds.south);
    print("latitudeMin = "+latitudeMin.toString());
    print("latitudeMax = "+latitudeMax.toString());
    print("longitudeMin = "+longitudeMin.toString());
    print("longitudeMax = "+longitudeMax.toString());
    events.clear();
    FirebaseFirestore.instance
        .collection('events')
        .snapshots().every(
            (q) {
              print("q ====== "+q.docs.toString());
                q.docs.where((e){
                    //print("e ==== "+e.toString());
                    //print("e ==== "+e.toString());
                    var a = e['geometry']['coordinates'];
                    double lat = double.parse(a[1].toString());
                    double lon = double.parse(a[0].toString());
                    print("lat ==== "+lat.toString());
                    print("lon ==== "+lon.toString());
                    if(latitudeMin <= lat && lat <= latitudeMax
                    && longitudeMin <= lon && lon <= longitudeMax)  {
                        //print("aaaaaaaaaaabbbbbbbbbbbbbbb");
                        events.add(EventMapData.fromDocumentSnapshot(e));
                        print(lat.toString() + "events.size = "+events.last.latitude.toString());
                        print(log.toString() + "events.size = "+events.last.longitude.toString());
                        print("events.size = "+events.length.toString());
                      }
                    return true;
                  }

                ).forEach((e) {
                  events.add(EventMapData.fromDocumentSnapshot(e));
                  print("events.size = "+events.length.toString());

                }
                );
                return true;
            }
              ).catchError((a){
                print("eeeeeeeerrrorr "+a.toString());
            }).catchError((a){
      print("eeeeeeeerrrorr "+a.toString());
    }).then((value) => null);
      print("events.size final = "+events.length.toString());

  }


  double longitudeMin = 46.214168-1;
  double longitudeMax = 46.214168+1;

  double latitudeMin = 5.244869 -1;
  double latitudeMax = 5.244869 +1;

  var events = List<EventMapData>();

  @override
  Widget build(BuildContext context) {
    //DetailPage(eventId : 'b217feb0-33bb-11eb-9251-aff80825ebfe')
    return Scaffold(
      backgroundColor: const Color(0xff2E4053),
      body: SafeArea(
        child: Container(
            child: Column(children: [
              Expanded(child:
                flutterMapEvent(
                  events:events,
                  latitude: .5*(latitudeMax+latitudeMin),
                  longitude: .5*(longitudeMax+longitudeMin),
                  onPositionCranged: (MapPosition position, bool hasGesture)=>update(position, hasGesture),
                )
              )
            ])),
      ),
    );
  }
}