import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fete_ta_science/src/pages/detail_page/widgets/event_google_map.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// parse documentSnapshot data and pass it to MapEvent
class MapFromDocumentSnapshot extends StatelessWidget {

  MapFromDocumentSnapshot(this.documentSnapshot);

  final DocumentSnapshot documentSnapshot;

  @override
  Widget build(BuildContext context) {

    Map<String, dynamic> data = documentSnapshot.data();
    print("MapFromDocumentSnapshot event data : "+data.toString());
    //data['geometry'];
    dynamic point = documentSnapshot.get(FieldPath(['geometry', 'coordinates']));
    print("MapFromDocumentSnapshot events['geometry', 'coordinates'] = "+point.toString());

    String eventName = documentSnapshot.get(FieldPath(['fields', 'titre_fr'])).toString();
    //String eventName = documentSnapshot.get(FieldPath(['fields', 'nom_du_lieu'])).toString();
    String description = documentSnapshot.get(FieldPath(['fields', 'description_fr'])).toString();
    double latitude = double.parse(point[0].toString());
    double longitude = double.parse(point[1].toString());

    print("MapFromDocumentSnapshot events eventName =["+eventName+"] description = ["+description+"] latitude=["+latitude.toString()+"] longitude=["+longitude.toString()+"]");

    return MapEvent(
        eventName: eventName,
        description: description,
        latitude: latitude,
        longitude: longitude);

  }
}

//https://firebase.flutter.dev/docs/firestore/usage/
// prend les informations de la base de données pour creer MapEvent avec les bons parametres
/*class LoadMap extends StatelessWidget {

  LoadMap(this.eventId);

  final String eventId;

  @override
  Widget build(BuildContext context) {
    CollectionReference events = FirebaseFirestore.instance.collection('events');

    return FutureBuilder<DocumentSnapshot>(
        future: events.doc(eventId).get(),
        builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot){

          if (snapshot.hasError) {
            return Text("Something went wrong");
          }

          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data = snapshot.data.data();
            //data['geometry'];
            dynamic point = snapshot.data.get(FieldPath(['geometry', 'coordinates']));
            print("LoadMapFromDataBase events['geometry', 'coordinates'] = "+point.toString());

            String eventName = data['titre_fr'].toString();
            String description = data['description_fr'].toString();
            double latitude = double.parse(point[0].toString());
            double longitude = double.parse(point[1].toString());

            print("LoadMapFromDataBase events eventName =["+eventName+"] description = ["+description+"] latitude=["+latitude.toString()+"] longitude=["+longitude.toString()+"]");

            return MapEvent(
                eventName: eventName,
                description: description,
                latitude: latitude,
                longitude: longitude);
          }

          return Text("loading");
        }
    );

  }
}*/

// exemple d'utilisation :
// CreateFromDocumentSnapshot(eventId,(infosEvent)=>MapFromDocumentSnapshot(infosEvent))
class CreateFromDocumentSnapshot extends StatelessWidget {

  CreateFromDocumentSnapshot(this.id,this.create);

  final String id;
  final Widget Function(DocumentSnapshot) create;

  @override
  Widget build(BuildContext context) {
    CollectionReference events = FirebaseFirestore.instance.collection('events');

    return FutureBuilder<DocumentSnapshot>(
        future: events.doc(id).get(),
        builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot){

          if (snapshot.hasError) {
            return Text("Something went wrong, DocumentSnapshot");
          }

          if (snapshot.connectionState == ConnectionState.done) {
            return create(snapshot.data);
          }

          return Text("loading");
        }
    );

  }
}