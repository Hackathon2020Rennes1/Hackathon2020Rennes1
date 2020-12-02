import 'package:fete_ta_science/src/pages/detail_page/widgets/map_from_document_snapshot.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MapWidget extends StatelessWidget {
  MapWidget({@required this.eventId, Key key}) : super(key: key);

  final String eventId;

  @override
  Widget build(BuildContext context) {
    return CreateFromDocumentSnapshot(eventId, (infosEvent) => MapFromDocumentSnapshot(infosEvent));
  }
}
