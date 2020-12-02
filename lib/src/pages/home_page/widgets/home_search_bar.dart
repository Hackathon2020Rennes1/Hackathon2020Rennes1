import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeSearchBar extends StatelessWidget {
  const HomeSearchBar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: context.watch<TextEditingController>(),
      style: const TextStyle(color: Colors.white),
      decoration: const InputDecoration(
        hintStyle: TextStyle(color: Colors.white),
        hintText: 'Recherche par mot clé',
        prefixIcon: Icon(Icons.search, color: Colors.white),
      ),
      keyboardType: TextInputType.text,
    );
  }
}
