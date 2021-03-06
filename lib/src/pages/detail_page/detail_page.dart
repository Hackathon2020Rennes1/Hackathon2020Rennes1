import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class Detail extends StatelessWidget {
  const Detail({
    @required String id,
    Key key,
  })  : _id = id,
        super(key: key);

  final String _id;

  Future<bool> _launchURL(String url) async {
    if (await canLaunch(url)) {
      return launch(url);
    } else {
      final Error error = ArgumentError('Could not launch $url');
      throw error;
    }
  }

  @override
  Widget build(BuildContext context) {
    final _firebaseUser = context.watch<User>();
    final _ratingKey = GlobalKey<_RatingTextState>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Détail'),
        backgroundColor: const Color(0xff2E4060),
      ),
      backgroundColor: Colors.white,
      body: FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance.collection('users').doc(context.watch<User>().uid).get(),
        builder: (context, userSnapshot) {
          return StreamBuilder<DocumentSnapshot>(
              stream: FirebaseFirestore.instance.collection('events').doc(_id).get().asStream(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                var events = <String>[];

                if (userSnapshot.data.data().containsKey('tour') && userSnapshot.data['tour']['events'] != null) {
                  events = List<String>.from(userSnapshot.data['tour']['events'] as List<dynamic>);
                }

                return SafeArea(
                  child: ListView(
                    children: [
                      CachedNetworkImage(
                        imageUrl: snapshot.data['fields']['image'].toString(),
                        progressIndicatorBuilder: (context, url, downloadProgress) => CircularProgressIndicator(value: downloadProgress.progress),
                        errorWidget: (context, url, error) => const Icon(Icons.error),
                      ),
                      if (snapshot.data['fields']['titre_fr'] != null)
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 7, 10, 5),
                          child: Text(
                            snapshot.data['fields']['titre_fr'].toString(),
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      Container(
                        padding: const EdgeInsets.fromLTRB(10, 5, 7, 5),
                        child: Column(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (snapshot.data['fields']['tranche'] != null)
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.accessibility_new,
                                        size: 30,
                                        color: Colors.blue[900],
                                      ),
                                      const Padding(
                                        padding: EdgeInsets.only(left: 5),
                                      ),
                                      Text(
                                        'De ${snapshot.data['fields']['tranche'].toString().split('-')[0]} à ${snapshot.data['fields']['tranche'].toString().split('-')[1]} ans',
                                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal, color: Colors.grey[600]),
                                      )
                                    ],
                                  ),
                                if (snapshot.data['fields']['adresse'] != null)
                                  Column(children: [
                                    const Padding(
                                      padding: EdgeInsets.only(top: 5),
                                    ),
                                    Row(
                                      children: [
                                        Icon(Icons.location_on, size: 30, color: Colors.blue[900]),
                                        const Padding(
                                          padding: EdgeInsets.only(left: 5),
                                        ),
                                        Flexible(
                                            child: Text(
                                          snapshot.data['fields']['adresse'].toString(),
                                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal, color: Colors.grey[600]),
                                        )),
                                      ],
                                    ),
                                  ]),
                                if (snapshot.data['fields']['horaires_detailles_fr'] != null)
                                  Column(children: [
                                    const Padding(
                                      padding: EdgeInsets.only(top: 5),
                                    ),
                                    Row(
                                      children: [
                                        Icon(Icons.calendar_today, size: 30, color: Colors.blue[900]),
                                        const Padding(
                                          padding: EdgeInsets.only(left: 5),
                                        ),
                                        Flexible(
                                            child: Text(
                                          snapshot.data['fields']['horaires_detailles_fr'].toString(),
                                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal, color: Colors.grey[600]),
                                        )),
                                      ],
                                    ),
                                  ]),
                                if (snapshot.data['fields']['telephone_du_lieu'] != null)
                                  Column(children: [
                                    const Padding(
                                      padding: EdgeInsets.only(top: 5),
                                    ),
                                    Row(
                                      children: [
                                        Icon(Icons.phone, size: 30, color: Colors.blue[900]),
                                        const Padding(
                                          padding: EdgeInsets.only(left: 5),
                                        ),
                                        Flexible(
                                            child: GestureDetector(
                                          onTap: () async {
                                            final telScheme = 'tel:${snapshot.data['fields']['telephone_du_lieu']}';
                                            if (await canLaunch(telScheme)) {
                                              await launch(telScheme);
                                            } else {
                                              final Error error = ArgumentError('Could not launch $telScheme');
                                              throw error;
                                            }
                                          },
                                          child: Text(
                                            snapshot.data['fields']['telephone_du_lieu'].toString(),
                                            style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.normal,
                                                color: Colors.blueGrey,
                                                decoration: TextDecoration.underline),
                                          ),
                                        )),
                                      ],
                                    ),
                                  ]),
                                if (snapshot.data['fields']['site_web_du_lieu'] != null)
                                  Column(children: [
                                    const Padding(
                                      padding: EdgeInsets.only(top: 5),
                                    ),
                                    Row(
                                      children: [
                                        Icon(Icons.language, size: 30, color: Colors.blue[900]),
                                        const Padding(
                                          padding: EdgeInsets.only(left: 5),
                                        ),
                                        Flexible(
                                          child: GestureDetector(
                                            onTap: () {
                                              _launchURL(snapshot.data['fields']['site_web_du_lieu'].toString());
                                            },
                                            child: Text(
                                              snapshot.data['fields']['site_web_du_lieu'].toString(),
                                              style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.normal,
                                                  color: Colors.blueGrey,
                                                  decoration: TextDecoration.underline),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ]),
                                Column(children: [
                                  const Padding(
                                    padding: EdgeInsets.only(top: 5),
                                  ),
                                  Row(
                                    children: [
                                      const Text(
                                        'Noter : ',
                                        style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
                                      ),
                                      RatingBar.builder(
                                        initialRating:
                                            (snapshot.data.data().containsKey('ratings') && snapshot.data['ratings'][_firebaseUser.uid] != null)
                                                ? double.parse(snapshot.data['ratings'][_firebaseUser.uid].toString())
                                                : 0,
                                        minRating: 1,
                                        allowHalfRating: true,
                                        itemBuilder: (context, _) => const Icon(
                                          Icons.star,
                                          color: Colors.amber,
                                          size: 18,
                                        ),
                                        onRatingUpdate: (rating) async {
                                          await snapshot.data.reference
                                              .update({'ratings.${_firebaseUser.uid}': rating})
                                              .then((value) => _ratingKey.currentState.updateText())
                                              .catchError((error) => throw ArgumentError('Failed to update user: $error'));
                                        },
                                      ),
                                      const Padding(
                                        padding: EdgeInsets.only(left: 10),
                                      ),
                                      RatingText(
                                        key: _ratingKey,
                                        id: _id,
                                        rateExist: snapshot.data.data().containsKey('rate') ? snapshot.data['rate'] as double : 0,
                                        ratings: snapshot.data.data().containsKey('ratings')
                                            ? snapshot.data['ratings'] as Map<String, dynamic>
                                            : <String, dynamic>{},
                                      )
                                    ],
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.only(top: 10),
                                  ),
                                  Column(
                                    children: [
                                      ManageParcours(events: events, recordid: snapshot.data['recordid'].toString(), userSnapshot: userSnapshot),
                                      const Padding(padding: EdgeInsets.only(left: 10)),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          RaisedButton.icon(
                                            onPressed: () {},
                                            icon: const Icon(Icons.edit),
                                            label: const Text('Organisateur'),
                                            color: Colors.deepOrangeAccent,
                                          ),
                                        ],
                                      ),
                                    ],
                                  )
                                ]),
                                const Padding(
                                  padding: EdgeInsets.only(top: 10),
                                ),
                                const Divider(
                                  color: Colors.blueGrey,
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(top: 10),
                                ),
                                Center(
                                  child: Container(
                                    decoration: const BoxDecoration(),
                                    child: const Text(
                                      'Informations ',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                                if (snapshot.data['fields']['thematiques'] != null)
                                  Column(children: [
                                    const Padding(
                                      padding: EdgeInsets.only(top: 10),
                                    ),
                                    Text.rich(TextSpan(
                                        text: 'Thématiques : ',
                                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey[600]),
                                        children: [
                                          TextSpan(
                                            text: snapshot.data['fields']['thematiques'].toString(),
                                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal, color: Colors.grey[600]),
                                          )
                                        ])),
                                  ]),
                                if (snapshot.data['fields']['orientation_et_axes_transversaux'] != null)
                                  Column(children: [
                                    const Padding(
                                      padding: EdgeInsets.only(top: 5),
                                    ),
                                    Text.rich(TextSpan(
                                        text: 'Orientations et axes transversaux : ',
                                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey[600]),
                                        children: [
                                          TextSpan(
                                            text: snapshot.data['fields']['orientation_et_axes_transversaux'].toString(),
                                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal, color: Colors.grey[600]),
                                          )
                                        ])),
                                  ]),
                                if (snapshot.data['fields']['publics_concernes'] != null)
                                  Column(children: [
                                    const Padding(
                                      padding: EdgeInsets.only(top: 5),
                                    ),
                                    Text.rich(TextSpan(
                                        text: 'Publics concernés : ',
                                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey[600]),
                                        children: [
                                          TextSpan(
                                            text: snapshot.data['fields']['publics_concernes'].toString(),
                                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal, color: Colors.grey[600]),
                                          )
                                        ])),
                                  ]),
                                if (snapshot.data['fields']['inscription_necessaire'] != null)
                                  Column(children: [
                                    const Padding(
                                      padding: EdgeInsets.only(top: 5),
                                    ),
                                    Text.rich(TextSpan(
                                        text: 'Inscription nécessaire : ',
                                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey[600]),
                                        children: [
                                          TextSpan(
                                            text: snapshot.data['fields']['inscription_necessaire'].toString(),
                                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal, color: Colors.grey[600]),
                                          )
                                        ])),
                                  ]),
                                if (snapshot.data['fields']['description_fr'] != null)
                                  Column(children: [
                                    const Padding(
                                      padding: EdgeInsets.only(top: 5),
                                    ),
                                    Text.rich(TextSpan(
                                        text: 'Description évènement : ',
                                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey[600]),
                                        children: [
                                          TextSpan(
                                            text: snapshot.data['fields']['description_fr'].toString(),
                                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal, color: Colors.grey[600]),
                                          )
                                        ])),
                                  ]),
                                if (snapshot.data['fields']['organisateur'] != null)
                                  Column(children: [
                                    const Padding(
                                      padding: EdgeInsets.only(top: 5),
                                    ),
                                    Text.rich(TextSpan(
                                        text: 'Organisateur : ',
                                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey[600]),
                                        children: [
                                          TextSpan(
                                            text: snapshot.data['fields']['organisateur'].toString(),
                                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal, color: Colors.grey[600]),
                                          )
                                        ])),
                                  ]),
                                if (snapshot.data['fields']['nom_du_lieu'] != null)
                                  Column(children: [
                                    const Padding(
                                      padding: EdgeInsets.only(top: 5),
                                    ),
                                    Text.rich(TextSpan(
                                        text: 'Nom du lieu : ',
                                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey[600]),
                                        children: [
                                          TextSpan(
                                            text: snapshot.data['fields']['nom_du_lieu'].toString(),
                                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal, color: Colors.grey[600]),
                                          )
                                        ])),
                                  ]),
                                if (snapshot.data['fields']['tags_du_lieu'] != null)
                                  Column(children: [
                                    const Padding(
                                      padding: EdgeInsets.only(top: 5),
                                    ),
                                    Text.rich(TextSpan(
                                        text: 'Tags : ',
                                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey[600]),
                                        children: [
                                          TextSpan(
                                            text: snapshot.data['fields']['tags_du_lieu'].toString(),
                                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal, color: Colors.grey[600]),
                                          )
                                        ])),
                                  ]),
                                if (snapshot.data['fields']['description_du_lieu_fr'] != null)
                                  Column(children: [
                                    const Padding(
                                      padding: EdgeInsets.only(top: 5),
                                    ),
                                    Text.rich(TextSpan(
                                        text: 'Description du lieu : ',
                                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey[600]),
                                        children: [
                                          TextSpan(
                                            text: snapshot.data['fields']['description_du_lieu_fr'].toString(),
                                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal, color: Colors.grey[600]),
                                          )
                                        ]))
                                  ]),
                                if (snapshot.data['fields']['acces_itineraire_fr'] != null)
                                  Column(children: [
                                    const Padding(
                                      padding: EdgeInsets.only(top: 5),
                                    ),
                                    Text.rich(TextSpan(
                                        text: 'Accès : ',
                                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey[600]),
                                        children: [
                                          TextSpan(
                                            text: snapshot.data['fields']['acces_itineraire_fr'].toString(),
                                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal, color: Colors.grey[600]),
                                          )
                                        ])),
                                  ]),
                                const Padding(
                                  padding: EdgeInsets.only(top: 5),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      CachedNetworkImage(
                        imageUrl: snapshot.data['fields']['image_du_lieu'].toString() ?? 'empty',
                        progressIndicatorBuilder: (context, url, downloadProgress) => CircularProgressIndicator(value: downloadProgress.progress),
                        errorWidget: (context, url, error) => const Icon(Icons.error),
                      ),
                      const Text(
                        'Syndicat Mixte du Technop\u00f4le Alimentec',
                        textAlign: TextAlign.end,
                        style: TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                );
              });
        },
      ),
    );
  }
}

class ManageParcours extends StatefulWidget {
  const ManageParcours({
    Key key,
    @required this.events,
    @required this.recordid,
    @required this.userSnapshot,
  }) : super(key: key);

  final List<String> events;
  final String recordid;
  final AsyncSnapshot<DocumentSnapshot> userSnapshot;

  @override
  _ManageParcoursState createState() => _ManageParcoursState();
}

class _ManageParcoursState extends State<ManageParcours> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        RaisedButton.icon(
          onPressed: () {
            setState(() {
              if (!widget.events.contains(widget.recordid)) {
                widget.userSnapshot.data.reference.update({
                  'tour.events': FieldValue.arrayUnion([widget.recordid])
                });
                widget.events.add(widget.recordid);
              } else {
                widget.userSnapshot.data.reference.update({
                  'tour.events': FieldValue.arrayRemove([widget.recordid])
                });
                widget.events.remove(widget.recordid);
              }
            });
          },
          icon: !widget.events.contains(widget.recordid) ? const Icon(Icons.add) : const Icon(Icons.remove),
          label: !widget.events.contains(widget.recordid) ? const Text('Ajouter au parcours') : const Text('Retirer du parcours'),
          color: Colors.green,
        )
      ],
    );
  }
}

class RatingText extends StatefulWidget {
  const RatingText({this.ratings, this.id, this.key, this.rateExist});

  final String id;
  final GlobalKey<_RatingTextState> key;
  final double rateExist;
  final Map<String, dynamic> ratings;

  @override
  _RatingTextState createState() => _RatingTextState();
}

class _RatingTextState extends State<RatingText> {
  double _rate;
  int _nbVotes;

  Future<void> updateText() async {
    try {
      _nbVotes = 0;
      _rate = 0;

      var doc = FirebaseFirestore.instance.collection('events').doc(widget.id);

      await doc.get().then((doc) {
        if (doc.exists) {
          final ratin = doc.data()['ratings'] as Map<String, dynamic>;
          ratin.forEach((key, value) {
            _nbVotes++;
            _rate += value as double;
          });
        }
      });

      await doc.update({'nb_votes': _nbVotes}).then((value) => print("Votes Updated")).catchError((error) => print('Failed to update votes: $error'));
      await doc.update({'rate': _rate / _nbVotes}).catchError((error) => print("Failed to update rate: $error"));
      setState(() {});
    } on StateError catch (e) {
      print('No nested field exists!');
    }
  }

  @override
  void initState() {
    super.initState();
    //this._starNumber = widget.document;

    this._nbVotes = widget.rateExist != 0 ? widget.ratings.length : 0;
    _rate = 0;
    widget.ratings.forEach((key, value) {
      _rate += value as double;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            if (_nbVotes > 0) Text((_rate / _nbVotes).toString()) else const Text('0'),
            const Icon(
              Icons.star,
              size: 15,
            )
          ],
        ),
        Text('$_nbVotes avis')
      ],
    );
  }
}
