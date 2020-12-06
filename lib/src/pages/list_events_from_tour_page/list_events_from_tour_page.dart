import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'widgets/left_main.dart';

class ListEventsFromTourPage extends StatelessWidget {
  const ListEventsFromTourPage({
    @required String titre,
    @required List<String> events,
    Key key,
  })  : _events = events,
        _titre = titre,
        super(key: key);

  final String _titre;
  final List<String> _events;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff2E4053),
      appBar: AppBar(
        backgroundColor: const Color(0xff2E4060),
        title: Text(_titre),
      ),
      body: SafeArea(
        child: Provider.value(value: _events, child: const ListEventsFromTourMain()),
      ),
    );
  }
}
