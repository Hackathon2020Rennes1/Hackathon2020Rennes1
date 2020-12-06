import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'widgets/lot_main.dart';

class ListOwnTourPage extends StatelessWidget {
  const ListOwnTourPage({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        final currentFocus = FocusScope.of(context).enclosingScope;

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        backgroundColor: const Color(0xff2E4053),
        appBar: AppBar(
          backgroundColor: const Color(0xff2E4060),
          title: const Text('Mon parcours'),
        ),
        body: MultiProvider(
          providers: [
            Provider<GlobalKey<FormState>>(create: (_) => GlobalKey<FormState>()),
            ChangeNotifierProvider<TextEditingController>(create: (_) => TextEditingController()),
            FutureProvider<DocumentSnapshot>.value(value: FirebaseFirestore.instance.collection('users').doc(context.watch<User>().uid).get()),
          ],
          child: const ListOwnTourMain(),
        ),
      ),
    );
  }
}
