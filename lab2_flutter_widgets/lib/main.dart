import 'dart:core';
import 'package:flutter/material.dart';
import 'package:lab_2/routes/hide_on_scroll.dart';
import 'package:lab_2/routes/notification.dart';
import 'package:lab_2/routes/profile.dart';
import 'package:lab_2/routes/settings_provider.dart';
import 'package:lab_2/routes/settings.dart';
import 'package:provider/provider.dart';
import 'routes/page_route.dart';

class Pins{
  String img;
  String title;
  String subtitle;

  Pins(this.img, this.title, this.subtitle);
}

class DrawerItems{
  IconData icon;
  String text;
  GestureTapCallback onTap;

  DrawerItems(this.icon, this.text, this.onTap);
}

void main() {
  runApp(
      MultiProvider(
        providers:[ ChangeNotifierProvider(
            create: (_) => SettingsProvider(),
          )],
        child:MyFirstApp())
  );
}

class MyFirstApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyFirstApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.red,
        brightness: Brightness.light,
      ),
      debugShowCheckedModeBanner: false,
      home: const HideOnScroll(),

      routes: {
        PageRoutes.suggestions: (context) => Settings(),
        PageRoutes.likes: (context) => const Notifications(),
        PageRoutes.profile: (context) => const Profile(),
      }
    );
  }
}