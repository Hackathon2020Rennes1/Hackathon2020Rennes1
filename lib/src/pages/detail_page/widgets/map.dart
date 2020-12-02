import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fete_ta_science/src/pages/detail_page/widgets/google_map_for_an_event.dart';
import 'package:fete_ta_science/src/pages/detail_page/widgets/map_from_document_snapshot.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'flutter_map_for_an_event.dart';

class MapWidget extends StatelessWidget {

  MapWidget(this.eventId);

  final String eventId;

  @override
  Widget build(BuildContext context) {
    return CreateFromDocumentSnapshot(
            eventId,
            (infosEvent) => MapFromDocumentSnapshot(infosEvent)
    );
  }
}
