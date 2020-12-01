import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'widgets/register_main.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff2E4053),
      appBar: AppBar(
        backgroundColor: const Color(0xff2E4060),
      ),
      body: const SafeArea(
        child: RegisterMain(),
      ),
    );
  }
}
