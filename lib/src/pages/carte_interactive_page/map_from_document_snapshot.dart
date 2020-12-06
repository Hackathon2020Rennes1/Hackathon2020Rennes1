import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';

import 'events_flutter_map.dart';
import 'model/event.dart';

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

    return flutterMapEvent(
        events: events,
        bounds: LatLngBounds(LatLng(events[0].latitude - 1, events[0].longitude - 1), LatLng(events[0].latitude + 1, events[0].longitude + 1)));
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
