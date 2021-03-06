import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'home_body.dart';
import 'home_search_bar.dart';

class HomeMain extends StatelessWidget {
  const HomeMain({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        HomeSearchBar(),
        HomeBody(),
      ],
    );
  }
}
