import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:validators/validators.dart' as validators;

import '../../../widgets_generic/text_form_field_custom.dart';
import '../models/login_input_controller_model.dart';

class LoginBody extends StatelessWidget {
  const LoginBody({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 8,
      child: Container(
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(40),
              bottomRight: Radius.circular(40),
            )),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(
              top: 150,
              bottom: 50,
            ),
            child: Column(
              children: [
                const Text('Connexion', style: TextStyle(fontSize: 35, color: Colors.blueGrey)),
                Form(
                  key: context.watch<GlobalKey<FormState>>(),
                  child: Column(
                    children: [
                      TextFormFieldCustom(
                        controller: context.watch<LoginInputControllerModel>().emailController,
                        textInputType: TextInputType.emailAddress,
                        hintText: 'Email',
                        obscureText: false,
                        validator: (value) {
                          if (!validators.isEmail(value)) {
                            return 'Email invalide';
                          }
                          return null;
                        },
                      ),
                      TextFormFieldCustom(
                        controller: context.watch<LoginInputControllerModel>().passwordController,
                        textInputType: TextInputType.text,
                        hintText: 'Mot de passe',
                        obscureText: true,
                        validator: (value) {
                          if (value.length < 6) {
                            return 'Taille du mot de passe invalide.';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
