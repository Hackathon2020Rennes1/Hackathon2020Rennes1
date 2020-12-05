import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../list_events_from_tour_page/list_events_from_tour_page.dart';

class ListPublicTourMain extends StatelessWidget {
  const ListPublicTourMain({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //final _firebaseUser = context.watch<User>();
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('public_tour').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return Scrollbar(
          child: ListView(
            children: snapshot.data.docs.map((document) {
              var events = <String>[];
              if (document.data().containsKey('events')) {
                events = List<String>.from(document['events'] as List<dynamic>);
              }
              return Card(
                child: ListTile(
                  contentPadding: const EdgeInsets.only(left: 10, top: 5, bottom: 5, right: 5),
                  title: document['titre_parcours'] != null
                      ? Text(
                          document['titre_parcours'].toString(),
                          style: const TextStyle(
                            fontSize: 19,
                          ),
                          textAlign: TextAlign.center,
                        )
                      : const Text(''),
                  subtitle: Column(
                    children: [
                      const Padding(padding: EdgeInsets.only(top: 5)),
                      Text('Proposé le ${DateFormat('dd/MM/yyyy à kk:mm').format(DateTime.parse(document['date'].toDate().toString()))}'),
                      Text('Ce parcours contient ${events.length} évènements'),
                      const Padding(padding: EdgeInsets.only(top: 10)),
                      Container(
                        padding: const EdgeInsets.only(top: 5),
                        decoration: const BoxDecoration(
                          border: Border(top: BorderSide(color: Colors.black12, width: 2)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text.rich(
                              TextSpan(
                                style: const TextStyle(fontSize: 16),
                                text: 'Par ',
                                children: [
                                  TextSpan(text: '${document['username']} ', style: const TextStyle(fontWeight: FontWeight.bold)),
                                ],
                              ),
                            ),
                            /*
                            // à voir plus tard pour implémenter un système d'avatar (ne pas oublier les import)
                            CachedNetworkImage(
                              imageUrl: _firebaseUser.photoURL ?? 'empty',
                              height: 64,
                              width: 64,
                              progressIndicatorBuilder: (context, url, downloadProgress) => CircularProgressIndicator(value: downloadProgress.progress),
                              imageBuilder: (context, imageProvider) => Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
                                ),
                              ),
                              errorWidget: (context, url, error) => Container(
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(image: AssetImage('assets/images/profile/avatar-anonym.png'), fit: BoxFit.cover),
                                ),
                              ),
                            ),
                            */
                          ],
                        ),
                      ),
                    ],
                  ),
                  onTap: () {
                    Navigator.push<ListEventsFromTourPage>(
                        context, MaterialPageRoute<ListEventsFromTourPage>(builder: (context) => ListEventsFromTourPage(events: events)));
                  },
                  trailing: const Icon(Icons.arrow_forward_rounded),
                ),
              );
            }).toList(),
          ),
        );
      },
    );
  }
}
