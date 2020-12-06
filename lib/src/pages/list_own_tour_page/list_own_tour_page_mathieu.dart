import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../tour_page/tour.dart';
import 'widgets/tour_list.dart';

class ListOwnTourPageMathieu extends StatelessWidget {
  const ListOwnTourPageMathieu({
    Key key,
    this.userId,
  }) : super(key: key);

  final String userId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff2E4053),
      appBar: AppBar(
        backgroundColor: const Color(0xff2E4060),
        title: const Text('Mes parcours'),
      ),
      body: SafeArea(
          child: Column(
        children: [
          Expanded(child: TourListWidget(context, userId)),
          IconButton(
            icon: Icon(Icons.add_circle),
            onPressed: () {
              // creer un nouveau chemin et aller à l'écran de ce chemin (tour)
              FirebaseFirestore.instance.collection('tours').add({
                'owner': userId,
              }).then((DocumentReference newTour) {
                Navigator.push(
                    // aller dans la page TourWidget
                    context,
                    MaterialPageRoute(builder: (contex) => TourWidget(id: newTour.id)));
                final snackBar = SnackBar(content: Text('new tour created !'));
                Scaffold.of(context).showSnackBar(snackBar);
              }).catchError((value) {
                final snackBar = SnackBar(content: Text('error tour creation failed !'));
                Scaffold.of(context).showSnackBar(snackBar);
              });
            },
          )
        ],
      )),
    );
  }
}
