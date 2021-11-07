import 'dart:core';
import 'dart:core';

import 'package:flutter/material.dart';
import 'package:lab_2/routes/hide_on_scroll.dart';

class Pins{
  String img;
  String title;
  String subtitle;

  Pins(this.img, this.title, this.subtitle);
}

void main() {
  runApp(MyFirstApp());
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
      home: HideOnScroll(),
    );
  }
}