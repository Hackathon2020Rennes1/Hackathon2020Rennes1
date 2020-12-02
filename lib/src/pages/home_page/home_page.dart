import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../services/firebase_services/auth_service.dart';

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
      //drawer: const HomeDrawer(),
      //body: const HomeMain(),
      body: SafeArea(
        child: Column(
          children: [
            IconButton(
              icon: const Icon(Icons.power_settings_new),
              onPressed: () {
                context.read<AuthService>().signOut();
              },
            ),
            TextButton(
              child: Text("test event detail page"),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute<void>(builder: (context) => DetailPage(eventId : 'b217feb0-33bb-11eb-9251-aff80825ebfe'))
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
