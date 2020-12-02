import 'package:fete_ta_science/src/pages/detail_page/detail_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../detail_page/detail_page.dart';
import 'widgets/home_drawer.dart';
import 'widgets/home_main.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff2E4053),
      appBar: AppBar(
        backgroundColor: const Color(0xff2E4060),
        title: const Text('Liste des évènements'),
      ),
      drawer: const HomeDrawer(),
      body: const HomeMain(),
      // Temporaire pour vos tests
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute<void>(builder: (context) => DetailPage(eventId: 'b217feb0-33bb-11eb-9251-aff80825ebfe')));
        },
        child: const Icon(Icons.arrow_forward_rounded),
      ),
    );
  }
}
