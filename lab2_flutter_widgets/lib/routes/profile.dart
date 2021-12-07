import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:lab_2/routes/named_icon.dart';
import 'package:lab_2/routes/page_route.dart';

import '../main.dart';

class PinsCardWidget extends StatelessWidget {
  final String img;
  final String title;
  final String subtitle;
  final ValueChanged<int> setSubscription;
  final bool like;
  final int index;

  const PinsCardWidget(
      {Key? key,
      required this.img,
      required this.title,
      required this.subtitle,
      required this.setSubscription,
      required this.index,
      required this.like})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
          child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
            Container(
              height: 250,
            margin: const EdgeInsets.only(top: 10),
            child: Image.asset('images/' + img + '.jpg',
              fit: BoxFit.contain),
          ),
        ListTile(
          title: Text(title),
          subtitle: Text(subtitle),
          trailing:  IconButton(
            onPressed: () {
              setSubscription(index);
            },
            icon:
              Icon(Icons.favorite,
              color:  like ? Colors.red : Colors.grey,)
          ),
        ),
      ])),
    );
  }
}

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);
  static const String routeName = '/profile';

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
  int fav = 0;

  List<Pins> pins = [
    Pins('pin1', 'All pins', '120 pins'),
    Pins('pin2', 'Autumn looks', '17 pins'),
    Pins('pin3', 'Inspirations', '10 pins'),
    Pins('pin4', 'Aesthetics', '15 pins')
  ];
  List<bool> likes = List.filled(4, false);

  void setFavourites(index){
    setState((){
      likes[index] = !likes[index];
      if(likes[index]){
        fav++;
      }else{
        fav--;
      }

    });
  }

  void subscription(){
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
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Profile'), actions: <Widget>[
        NamedIcon(
          iconData: Icons.subscriptions_outlined,
          subscriptionCount: _count
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
                      blurRadius: 10,
                      color: Colors.redAccent,
                      spreadRadius: 1,
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
                      subscription();
                      ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(subscriptionText)));
                    },
                    child: Text(btnText),
                    textColor: Colors.black,
                    color: _hasBeenPressed ? Colors.grey : Colors.red,
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
              const Padding(padding: EdgeInsets.only(top: 10)),
              Row(
                children: [
                  Text('$fav favourite collections')
                ],
              )
            ],
          ),
        ]),
        Expanded(
          child: GridView.count(
            primary: false,
            padding: const EdgeInsets.fromLTRB(10, 15, 10, 75),
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            crossAxisCount: 2,
            children: <Widget>[
              ...pins.asMap().keys.toList().map((index) {
                  return PinsCardWidget(
                  img: pins[index].img, title: pins[index].title,
                      subtitle: pins[index].subtitle,
                    setSubscription: setFavourites,
                      index: index, like: likes[index]);
              }).toList()
            ],
          ),
        ),
      ]),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {},
        child: Icon(Icons.settings),
      ),
    );
  }
}
