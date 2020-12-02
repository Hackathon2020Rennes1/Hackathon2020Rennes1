import 'package:fete_ta_science/src/pages/list_public_tour_page/widgets/flutter_map_for_a_list_of_events.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ListOwnTourPage extends StatelessWidget {
  const ListOwnTourPage({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var events = List<EventData>();

    return Scaffold(
      backgroundColor: const Color(0xff2E4053),
      body: SafeArea(
        child: Container(
          child: flutterMapEventsTour(
              events : events
          ),
        ),
      ),
    );
  }
}
