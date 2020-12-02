import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeMain extends StatelessWidget {
  const HomeMain({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('events').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return Scrollbar(
          child: ListView(
            children: snapshot.data.docs.map((document) {
              return Card(
                child: ListTile(
                  contentPadding: const EdgeInsets.only(left: 10, top: 5, bottom: 5),
                  title: document.data().containsKey('fields') ? Text(document['fields']['titre_fr'].toString()) : const Text(''),
                ),
              );
            }).toList(),
          ),
        );
      },
    );
  }
}
