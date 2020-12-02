import 'package:cached_network_image/cached_network_image.dart';
import 'package:fete_ta_science/src/pages/list_own_tour_page/list_own_tour_page.dart';
import 'package:fete_ta_science/src/pages/list_public_tour_page/list_public_tour_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../services/firebase_services/auth_service.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _firebaseUser = context.watch<User>();
    final _scrollController = ScrollController();

    return Drawer(
      child: Container(
        color: const Color(0xff34495E),
        child: Scrollbar(
          isAlwaysShown: true,
          controller: _scrollController,
          child: ListView(
            controller: _scrollController,
            padding: EdgeInsets.zero,
            children: [
              UserAccountsDrawerHeader(
                margin: const EdgeInsets.all(0),
                decoration: const BoxDecoration(
                  color: Color(0xff2E4060),
                ),
                accountName:
                    _firebaseUser.displayName != null ? Text(_firebaseUser.displayName, style: const TextStyle(fontSize: 22)) : const Text(''),
                accountEmail: _firebaseUser.email != null ? Text(_firebaseUser.email) : const Text(''),
                currentAccountPicture: CachedNetworkImage(
                  imageUrl:  _firebaseUser.photoURL ?? 'empty',
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
                otherAccountsPictures: [
                  IconButton(
                    icon: const Icon(Icons.power_settings_new),
                    onPressed: () {
                      Navigator.pop(context);
                      context.read<AuthService>().signOut();
                    },
                  )
                ],
              ),
              RaisedButton.icon(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (contex)=>ListPublicTourPage())
                  );
                },
                icon: const Icon(Icons.directions_walk),
                label: const Text('Liste des parcours publiques', style: TextStyle(fontSize: 17)),
                padding: const EdgeInsets.only(top: 15, bottom: 15),
                shape: const RoundedRectangleBorder(),
              ),
              RaisedButton.icon(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (contex)=>ListOwnTourPage(userId:_firebaseUser.uid))
                  );
                },
                icon: const Icon(Icons.directions_run),
                label: const Text('Mes parcours', style: TextStyle(fontSize: 17), textAlign: TextAlign.start,),
                padding: const EdgeInsets.only(top: 15, bottom: 15),
                shape: const RoundedRectangleBorder(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
