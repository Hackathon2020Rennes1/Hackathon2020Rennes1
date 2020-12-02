import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'widgets/home_drawer.dart';
import 'widgets/home_main.dart';
import 'widgets/home_search_bar.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _test = TextEditingController();
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        final currentFocus = FocusScope.of(context).enclosingScope;

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        backgroundColor: const Color(0xff2E4053),
        appBar: AppBar(
          backgroundColor: const Color(0xff2E4060),
          title: const Text('Liste des évènements'),
        ),
        drawer: const HomeDrawer(),
        body: ChangeNotifierProvider.value(
          value: _test,
          child: Column(
            children: const [
              HomeSearchBar(),
              Expanded(child: HomeMain()),
            ],
          ),
        ),
      ),
    );
  }
}
