import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/register_input_controller_model.dart';
import 'register_body.dart';
import 'register_bottom.dart';

class RegisterMain extends StatelessWidget {
  const RegisterMain({
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
      child: Provider(
        create: (_) => RegisterInputControllerModel(),
        child: Column(
          children: const [RegisterBody(), RegisterBottom()],
        ),
      ),
    );
  }
}
