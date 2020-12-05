import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'left_body.dart';

class ListEventsFromTourMain extends StatelessWidget {
  const ListEventsFromTourMain({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        ListEventsFromTourBody(),
      ],
    );
  }
}
