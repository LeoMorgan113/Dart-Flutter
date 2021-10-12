import 'package:flutter/material.dart';
import 'package:lab_2/routes/hide_on_scroll.dart';


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