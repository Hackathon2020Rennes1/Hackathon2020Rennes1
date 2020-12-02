import 'package:fete_ta_science/src/pages/list_own_tour_page/widgets/tour_list.dart';
import 'package:fete_ta_science/src/pages/list_public_tour_page/widgets/flutter_map_for_a_list_of_events.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class ListOwnTourPage extends StatelessWidget {

  ListOwnTourPage({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: const Color(0xff2E4053),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
                child:TourListWidget()
            ),
            IconButton(
              icon: Icon(Icons.add_circle),
              onPressed: (){
                // creer un nouveau chemin et aller à l'écran de ce chemin (tour)
              },
            )
          ],
        )
        /*child: Container(
          child: flutterMapEventsTour(
              events : events
          ),
        ),*/
      ),
    );
  }
}
