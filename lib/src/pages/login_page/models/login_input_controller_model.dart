import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginInputControllerModel {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void dispose() {
    emailController.dispose();
    passwordController.dispose();
  }
}
