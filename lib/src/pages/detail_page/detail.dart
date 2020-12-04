import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:provider/provider.dart';

class Detail extends StatelessWidget {
  const Detail({
    @required QueryDocumentSnapshot queryDocumentSnapshot,
    Key key,
  })  : _document = queryDocumentSnapshot,
        super(key: key);

  final QueryDocumentSnapshot _document;

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
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
      body: SafeArea(
        child: ListView(
          children: [
            CachedNetworkImage(
              imageUrl: _document['fields']['image'].toString(),
              progressIndicatorBuilder: (context, url, downloadProgress) => CircularProgressIndicator(value: downloadProgress.progress),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
            if (_document['fields']['titre_fr'] != null) Padding(
              padding: const EdgeInsets.fromLTRB(10, 7, 10, 5),
              child: Text(
                _document['fields']['titre_fr'].toString(),
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(10.0, 5, 7, 5),
              child: Column(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (_document['fields']['tranche'] != null) Row(
                        children: [
                          Icon(
                            Icons.accessibility_new,
                            size: 30,
                            color: Colors.blue[900],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 5),
                          ),
                          Text(
                              'De ${_document['fields']['tranche'].toString().split('-')[0]} à ${_document['fields']['tranche'].toString().split('-')[1]} ans',
                              style:  TextStyle(fontSize: 16, fontWeight: FontWeight.normal, color: Colors.grey[600]),
                          )
                        ],
                      ),
                      if (_document['fields']['adresse'] != null) Column(
                        children: [ Padding(
                          padding: const EdgeInsets.only(top: 5),
                        ),
                          Row(
                            children: [
                              Icon(Icons.location_on, size: 30, color: Colors.blue[900]),
                              Padding(
                                padding: const EdgeInsets.only(left: 5),
                              ),
                              Flexible(
                                  child:  Text(
                                    _document['fields']['adresse'].toString(),
                                    style:  TextStyle(fontSize: 16, fontWeight: FontWeight.normal, color: Colors.grey[600]),
                                  )
                              ),
                            ],
                          ),
                        ]
                      ),
                      if (_document['fields']['horaires_detailles_fr'] != null) Column(
                        children: [ Padding(
                          padding: const EdgeInsets.only(top: 5),
                          ),
                          Row(
                            children: [
                              Icon(Icons.calendar_today, size: 30, color: Colors.blue[900]),
                              Padding(
                                padding: const EdgeInsets.only(left: 5),
                              ),
                              Flexible(
                                  child:  Text(
                                    _document['fields']['horaires_detailles_fr'].toString(),
                                    style:  TextStyle(fontSize: 16, fontWeight: FontWeight.normal, color: Colors.grey[600]),
                                  )
                              ),
                            ],
                          ),
                        ]
                      ),
                      if (_document['fields']['telephone_du_lieu'] != null) Column(
                        children: [Padding(
                          padding: const EdgeInsets.only(top: 5),
                        ),
                          Row(
                            children: [
                              Icon(Icons.phone, size: 30, color: Colors.blue[900]),
                              Padding(
                                padding: const EdgeInsets.only(left: 5),
                              ),
                              Flexible(
                                  child:  GestureDetector(
                                    child: Text(
                                      _document['fields']['telephone_du_lieu'].toString(),
                                      style:  TextStyle(fontSize: 16, fontWeight: FontWeight.normal, color: Colors.blueGrey, decoration: TextDecoration.underline),
                                    ),
                                    onTap: () async {
                                      final telScheme = 'tel:${_document['fields']['telephone_du_lieu']}';
                                      if (await canLaunch(telScheme)) {
                                      await launch(telScheme);
                                      } else {
                                      throw 'Could not launch $telScheme';
                                      }
                                    },
                                  )
                              ),
                            ],
                          ),
                      ]),
                      if (_document['fields']['site_web_du_lieu'] != null) Column(
                        children: [Padding(
                          padding: const EdgeInsets.only(top: 5),
                        ),
                          Row(
                            children: [
                              Icon(Icons.language, size: 30, color: Colors.blue[900]),
                              Padding(
                                padding: const EdgeInsets.only(left: 5),
                              ),
                              GestureDetector(
                                child: Text(
                                  _document['fields']['site_web_du_lieu'].toString(),
                                  style:  TextStyle(fontSize: 16, fontWeight: FontWeight.normal, color: Colors.blueGrey, decoration: TextDecoration.underline),
                                  overflow: TextOverflow.clip,
                                ),
                                onTap: () {
                                  _launchURL('http://www.altecsciences.fr');
                                },
                              ),
                            ],
                          ),
                      ]),
                      if (_document['fields']['horaires_detailles_fr'] != null)Column(
                        children: [Padding(
                          padding: const EdgeInsets.only(top: 5),
                        ),
                          Row(
                            children: [
                              Text(
                                'Noter : ',
                                style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
                              ),
                              RatingBar.builder(
                                initialRating: (_document.data().containsKey('ratings') && _document['ratings'][_firebaseUser.uid] != null) ? double.parse(_document['ratings'][_firebaseUser.uid].toString()) : 0,
                                minRating: 1,
                                direction: Axis.horizontal,
                                allowHalfRating: true,
                                itemCount: 5,
                                itemPadding: EdgeInsets.symmetric(horizontal: 0.0),
                                itemBuilder: (context, _) => Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                  size: 18,
                                ),
                                onRatingUpdate: (rating) async {
                                  await _document.reference.update({'ratings.${_firebaseUser.uid}' : rating});
                                  _ratingKey.currentState.updateText();
                                },
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                              ),
                              RatingText(key: _ratingKey,)
                            ],
                          ),
                      ]),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                      ),
                      Divider(
                        color: Colors.blueGrey,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                      ),
                      Center(
                        child: Container(
                          decoration: BoxDecoration(),
                          child: Text(
                            'Informations ',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      if (_document['fields']['thematiques'] != null) Column(
                        children: [Padding(
                          padding: const EdgeInsets.only(top: 10),
                        ),
                          Text.rich(TextSpan(text: 'Thématiques : ', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey[600]), children: [
                            TextSpan(
                              text: _document['fields']['thematiques'].toString(),
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal, color: Colors.grey[600]),
                            )
                          ])),
                      ]),
                      if (_document['fields']['orientation_et_axes_transversaux'] != null) Column(
                        children: [Padding(
                          padding: const EdgeInsets.only(top: 5),
                        ),
                          Text.rich(TextSpan(text: 'Orientations et axes transversaux : ', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey[600]), children: [
                            TextSpan(
                              text: _document['fields']['orientation_et_axes_transversaux'].toString(),
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal, color: Colors.grey[600]),
                            )
                          ])),
                      ]),
                      if (_document['fields']['publics_concernes'] != null) Column(
                        children: [Padding(
                          padding: const EdgeInsets.only(top: 5),
                        ),
                          Text.rich(TextSpan(text: 'Publics concernés : ', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey[600]), children: [
                            TextSpan(
                              text: _document['fields']['publics_concernes'].toString(),
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal, color: Colors.grey[600]),
                            )
                          ])),
                      ]),
                      if (_document['fields']['inscription_necessaire'] != null) Column(
                        children: [Padding(
                          padding: const EdgeInsets.only(top: 5),
                        ),
                          Text.rich(TextSpan(text: 'Inscription nécessaire : ', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey[600]), children: [
                            TextSpan(
                              text: _document['fields']['inscription_necessaire'].toString(),
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal, color: Colors.grey[600]),
                            )
                          ])),
                      ]),
                      if (_document['fields']['description_fr'] != null) Column(
                        children: [Padding(
                          padding: const EdgeInsets.only(top: 5),
                        ),
                          Text.rich(TextSpan(text: 'Description évènement : ', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey[600]), children: [
                            TextSpan(
                              text: _document['fields']['description_fr'].toString(),
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal, color: Colors.grey[600]),
                            )
                          ])),
                      ]),
                      if (_document['fields']['organisateur'] != null) Column(
                        children: [Padding(
                          padding: const EdgeInsets.only(top: 5),
                        ),
                          Text.rich(TextSpan(text: 'Organisateur : ', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey[600]), children: [
                            TextSpan(
                              text: _document['fields']['organisateur'].toString(),
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal, color: Colors.grey[600]),
                            )
                          ])),
                      ]),
                      if (_document['fields']['nom_du_lieu'] != null) Column(
                        children: [Padding(
                          padding: const EdgeInsets.only(top: 5),
                        ),
                          Text.rich(TextSpan(text: 'Nom du lieu : ', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey[600]), children: [
                            TextSpan(
                              text: _document['fields']['nom_du_lieu'].toString(),
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal, color: Colors.grey[600]),
                            )
                          ])),
                      ]),
                      if (_document['fields']['tags_du_lieu'] != null) Column(
                        children: [Padding(
                          padding: const EdgeInsets.only(top: 5),
                        ),
                          Text.rich(TextSpan(text: 'Tags : ', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey[600]), children: [
                            TextSpan(
                              text: _document['fields']['tags_du_lieu'].toString(),
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal, color: Colors.grey[600]),
                            )
                          ])),
                      ]),
                      if (_document['fields']['description_du_lieu_fr'] != null) Column(
                        children: [Padding(
                          padding: const EdgeInsets.only(top: 5),
                        ),
                          Text.rich(TextSpan(text: 'Description du lieu : ', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey[600]), children: [
                            TextSpan(
                              text: _document['fields']['description_du_lieu_fr'].toString(),
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal, color: Colors.grey[600]),
                            )
                          ]))
                      ]),
                      if (_document['fields']['acces_itineraire_fr'] != null) Column(
                        children: [Padding(
                          padding: const EdgeInsets.only(top: 5),
                        ),
                          Text.rich(TextSpan(text: 'Accès : ', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey[600]), children: [
                            TextSpan(
                              text: _document['fields']['acces_itineraire_fr'].toString(),
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal, color: Colors.grey[600]),
                            )
                          ])),
                      ]),
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            CachedNetworkImage(
              imageUrl: _document['fields']['image_du_lieu'].toString() ?? 'empty',
              progressIndicatorBuilder: (context, url, downloadProgress) => CircularProgressIndicator(value: downloadProgress.progress),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
            Text(
              'Syndicat Mixte du Technop\u00f4le Alimentec',
              textAlign: TextAlign.end,
              style: TextStyle(fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}

class RatingText extends StatefulWidget {
  const RatingText({
    @required QueryDocumentSnapshot queryDocumentSnapshot,
    Key key,
  }) : document = queryDocumentSnapshot,
        super(key: key);

  final QueryDocumentSnapshot document;

  @override
  _RatingTextState createState() => _RatingTextState();
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<QueryDocumentSnapshot>('document', document));
  }
}

class _RatingTextState extends State<RatingText> {
  int _starNumber;

  void updateText()
  {
    print("TESTESTEST");
  }

  @override
  void initState() {

    //this._starNumber = widget.document;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text('4.5'),
            Icon(
              Icons.star,
              size: 15,
            )
          ],
        ),
        Text('145 avis')
      ],
    );
  }
}
