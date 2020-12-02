import 'dart:ui';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Detail extends StatelessWidget {
  const Detail({
    Key key,
  }) : super(key: key);

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }



  @override
  Widget build(BuildContext context) {

    final url = 'https://cibul.s3.amazonaws.com/location99812301.jpg';

    var screenSize = MediaQuery.of(context).size;
    var width = screenSize.width;
    var height = screenSize.height;

    return Scaffold(
      appBar: AppBar(
        title: Text(
            'Détail'
        ),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(

          child: ListView(
            children: [
              Image.network('https://cibul.s3.amazonaws.com/4ddb4e5624d640a7b51e9857a8ccd7d3.base.image.jpg'),
              Padding(
                padding: EdgeInsets.fromLTRB(10, 7, 10, 5),
                child: Text(
                  'titrefr L\'innovation médicale au centre hospitalier de Bourg-en-Bresse',
                  style: TextStyle(color: Colors.black, fontSize: 24,
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
                        Row(
                          children: [
                            Icon(Icons.accessibility_new,
                              size: 30, color: Colors.blue[900],),
                            Padding(
                              padding: const EdgeInsets.only(left: 5),
                            ),
                            Text('tranche": "16-99"', style: TextStyle(fontSize:16, color: Colors.grey[600]),),
                          ],
                        ),
                        Padding(padding: const EdgeInsets.only(top: 5),),
                        Row(
                          children: [
                            Icon(Icons.location_on,
                                size: 30, color: Colors.blue[900]),
                            Padding(
                              padding: const EdgeInsets.only(left: 5),
                            ),
                            Flexible(
                              child: Text(
                                'adresse Rue Henri de Boissieu 01000 Bourg-en-Bresse',
                                style: TextStyle(fontSize:16, color: Colors.grey[600]),
                                overflow: TextOverflow.clip,
                              ),
                            ),
                          ],
                        ),
                        Padding(padding: const EdgeInsets.only(top: 5),),
                        Row(
                          children: [
                            Icon(Icons.calendar_today,
                                size: 30, color: Colors.blue[900]),
                            Padding(
                              padding: const EdgeInsets.only(left: 5),
                            ),
                            Flexible(
                              child: Text(
                                'samedi 5 octobre - 14h00 \u00e0 18h00\r\ndimanche 6 octobre - 14h00 \u00e0 18h00',
                                style: TextStyle(fontSize:16, color: Colors.grey[600]),
                                overflow: TextOverflow.clip,
                              ),
                            ),
                          ],
                        ),
                        Padding(padding: const EdgeInsets.only(top: 5),),
                        Row(
                          children: [
                            Icon(Icons.phone,
                                size: 30, color: Colors.blue[900]),
                            Padding(
                              padding: const EdgeInsets.only(left: 5),
                            ),
                            Flexible(
                              child: Text(
                                'telephone_du_lieu  04 74 45 52 17',
                                style: TextStyle(fontSize:16, color: Colors.grey[600]),
                                overflow: TextOverflow.clip,
                              ),
                            ),
                          ],
                        ),
                        Padding(padding: const EdgeInsets.only(top: 5),),
                        Row(
                          children: [
                            Icon(Icons.language,
                                size: 30, color: Colors.blue[900]),
                            Padding(
                              padding: const EdgeInsets.only(left: 5),
                            ),
                            FlatButton(
                              child: Text(
                                'http://www.altecsciences.fr',
                                style: TextStyle(fontSize:16, color: Colors.grey[600]),
                                overflow: TextOverflow.clip,
                              ),
                              onPressed:(){ _launchURL('http://www.altecsciences.fr');},
                            ),
                          ],
                        ),
                        Padding(padding: const EdgeInsets.only(top: 10),),
                        Divider(
                          color: Colors.blueGrey,
                        ),
                        Padding(padding: const EdgeInsets.only(top: 10),),
                        Center(
                          child: Container(
                            decoration: BoxDecoration(

                            ),
                            child: Text(
                              'Informations ',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Padding(padding: const EdgeInsets.only(top: 10),),
                        Text.rich(TextSpan(text: 'Thématiques : ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16), children: [
                          TextSpan(
                            text: 'Sciences de la vie et de la sant\u00e9|Sciences num\u00e9riques|Sciences humaines et sociales.',
                            style: TextStyle(fontWeight: FontWeight.normal ,fontSize: 16),
                          )
                        ])),
                        Padding(padding: const EdgeInsets.only(top: 5),),
                        Text.rich(TextSpan(text: 'Orientation et axes transversaux : ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16), children: [
                          TextSpan(
                            text: 'Orientation nationale, Enjeux de société, débat & controverses, Culture technique, industrielle et innovation, Projets de médiation innovante ',
                            style: TextStyle(fontWeight: FontWeight.normal ,fontSize: 16),
                          )
                        ])),
                        Padding(padding: const EdgeInsets.only(top: 5),),
                        Text.rich(TextSpan(text: 'Publics concernés : ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16), children: [
                          TextSpan(
                            text: 'Collège (11 - 15 ans), Lycée (15 - 18 ans), Etudiants (18 - 25 ans',
                            style: TextStyle(fontWeight: FontWeight.normal ,fontSize: 16),
                          )
                        ])),
                        Padding(padding: const EdgeInsets.only(top: 5),),
                        Text.rich(TextSpan(text: 'Inscription nécessaire ? : ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16), children: [
                          TextSpan(
                            text: 'Non',
                            style: TextStyle(fontWeight: FontWeight.normal ,fontSize: 16),
                          )
                        ])),
                        Padding(padding: const EdgeInsets.only(top: 5),),
                        Text.rich(TextSpan(text: 'description_fr : ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16), children: [
                          TextSpan(
                            text: ' Les \u00e9quipes du centre hospitalier vous pr\u00e9sentent les innovations m\u00e9dicales utilis\u00e9es \u00e0 Bourg : l\'eye-tracking, l\'enseignement des soins d\'urgence gr\u00e2ce aux mannequins derni\u00e8re g\u00e9n\u00e9ration, etc.',
                            style: TextStyle(fontWeight: FontWeight.normal ,fontSize: 16),
                          )
                        ])),
                        Padding(padding: const EdgeInsets.only(top: 5),),
                        Text.rich(TextSpan(text: 'Organisateur : ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16,), children: [
                          TextSpan(
                            text: 'Centre hospitalier Fleyriat de Bourg-en-Bresse',
                            style: TextStyle(fontWeight: FontWeight.normal ,fontSize: 16),
                          )
                        ])),
                        Padding(padding: const EdgeInsets.only(top: 5),),
                        Text.rich(TextSpan(text: 'nom_du_lieu  ? : ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16,), children: [
                          TextSpan(
                            text: 'Village des Sciences de Bourg-en-Bresse',
                            style: TextStyle(fontWeight: FontWeight.normal ,fontSize: 16),
                          )
                        ])),
                        Padding(padding: const EdgeInsets.only(top: 5),),
                        Text.rich(TextSpan(text: 'tags_du_lieu  : ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16,), children: [
                          TextSpan(
                            text: 'Lieu multi \u00e9v\u00e9nements',
                            style: TextStyle(fontWeight: FontWeight.normal ,fontSize: 16),
                          )
                        ])),
                        Padding(padding: const EdgeInsets.only(top: 5),),
                        Text.rich(TextSpan(text: 'description_du_lieu_fr : ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16,), children: [
                          TextSpan(
                            text: 'Plus d\'une trentaine de stands d\'animation scientifique, un programme riche de conf\u00e9rences et de projections, la visite du Technopole Alimentec... D\u00e9couvrez la programmation tr\u00e8s riche de cette nouvelle \u00e9dition du village des sciences de Bourg-en-Bresse !\n\nPROGRAMME :\nVendredi 4 octobre de 18h \u00e0 21h : inauguration d\u00e9partementale et conf\u00e9rence sur l\'innovation m\u00e9dicale avec le Centre Hospitalier de Bourg-en-Bresse\nSamedi 5 octobre (14h \u00e0 18h) et dimanche 6 octobre (10h \u00e0 18h) : stands, conf\u00e9rences, projections, visite...\n\nINFOS PRATIQUES :\nBuvette \u00e9quitable avec Artisans du Monde le samedi et dimanche\nNOUVEAU : Restauration rapide et locale avec le Foodtruck fermier le dimanche midi !',
                            style: TextStyle(fontWeight: FontWeight.normal ,fontSize: 16),
                          )
                        ])),
                        Padding(padding: const EdgeInsets.only(top: 5),),
                        Text.rich(TextSpan(text: 'acces_itineraire_fr? : ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16,), children: [
                          TextSpan(
                            text: 'GRATUIT et accessible \u00e0 tous',
                            style: TextStyle(fontWeight: FontWeight.normal ,fontSize: 16),
                          )
                        ])),
                        Padding(padding: const EdgeInsets.only(top: 5),),

                      ],
                    ),

                  ],
                ),
              ),
              FlatButton(
                child: Image.network('https://cibul.s3.amazonaws.com/location99812301.jpg'),
                onPressed: (){

                },
              ),
              Text('Syndicat Mixte du Technop\u00f4le Alimentec',
                textAlign: TextAlign.end, style: TextStyle(fontSize: 12),),


            ],
          ),
        ),
      ),
    );
  }
}
/*

        "image_source": "https://cibul.s3.amazonaws.com/4ddb4e5624d640a7b51e9857a8ccd7d3.full.image.jpg",

* */
