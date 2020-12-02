
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fete_ta_science/src/pages/tour_page/widgets/event_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MapEvents extends StatelessWidget {
  MapEvents({ Key key }) : super(key: key);

  void update(){
    FirebaseFirestore.instance
        .collection('events')
        .where((e){
            var a = e['geometry']['coordinates'];
            double lat = double.parse(a[1].toString());
            double lon = double.parse(a[0].toString());
            return latitudeMin <= lat && lat <= latitudeMax
                && longitudeMin <= lon && lon <= longitudeMax;
        })
        .get()
        .then((q) { for(var doc in q.docs) events.add(Event.fromDocumentSnapshot(doc)); })
        .catchError((onError)=>{});
  }

  double latitudeMax;
  double latitudeMin;
  double longitudeMin;
  double longitudeMax;

  List<Event> events;

  @override
  Widget build(BuildContext context) {
    //DetailPage(eventId : 'b217feb0-33bb-11eb-9251-aff80825ebfe')
    return Scaffold(
      backgroundColor: const Color(0xff2E4053),
      body: SafeArea(
        child: Container(
            child: Column(children: [
              //Expanded(child: MapWidget(eventId: eventId)),
            ])),
      ),
    );
  }
}