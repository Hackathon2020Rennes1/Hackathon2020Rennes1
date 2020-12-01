import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'widgets/login_main.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xff2E4053),
      body: SafeArea(
        child: LoginMain(),
      ),
    );
  }
}
