import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fete_ta_science/src/pages/detail_page/widgets/map_from_document_snapshot.dart';
import 'package:fete_ta_science/src/pages/detail_page/widgets/map.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
  DetailPage({
    @required this.eventId,
    Key key,
  }) : super(key: key) {
    CollectionReference events = FirebaseFirestore.instance.collection('events');
    events.doc(eventId).get().then((DocumentSnapshot value) => infosEvent = value);
  }

  String eventId;

  DocumentSnapshot infosEvent;

  @override
  Widget build(BuildContext context) {
    //DetailPage(eventId : 'b217feb0-33bb-11eb-9251-aff80825ebfe')
    return Scaffold(
      backgroundColor: const Color(0xff2E4053),
      body: SafeArea(
        child: Container(
            child: Row(children: [
          //MapFromDocumentSnapshot(infosEvent)
          //Expanded(child: CreateFromDocumentSnapshot(eventId, (infosEvent) => MapFromDocumentSnapshot(infosEvent))),
          Expanded(child: MapWidget(eventId)),
        ])),
      ),
    );
  }
}
