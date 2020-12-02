import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fete_ta_science/src/pages/list_public_tour_page/widgets/flutter_map_for_a_list_of_events.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class EventInfos{
  String id;
  DocumentSnapshot data;
  dynamic getField(String member){
    data.get(FieldPath(['fields', member]));
  }
  String title(){
    return getField('titre_fr').toString();
  }
}

class EventListWidget extends StatelessWidget {

  EventListWidget({
    @required this.tourId,
    Key key,
  }) : super(key: key){
    // peupler events

  }

  String tourId;

  List<EventInfos> events = List<EventInfos>();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff2E4053),
      appBar: AppBar(
        backgroundColor: const Color(0xff2E4060),
      ),
      body: ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: events.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              color: Colors.pink,// changer la couleur
              child: Center(child: Text('Entry ${events[index].title()}')),
            );
          }
      ),
    );
  }
}