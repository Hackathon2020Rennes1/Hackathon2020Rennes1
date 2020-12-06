import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
          onPressed: () async {
            if (context.read<GlobalKey<FormState>>().currentState.validate()) {
              final userSnapshot = context.read<DocumentSnapshot>();

              if (userSnapshot.data() == null || !userSnapshot.data().containsKey('tour') || userSnapshot['tour']['events'] == null) {
                const snackBar = SnackBar(
                  content: Text("Pas d'évènements dans la liste"),
                  backgroundColor: Colors.redAccent,
                );
                Scaffold.of(context).showSnackBar(snackBar);

                return;
              }

              var events = <String>[];

              if (userSnapshot.data().containsKey('tour') && userSnapshot['tour']['events'] != null) {
                events = List<String>.from(userSnapshot['tour']['events'] as List<dynamic>);
              }

              if (events.isEmpty) {
                const snackBar = SnackBar(
                  content: Text("Pas d'évènements dans la liste"),
                  backgroundColor: Colors.redAccent,
                );
                Scaffold.of(context).showSnackBar(snackBar);

                return;
              }

              final parcours = {
                'date': DateTime.now(),
                'events': userSnapshot['tour']['events'],
                'titre_parcours': context.read<TextEditingController>().text.toString(),
                'username': context.read<User>().displayName,
              };

              await FirebaseFirestore.instance.collection('public_tour').add(parcours);
              await FirebaseFirestore.instance.collection('users').doc(context.read<User>().uid).update({'tour.events': []});
              Navigator.pop(context);
            }
          },
          icon: const Icon(Icons.add),
          label: const Text('Publier parcours'),
        )
      ],
    );
  }
}
