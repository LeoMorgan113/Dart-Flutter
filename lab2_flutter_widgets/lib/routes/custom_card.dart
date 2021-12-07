import 'package:flutter/material.dart';
// import '../secondPage.dart';

class CustomCard extends StatelessWidget {
  int index;
  CustomCard({Key? key, required this.index}) : super(key: key);

  void _navigateAndDisplaySelection(BuildContext context, int title) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Likes(title: title)),
    );

    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text('$result')));
  }

  Widget build(BuildContext context) {
    return Card(
        child: Column(
          children: <Widget>[
              Card(
                child: ListTile(
                  title: Text("User${index} likes your post."),
                  trailing: TextButton(
                      child: const Text("Details"),
                      onPressed: () {
                        _navigateAndDisplaySelection(context, index);
                      }),

                ),
              )
          ],
        ));
  }
}

class Likes extends StatelessWidget {
  Likes({required this.title});

  final int title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User$title \'s personal info'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
            onPressed: () => Navigator.pop(context, 'You\'ve seen info about user $title')),
      ),
      body: Center(
        child: Column(
            children: [
              const Padding(padding: EdgeInsets.all(20)),
              Text('Some info about the User$title'),
              const Padding(padding: EdgeInsets.only(bottom: 15)),
              ElevatedButton(
                  child: const Text('Back To Notifications'),
                  onPressed: () => Navigator.pop(context, 'You\'ve seen info about user $title')),
            ]
        ),
      )
    );
  }
}
