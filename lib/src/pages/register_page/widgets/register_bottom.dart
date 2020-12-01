import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../services/firebase_services/auth_service.dart';
import '../models/register_input_controller_model.dart';

class RegisterBottom extends StatelessWidget {
  const RegisterBottom({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RaisedButton.icon(
            onPressed: () {
              context.read<AuthService>().signUp(
                    email: context.read<RegisterInputControllerModel>().emailController.text.trim(),
                    password: context.read<RegisterInputControllerModel>().passwordController.text.trim(),
                    pseudo: context.read<RegisterInputControllerModel>().pseudoController.text.trim(),
                    photoUrl: context.read<RegisterInputControllerModel>().photoUrlController.text.trim(),
                  );
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_forward_rounded),
            label: const Text('Inscription'),
            color: Colors.deepOrangeAccent,
          ),
          const Padding(padding: EdgeInsets.only(top: 5)),
        ],
      ),
    );
  }
}
