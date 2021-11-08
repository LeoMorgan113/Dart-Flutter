import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class SettingsModel {
  String name;
  bool selected;

  SettingsModel(this.name, this.selected);
}

class SettingsProvider extends ChangeNotifier {
  final List<SettingsModel> _settings = [
    SettingsModel("Show username for everyone", false),
    SettingsModel("Show my pins to everyone", false),
    SettingsModel("Allow comments under my pins", false),
    SettingsModel("Allow everyone to write private messages", false),
    SettingsModel("Turn on Notifications", false),
    SettingsModel("Show subscriptions", false),
  ];

  void selectSettings(SettingsModel settings, bool selected) {
    _settings.firstWhere((element) => element.name == settings.name).selected =
        selected;
    notifyListeners();
  }

  List<SettingsModel> get selectedSettings =>
      _settings.where((element) => element.selected).toList();

  List<SettingsModel> get settings => _settings;
}


class SettingsWidget extends StatelessWidget {
  final SettingsModel settings;
  final Function(bool?)? onChanged;

  const SettingsWidget({Key? key, required this.settings, required this.onChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: settings.selected,
          onChanged: onChanged,
        ),
        Text(settings.name)
      ],
    );
  }
}
