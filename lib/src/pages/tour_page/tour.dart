import 'package:fete_ta_science/src/pages/tour_page/widgets/event_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class TourWidget extends StatelessWidget {

  TourWidget({
    @required this.id, Key key,
  }) : super(key: key);

  String id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff2E4053),
      appBar: AppBar(
        backgroundColor: const Color(0xff2E4060),
      ),
      body: Column(
        children: [
          Expanded(
              child:EventListWidget(tourId:id),
          ),
          IconButton(
            icon: Icon(Icons.add_circle),
            onPressed: (){
              // aller à une selection d'events pour l'ajouter à ce tour

            },
          )
        ],
      ),

    );
  }
}