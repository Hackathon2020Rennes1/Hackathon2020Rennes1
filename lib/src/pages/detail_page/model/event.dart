

import 'package:cloud_firestore/cloud_firestore.dart';

// on ne pend pas tous le DocummentSnapshot pour ne pas prendre trop de mémoire
class EventMapData{

  EventMapData(this.name,this.latitude,this.longitude);

  EventMapData.fromDocumentSnapshot(DocumentSnapshot doc){
    Map<String, dynamic> data = doc.data();
    //print("EventMapData event data : " + data.toString());

    dynamic point = doc.get(FieldPath(['geometry', 'coordinates']));
    //print("MapFromDocumentSnapshot events['geometry', 'coordinates'] = " + point.toString());
    latitude = double.parse(point[1].toString());
    longitude = double.parse(point[0].toString());

    name = doc.get(FieldPath(['fields', 'titre_fr'])).toString();
    //name = documentSnapshot.get(FieldPath(['fields', 'nom_du_lieu'])).toString();
    //String description = doc.get(FieldPath(['fields', 'description_fr'])).toString();

    /*print("MapFromDocumentSnapshot events eventName =[" +
        name +
        "] description = [" +
        //description +
        "] latitude=[" +
        latitude.toString() +
        "] longitude=[" +
        longitude.toString() +
        "]");*/

  }

  String name;
  double latitude, longitude;
}