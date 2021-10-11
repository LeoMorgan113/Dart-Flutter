import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.amberAccent,
        appBar: AppBar(
            title: Text('ToDos'),
        centerTitle: true,
        backgroundColor: Colors.orange,
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Main Screen', style: TextStyle( fontSize: 20 ),),
              ElevatedButton(onPressed: (){
                Navigator.pushReplacementNamed(context, '/todo');
              }, child: Text('Next'))
            ],
          ),
        ],
      )
    );
  }
}
