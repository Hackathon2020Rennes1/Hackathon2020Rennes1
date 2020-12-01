import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fete_ta_science/src/pages/detail_page/widgets/load_map.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class DetailPage extends StatelessWidget {

  DetailPage({
    @required this.eventId,
    Key key,
  }) : super(key: key){

    CollectionReference events = FirebaseFirestore.instance.collection('events');
    events.doc(eventId).get().then(
            (DocumentSnapshot value) => infosEvent = value
    );
  }

  String eventId;

  DocumentSnapshot infosEvent;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff2E4053),
      body: SafeArea(
        child: Container(
          child: Row(
           children: [
             MapFromDocumentSnapshot(infosEvent)
           ]
          )
        ),
      ),
    );
  }
}
