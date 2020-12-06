import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fete_ta_science/src/pages/detail_page/model/event.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'flutter_map_for_an_event.dart';

// parse documentSnapshot data and pass it to MapEvent
class MapFromDocumentSnapshot extends StatelessWidget {
  MapFromDocumentSnapshot(this.documentSnapshot);

  final DocumentSnapshot documentSnapshot;

  @override
  Widget build(BuildContext context) {
    // version google map
    //return GoogleMapForEvent(eventName: eventName, description: description, latitude: latitude, longitude: longitude);

    var events = List<EventMapData>();
    //events.add(EventMapData.fromDocumentSnapshot(eventName,latitude,longitude));
    events.add(EventMapData.fromDocumentSnapshot(documentSnapshot));

    return flutterMapEvent(events: events, latitude: events[0].latitude, longitude: events[0].longitude);
  }
}

// exemple d'utilisation :
// CreateFromDocumentSnapshot(eventId,(infosEvent)=>MapFromDocumentSnapshot(infosEvent))
class CreateFromDocumentSnapshot extends StatelessWidget {
  CreateFromDocumentSnapshot(this.id, this.create);

  final String id;
  final Widget Function(DocumentSnapshot) create;

  @override
  Widget build(BuildContext context) {
    CollectionReference events = FirebaseFirestore.instance.collection('events');

    return FutureBuilder<DocumentSnapshot>(
        future: events.doc(id).get(),
        builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text("Something went wrong, no DocumentSnapshot received from data-base");
          }

          if (snapshot.connectionState == ConnectionState.done) {
            return create(snapshot.data);
          }

          return Text("loading");
        });
  }
}
