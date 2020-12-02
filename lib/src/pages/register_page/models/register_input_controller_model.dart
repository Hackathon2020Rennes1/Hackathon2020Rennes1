import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RegisterInputControllerModel {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController pseudoController = TextEditingController();
  final TextEditingController photoUrlController = TextEditingController();

  void dispose()
  {
    emailController.dispose();
    passwordController.dispose();
    pseudoController.dispose();
    photoUrlController.dispose();
  }
}
