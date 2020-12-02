import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'flutter_map_for_an_event.dart';

// parse documentSnapshot data and pass it to MapEvent
class MapFromDocumentSnapshot extends StatelessWidget {
  MapFromDocumentSnapshot(this.documentSnapshot);

  final DocumentSnapshot documentSnapshot;

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> data = documentSnapshot.data();
    print("MapFromDocumentSnapshot event data : " + data.toString());

    dynamic point = documentSnapshot.get(FieldPath(['geometry', 'coordinates']));
    //print("MapFromDocumentSnapshot events['geometry', 'coordinates'] = " + point.toString());

    String eventName = documentSnapshot.get(FieldPath(['fields', 'titre_fr'])).toString();
    //String eventName = documentSnapshot.get(FieldPath(['fields', 'nom_du_lieu'])).toString();
    String description = documentSnapshot.get(FieldPath(['fields', 'description_fr'])).toString();
    double latitude = double.parse(point[1].toString());
    double longitude = double.parse(point[0].toString());

    /*print("MapFromDocumentSnapshot events eventName =[" +
        eventName +
        "] description = [" +
        description +
        "] latitude=[" +
        latitude.toString() +
        "] longitude=[" +
        longitude.toString() +
        "]");*/

    // version google map
    //return GoogleMapForEvent(eventName: eventName, description: description, latitude: latitude, longitude: longitude);

    return flutterMapEvent(eventName: eventName, description: description, latitude: latitude, longitude: longitude);
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
