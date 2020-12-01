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
      body: SafeArea(
        child: Column(
          children: [
            IconButton(
              icon: const Icon(Icons.power_settings_new),
              onPressed: () {
                context.read<AuthService>().signOut();
              },
            ),
          ],
        ),
      ),
    );
  }
}
