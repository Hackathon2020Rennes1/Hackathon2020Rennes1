import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../services/firebase_services/auth_service.dart';
import '../../register_page/register_page.dart';
import '../models/login_input_controller_model.dart';

class LoginBottom extends StatelessWidget {
  const LoginBottom({
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
              if (context.read<GlobalKey<FormState>>().currentState.validate()) {
                context
                    .read<AuthService>()
                    .signIn(
                      email: context.read<LoginInputControllerModel>().emailController.text.trim(),
                      password: context.read<LoginInputControllerModel>().passwordController.text.trim(),
                    )
                    .then((value) {
                  if (value == 'Signed in') {
                    // Ne fonctionne pas, mieux vaut utiliser un StatefulWidget et dispose()
                    //context.read<LoginInputControllerModel>().dispose();
                  }
                });
              }
            },
            icon: const Icon(Icons.arrow_forward_rounded),
            label: const Text('Connexion'),
            color: Colors.deepOrangeAccent,
          ),
          const Padding(padding: EdgeInsets.only(top: 5)),
          GestureDetector(
            onTap: () {
              Navigator.push<RegisterPage>(context, MaterialPageRoute<RegisterPage>(builder: (context) => const RegisterPage()));
            },
            child: const Text.rich(TextSpan(text: 'Pas de compte ? ', style: TextStyle(color: Colors.white70), children: [
              TextSpan(
                text: 'Inscrivez-vous.',
                style: TextStyle(color: Colors.white70, fontWeight: FontWeight.bold, decoration: TextDecoration.underline),
              )
            ])),
          ),
        ],
      ),
    );
  }
}
