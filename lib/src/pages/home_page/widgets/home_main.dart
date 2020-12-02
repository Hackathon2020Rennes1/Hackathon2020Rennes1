import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../detail_page/detail.dart';

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
            children: snapshot.data.docs
                .where((document) =>
                    document['fields']['nom_du_lieu']
                        .toString()
                        .toLowerCase()
                        .contains(context.watch<TextEditingController>().text.trim().toLowerCase()) ||
                    document['fields']['thematiques']
                        .toString()
                        .toLowerCase()
                        .contains(context.watch<TextEditingController>().text.trim().toLowerCase()) ||
                    document['fields']['resume_dates_fr']
                        .toString()
                        .toLowerCase()
                        .contains(context.watch<TextEditingController>().text.trim().toLowerCase()) ||
                    document['fields']['mots_cles_fr']
                        .toString()
                        .toLowerCase()
                        .contains(context.watch<TextEditingController>().text.trim().toLowerCase()))
                .map((document) {
              return Card(
                child: ListTile(
                  leading: CachedNetworkImage(
                    imageUrl: document['fields']['apercu'].toString(),
                    progressIndicatorBuilder: (context, url, downloadProgress) => CircularProgressIndicator(value: downloadProgress.progress),
                    errorWidget: (context, url, error) => const Icon(Icons.error),
                  ),
                  contentPadding: const EdgeInsets.only(left: 10, top: 5, bottom: 5, right: 5),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(padding: EdgeInsets.only(top: 5)),
                      if (document['fields']['ville'] != null)
                        Text.rich(TextSpan(text: 'Ville: ', style: const TextStyle(fontWeight: FontWeight.bold), children: [
                          TextSpan(
                            text: document['fields']['ville'].toString(),
                            style: const TextStyle(fontWeight: FontWeight.normal),
                          )
                        ])),
                      if (document['fields']['nom_du_lieu'] != null)
                        Text.rich(TextSpan(text: 'Lieu: ', style: const TextStyle(fontWeight: FontWeight.bold), children: [
                          TextSpan(
                            text: document['fields']['nom_du_lieu'].toString(),
                            style: const TextStyle(fontWeight: FontWeight.normal),
                          )
                        ])),
                      const Padding(padding: EdgeInsets.only(top: 5)),
                      if (document['fields']['horaires_detailles_fr'] != null)
                        Text.rich(TextSpan(text: 'Horaires: ', style: const TextStyle(fontWeight: FontWeight.bold), children: [
                          TextSpan(
                            text: document['fields']['horaires_detailles_fr'].toString(),
                            style: const TextStyle(fontWeight: FontWeight.normal),
                          )
                        ])),
                    ],
                  ),
                  onTap: () {
                    Navigator.push<Detail>(context, MaterialPageRoute<Detail>(builder: (context) => Detail(queryDocumentSnapshot: document,)));
                  },
                  title: document['fields']['titre_fr'] != null ? Text(document['fields']['titre_fr'].toString()) : const Text(''),
                ),
              );
            }).toList(),
          ),
        );
      },
    );
  }
}
