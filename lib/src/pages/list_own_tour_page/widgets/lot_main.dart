import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'lot_body.dart';
import 'lot_title_field.dart';

class ListOwnTourMain extends StatelessWidget {
  const ListOwnTourMain({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        ListOwnTourTitleField(),
        ListOwnTourBody(),
      ],
    );
  }
}
