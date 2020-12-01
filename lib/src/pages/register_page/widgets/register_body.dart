import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../widgets_generic/text_form_field_custom.dart';
import '../models/register_input_controller_model.dart';

class RegisterBody extends StatelessWidget {
  const RegisterBody({
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
              top: 60,
              bottom: 50,
            ),
            child: Column(
              children: [
                const Text('Inscription', style: TextStyle(fontSize: 35, color: Colors.blueGrey)),
                Column(
                  children: [
                    TextFormFieldCustom(
                      controller: context.watch<RegisterInputControllerModel>().emailController,
                      textInputType: TextInputType.emailAddress,
                      hintText: 'Email',
                      obscureText: false,
                    ),
                    TextFormFieldCustom(
                      controller: context.watch<RegisterInputControllerModel>().passwordController,
                      textInputType: TextInputType.text,
                      hintText: 'Mot de passe',
                      obscureText: true,
                    ),
                    TextFormFieldCustom(
                      controller: context.watch<RegisterInputControllerModel>().pseudoController,
                      textInputType: TextInputType.text,
                      hintText: 'Pseudo',
                      obscureText: false,
                    ),
                    TextFormFieldCustom(
                      controller: context.watch<RegisterInputControllerModel>().photoUrlController,
                      textInputType: TextInputType.text,
                      hintText: 'URL photo',
                      obscureText: false,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
