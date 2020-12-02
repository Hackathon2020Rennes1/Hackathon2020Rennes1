import 'package:fete_ta_science/src/pages/list_public_tour_page/widgets/flutter_map_for_a_list_of_events.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Tour {
  List<EventData> events = List<EventData>();

  String stringEvents() {
    return events.join(', ');
  }
}

class TourListWidget extends StatelessWidget {
  TourListWidget() {
    // peupler tours
  }

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
