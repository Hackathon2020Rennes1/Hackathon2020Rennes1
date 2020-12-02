import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fete_ta_science/src/pages/list_own_tour_page/widgets/tour_list.dart';
import 'package:fete_ta_science/src/pages/tour_page/tour.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ListOwnTourPage extends StatelessWidget {

  ListOwnTourPage({
    this.userId,
    Key key,
  }) : super(key: key);

  String userId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff2E4053),
      body: SafeArea(
          child: Column(
        children: [
          Expanded(child: TourListWidget()),
          IconButton(
            icon: Icon(Icons.add_circle),
            onPressed: () {
              // creer un nouveau chemin et aller à l'écran de ce chemin (tour)
              FirebaseFirestore.instance.collection('users').add({
                'owner': userId,
              })
              .then((DocumentReference newTour) {
                  Navigator.push(// aller dans la page TourWidget
                    context,
                    MaterialPageRoute(builder: (contex)=>TourWidget(id:newTour.id))
                  );
                  final snackBar = SnackBar(content: Text('new tour created !'));
                  Scaffold.of(context).showSnackBar(snackBar);
                }
              )
              .catchError((value) {
                final snackBar = SnackBar(content: Text('error tour creation failed !'));
                Scaffold.of(context).showSnackBar(snackBar);
              });
            },
          )
        ],
      )
          ),
    );
  }
}
