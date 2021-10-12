import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

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
  int _count = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState() {
      _count = 22;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Profile'), actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.subscriptions_outlined),
          tooltip: 'Show Snackbar',
          onPressed: () {
            setState(() {
              _count++;
            });
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Now you follow this user.')));
          },
        ),
      ]),
      body: Column(children: <Widget>[
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 30),
              ),
              Container(
                decoration: BoxDecoration(
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
                child: CircleAvatar(
                  radius: 60,
                  backgroundImage: AssetImage('images/avatar.jpg'),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 15),
              ),
              Text(
                name,
                style: TextStyle(
                  fontSize: 35,
                  color: Colors.black,
                ),
              ),
              Padding(padding: EdgeInsets.only(top: 10)),
              Row(
                children: [
                  Text(
                    nickName,
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    '$_count subscribers',
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  Padding(padding: EdgeInsets.only(left: 10)),
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
              Container(
                height: 290,
                child: Card(
                    child: Column(children: [
                  Container(
                    height: 270,
                    child: Image.asset('images/pin1.jpg', fit: BoxFit.cover),
                  ),
                  ListTile(
                    title: const Text('All pins'),
                    subtitle: const Text('120 pins'),
                  ),
                ])),
              ),
              Container(
                height: 290,
                child: Card(
                    child: Column(children: [
                  Container(
                    height: 270,
                    child: Image.asset('images/pin2.jpg', fit: BoxFit.cover),
                  ),
                  ListTile(
                    title: const Text('Autumn looks'),
                    subtitle: const Text('17 pins'),
                  ),
                ])),
              ),
              Container(
                height: 290,
                child: Card(
                    child: Column(children: [
                  Container(
                    height: 270,
                    child: Image.asset('images/pin3.jpg', fit: BoxFit.cover),
                  ),
                  ListTile(
                    title: const Text('Inspirations'),
                    subtitle: const Text('10 pins'),
                  ),
                ])),
              ),
              Container(
                height: 290,
                child: Card(
                    child: Column(children: [
                  Container(
                    height: 270,
                    child: Image.asset('images/pin4.jpg', fit: BoxFit.cover),
                  ),
                  ListTile(
                    title: const Text('Aesthetics'),
                    subtitle: const Text('15 pins'),
                  ),
                ])),
              ),
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
