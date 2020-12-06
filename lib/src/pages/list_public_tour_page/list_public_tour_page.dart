import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'widgets/lpt_main.dart';

class ListPublicTourPage extends StatelessWidget {
  const ListPublicTourPage({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff2E4053),
      appBar: AppBar(
        backgroundColor: const Color(0xff2E4060),
        title: const Text('Parcours publiques'),
      ),
      body: const SafeArea(
        child: ListPublicTourMain(),
      ),
    );
  }
}
