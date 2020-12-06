import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListOwnTourTitleField extends StatelessWidget {
  const ListOwnTourTitleField({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(padding: EdgeInsets.only(top: 15)),
        const Text(
          'Titre du parcours',
          style: TextStyle(fontSize: 20, color: Colors.white70),
        ),
        const Padding(padding: EdgeInsets.only(top: 15)),
        Container(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Form(
            key: context.watch<GlobalKey<FormState>>(),
            child: TextFormField(
              controller: context.watch<TextEditingController>(),
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.text_snippet_outlined),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(),
                hintText: 'Indiquez le titre du parcours',
              ),
              keyboardType: TextInputType.text,
              validator: (value) {
                if (value.isEmpty) {
                  return 'Valeur manquante.';
                }

                return null;
              },
            ),
          ),
        ),
        const Padding(padding: EdgeInsets.only(top: 5)),
        RaisedButton.icon(
          color: Colors.green,
          onPressed: () {
            if (context.read<GlobalKey<FormState>>().currentState.validate()) {
              // TODO PUBLIER DANS PUBLIQUE
            }
          },
          icon: const Icon(Icons.add),
          label: const Text('Publier parcours'),
        )
      ],
    );
  }
}
