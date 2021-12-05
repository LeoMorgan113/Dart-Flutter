import 'dart:js';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:lab_2/main.dart';

import 'page_route.dart';

Widget createDrawerBody({required IconData icon, required String text, required GestureTapCallback onTap}){
  return Card(
    child: ListTile(
      leading: Icon(icon),
      title: Text(text),
      onTap: onTap,
    ),
  );
}

class NavigationDrawer extends StatelessWidget {
  NavigationDrawer({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Drawer(
      // Add a ListView to the drawer. This ensures the user can scroll
      // through the options in the drawer if there isn't enough vertical
      // space to fit everything.
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.redAccent,
            ),
            child: Center(
              child: ListTile(
                title: Text('Settings',
                    style:
                    TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                subtitle: Text('Turn on/off the notifications:',
                    style:
                    TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
              ),
            ),
          ),
          createDrawerBody(icon: Icons.subscriptions_outlined,text: 'Suggestion',
                   onTap: () => Navigator.pushReplacementNamed(context, PageRoutes.suggestions)),
          createDrawerBody(icon: Icons.favorite, text: 'Likes',
                   onTap: () => Navigator.pushReplacementNamed(context, PageRoutes.likes)),
          createDrawerBody(icon: Icons.image_outlined, text: 'Subscription', onTap: (){}),
        ],
      ),
    );
  }
}
