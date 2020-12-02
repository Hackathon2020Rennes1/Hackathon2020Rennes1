import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../detail_page/detail_page.dart';
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
        // Temporaire pour vos tests
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            FocusScope.of(context).unfocus();
            Navigator.push(context, MaterialPageRoute<void>(builder: (context) => DetailPage(eventId: 'b217feb0-33bb-11eb-9251-aff80825ebfe')));
          },
          child: const Icon(Icons.arrow_forward_rounded),
        ),
      ),
    );
  }
}
