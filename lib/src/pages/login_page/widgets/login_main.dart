import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/login_input_controller_model.dart';
import 'login_body.dart';
import 'login_bottom.dart';

class LoginMain extends StatelessWidget {
  const LoginMain({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        final currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: MultiProvider(
        providers: [
          Provider<GlobalKey<FormState>>(create: (_) => GlobalKey<FormState>()),
          Provider<LoginInputControllerModel>(create: (_) => LoginInputControllerModel()),
        ],
        child: Column(
          children: const [LoginBody(), LoginBottom()],
        ),
      ),
    );
  }
}
