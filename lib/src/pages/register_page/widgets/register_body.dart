import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../widgets_generic/text_form_field_custom.dart';

class RegisterBody extends StatelessWidget {
  const RegisterBody({
    @required TextEditingController emailController,
    @required TextEditingController passwordController,
    @required TextEditingController pseudoController,
    @required TextEditingController photoUrlController,
    Key key,
  })  : _emailController = emailController,
        _passwordController = passwordController,
        _pseudoController = pseudoController,
        _photoUrlController = photoUrlController,
        super(key: key);

  final TextEditingController _emailController;
  final TextEditingController _passwordController;
  final TextEditingController _pseudoController;
  final TextEditingController _photoUrlController;

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
                      controller: _emailController,
                      textInputType: TextInputType.emailAddress,
                      hintText: 'Email',
                      obscureText: false,
                    ),
                    TextFormFieldCustom(
                      controller: _passwordController,
                      textInputType: TextInputType.text,
                      hintText: 'Mot de passe',
                      obscureText: true,
                    ),
                    TextFormFieldCustom(
                      controller: _pseudoController,
                      textInputType: TextInputType.text,
                      hintText: 'Pseudo',
                      obscureText: false,
                    ),
                    TextFormFieldCustom(
                      controller: _photoUrlController,
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
