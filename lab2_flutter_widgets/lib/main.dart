import 'dart:core';
import 'package:flutter/material.dart';
import 'package:lab_2/routes/hide_on_scroll.dart';
import 'package:lab_2/routes/likes_settings.dart';
import 'package:lab_2/routes/notification.dart';
import 'package:lab_2/routes/profile.dart';
import 'package:lab_2/routes/settings_notifier.dart';
import 'package:lab_2/routes/settings.dart';
import 'package:lab_2/routes/subscription_settings.dart';
import 'package:lab_2/theme.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
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

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences.getInstance().then((prefs){
    var isDarkTheme = prefs.getBool("darkTheme") ?? false;
    return runApp(
        MultiProvider(
            providers:[ ChangeNotifierProvider(
              create: (_) => SettingsNotifier(),
            ),
              ChangeNotifierProvider<ThemeProvider>(
                  create: (BuildContext context) => ThemeProvider(isDarkTheme))
            ],
            child:const MyFirstApp())
    );
  });

}

class MyFirstApp extends StatefulWidget {
  const MyFirstApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyFirstApp> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child){
        return MaterialApp(
            theme: themeProvider.getTheme,
            debugShowCheckedModeBanner: false,
            // home: const HideOnScroll(),

            routes: {
              "/": (context) => const HideOnScroll(),
              "/settings": (context) => const Settings(),
              '/subscription': (context) => const SubscriptionSettings(),
              PageRoutes.likes: (context) => LikesSettings(),
              PageRoutes.profile: (context) => const Profile(),
            }
        );
      },

    );
  }
}