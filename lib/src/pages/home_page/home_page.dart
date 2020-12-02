import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
      ),
      drawer: const HomeDrawer(),
      body: const HomeMain(),
    );
  }
}
