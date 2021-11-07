import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:lab_2/routes/named_icon.dart';

import '../main.dart';

class PinsCardWidget extends StatelessWidget {
  final String img;
  final String title;
  final String subtitle;

  const PinsCardWidget(
      {Key? key,
      required this.img,
      required this.title,
      required this.subtitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 290,
      child: Card(
          child: Column(children: [
        Container(
          height: 260,
          margin: const EdgeInsets.only(top: 30),
          child: Image.asset('images/' + img + '.jpg'),
        ),
        ListTile(
          title: Text(title),
          subtitle: Text(subtitle),
        ),
      ])),
    );
  }
}
class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final myController = TextEditingController();
  String name = 'Leo Morgan';
  String nickName = '@leo_morgan33';
  String btnText = 'Subscribe';
  String subscriptionText = 'Now you follow this user';
  int _count = 0;
  bool _hasBeenPressed = false;

  List<Pins> pins = [
    Pins('pin1', 'All pins', '120 pins'),
    Pins('pin2', 'Autumn looks', '17 pins'),
    Pins('pin3', 'Inspirations', '10 pins'),
    Pins('pin4', 'Aesthetics', '15 pins')
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Profile'), actions: <Widget>[
        NamedIcon(
          text: 'Mails',
          iconData: Icons.subscriptions_outlined,
          notificationCount: _count,
          onTap: () {},
        ),
      ]),
      body: Column(children: <Widget>[
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Column(
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 30),
              ),
              Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 30,
                      color: Colors.redAccent,
                      spreadRadius: 2,
                    )
                  ],
                ),
                child: const CircleAvatar(
                  radius: 60,
                  backgroundImage: AssetImage('images/avatar.jpg'),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 15),
              ),
              Text(
                name,
                style: const TextStyle(
                  fontSize: 35,
                  color: Colors.black,
                ),
              ),
              const Padding(padding: EdgeInsets.only(top: 10)),
              Row(
                children: [
                  Text(
                    nickName,
                    style: const TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              const Padding(padding: EdgeInsets.only(top: 10)),
              Row(
                children: [
                  FlatButton(
                    onPressed: () {
                      setState(() {
                        _hasBeenPressed = !_hasBeenPressed;
                        if (_hasBeenPressed) {
                          _count++;
                          btnText = 'Unsubscribe';
                          subscriptionText = 'Now you follow this user';
                        } else {
                          _count--;
                          btnText = 'Subscribe';
                          subscriptionText = 'Now you not follow this user';
                        }
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(subscriptionText)));
                    },
                    child: Text(btnText),
                    textColor: Colors.black,
                    color: _hasBeenPressed ? Colors.red : Colors.grey,
                  ),
                ],
              ),
              const Padding(padding: EdgeInsets.only(top: 10)),
              Row(
                children: [
                  Text(
                    '$_count subscribers',
                    style: const TextStyle(fontWeight: FontWeight.w500),
                  ),
                  const Padding(padding: EdgeInsets.only(left: 10)),
                  Icon(Icons.people_alt),
                  Padding(padding: EdgeInsets.only(left: 10)),
                  Text(
                    '22 subscriptions',
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ],
          ),
        ]),
        Expanded(
          child: GridView.count(
            primary: false,
            padding: const EdgeInsets.all(10),
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            crossAxisCount: 2,
            children: <Widget>[
              ...pins
                  .map((pin) => PinsCardWidget(
                  img: pin.img, title: pin.title, subtitle: pin.subtitle))
                  .toList()
            ],
          ),
        ),
      ]),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: const Text('User Settings'),
            content: Text('User name: ' + name + '\nLogin: ' + nickName),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context, 'Cancel'),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, 'Submit'),
                child: const Text('OK'),
              ),
            ],
          ),
        ),
        child: Icon(Icons.settings),
      ),
    );
  }
}
