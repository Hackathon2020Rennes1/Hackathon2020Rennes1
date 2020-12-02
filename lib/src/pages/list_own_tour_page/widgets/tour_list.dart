import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fete_ta_science/src/pages/list_public_tour_page/widgets/flutter_map_for_a_list_of_events.dart';
import 'package:fete_ta_science/src/pages/tour_page/widgets/event_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Tour {

  DocumentSnapshot snapshot;

  var events = List<EventInfos>();

  String stringEvents() {
    return events.join(', ');
  }

  Tour(this.snapshot){
    for(int i = 0; i<snapshot.data().length;i++){
      events.add(EventInfos.fromId(snapshot[i].toString()));
    }
  }
}

class TourListWidget extends StatelessWidget {

  TourListWidget(BuildContext context,this.userId) {
    // peupler tours
    FirebaseFirestore.instance
        .collection('tours')
        .where('owner', isEqualTo: userId)
        .get()
        .then((QuerySnapshot q) {

          for(var t in q.docs) tours.add(Tour(t));

        } )
        .catchError((value) {
          final snackBar = SnackBar(content: Text('error retriving list of tours from data-base'),backgroundColor: Colors.red,);
          Scaffold.of(context).showSnackBar(snackBar);
        });
  }

  String userId;

  List<Tour> tours = List<Tour>();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: tours.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            color: Colors.pink, // changer la couleur
            child: Center(child: Text('Entry ${tours[index].stringEvents()}')),
          );
        });
  }
}
