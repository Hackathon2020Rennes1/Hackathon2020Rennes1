import 'package:cached_network_image/cached_network_image.dart';
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
                decoration: const BoxDecoration(
                  color: Color(0xff2E4060),
                ),
                accountName: Text(_firebaseUser.displayName, style: const TextStyle(fontSize: 22)),
                accountEmail: Text(_firebaseUser.email),
                currentAccountPicture: CachedNetworkImage(
                  imageUrl: 'http://via.placeholder.com/350x150',
                  progressIndicatorBuilder: (context, url, downloadProgress) => CircularProgressIndicator(value: downloadProgress.progress),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
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
            ],
          ),
        ),
      ),
    );
  }
}
