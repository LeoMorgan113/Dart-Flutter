import 'dart:core';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:lab_2/routes/page_route.dart';
import 'package:provider/provider.dart';
import 'package:lab_2/routes/settings_provider.dart';
import 'navigation_drawer.dart';

class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);
  static const String routeName = '/suggestions';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.home, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text("Settings"),
      ),
      body: Container(
        // decoration: BoxDecoration(
        //   image: DecorationImage(
        //     image: AssetImage("assets/cocktails.jpg"),
        //     fit: BoxFit.cover,
        //   ),
        // ),
        child: SafeArea(
            child: Padding(
          padding: const EdgeInsets.all(20),
          child: Container(
            padding: EdgeInsets.all(10),
            decoration: const BoxDecoration(
              color: Color(0xDDFFFFFF),
            ),
            child: Consumer<SettingsProvider>(
              builder: (context, provider, child) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      "User Settings: ",
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    Padding(padding: EdgeInsets.all(10)),
                    ...provider.settings
                        .map(
                          (settings) => SettingsWidget(
                            settings: settings,
                            onChanged: (value) {
                              provider.selectSettings(settings, value!);
                            },
                          ),
                        )
                        .toList(),
                    Padding(padding: EdgeInsets.all(20)),
                    Text(
                      "Applied settings: ",
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemBuilder: (context, index) => ListTile(
                          title: Text(
                            provider.selectedSettings.toList()[index].name,
                          ),
                        ),
                        itemCount: provider.selectedSettings.length,
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        )),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showSettings(context),
        child: Icon(Icons.settings),
      ),
    );
  }

  void _showSettings(BuildContext context) {
    SettingsProvider settingsProvider =
        Provider.of<SettingsProvider>(context, listen: false);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        titlePadding: const EdgeInsets.all(15.0),
        contentPadding: const EdgeInsets.all(15.0),
        content: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                  child: SizedBox(
                    child: ListTile(
                      title: Text('Selected settings'),
                      subtitle: Text(
                      "Quantity of selected settings:${settingsProvider.selectedSettings.length.toString()}"),
                    ),
                  )
              ),
              Expanded(
                  child: SizedBox(
                    height: 120,
                    child: Column(
                    children: List.generate(
                      settingsProvider.selectedSettings.length, (index) {
                      return Text(
                        settingsProvider.selectedSettings.toList()[index].name);
                  }),
                ),
              ))
            ]),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Close'),
          )
        ],
      ),
    );
  }
}
