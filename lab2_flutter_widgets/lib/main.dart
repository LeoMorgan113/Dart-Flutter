import 'package:flutter/material.dart';
import 'package:lab2/pages/home.dart';
import 'package:lab2/pages/main_screen.dart';

void main() => runApp(MaterialApp(
  theme: ThemeData(
    primaryColor: Colors.orange,
  ),
  initialRoute: '/',
  routes: {
    '/': (context) => MainScreen(),
    '/todo': (context) => Home(),
  },
));

