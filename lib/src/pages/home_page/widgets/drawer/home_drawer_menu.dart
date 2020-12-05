import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../list_own_tour_page/list_own_tour_page.dart';
import '../../../list_public_tour_page/list_public_tour_page.dart';
import '../../../map_of_all_events_page/map.dart';

class HomeDrawerMenu extends StatelessWidget {
  const HomeDrawerMenu({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        RaisedButton.icon(
          onPressed: () {
            Navigator.push<ListPublicTourPage>(context, MaterialPageRoute<ListPublicTourPage>(builder: (context) => const ListPublicTourPage()));
          },
          icon: const Icon(Icons.directions_walk),
          label: const Text('Parcours publiques', style: TextStyle(fontSize: 17)),
          padding: const EdgeInsets.only(top: 15, bottom: 15),
          shape: const RoundedRectangleBorder(),
        ),
        RaisedButton.icon(
          onPressed: () {
            Navigator.push<ListOwnTourPage>(context, MaterialPageRoute<ListOwnTourPage>(builder: (context) => const ListOwnTourPage()));
          },
          icon: const Icon(Icons.directions_run),
          label: const Text('Mon parcours', style: TextStyle(fontSize: 17)),
          padding: const EdgeInsets.only(top: 15, bottom: 15),
          shape: const RoundedRectangleBorder(),
        ),
        RaisedButton.icon(
          onPressed: () {
            Navigator.push<MapEvents>(context, MaterialPageRoute<MapEvents>(builder: (context) => MapEvents()));
          },
          icon: const Icon(Icons.place_outlined),
          label: const Text('Carte interactive', style: TextStyle(fontSize: 17)),
          padding: const EdgeInsets.only(top: 15, bottom: 15),
          shape: const RoundedRectangleBorder(),
        ),
      ],
    );
  }
}
