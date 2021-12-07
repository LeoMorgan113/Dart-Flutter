import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:lab_2/routes/navigation_drawer.dart';
import 'package:lab_2/theme.dart';
import 'package:provider/provider.dart';

import 'custom_card.dart';


class Notifications extends StatefulWidget {
  const Notifications({Key? key}) : super(key: key);
  static const String routeName = '/notifications';

  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  final ScrollController _scrollController = ScrollController();
  List<String> items = [];
  bool loading = false, allLoaded = false;
  int _counter = 0;

  mockFetch() async {
    if (allLoaded) {
      return;
    }
    setState(() {
      loading = true;
    });
    await Future.delayed(const Duration(microseconds: 300));
    List<String> newData = items.length >= 60
        ? []
        : List.generate(20, (index) => "List Item ${index + items.length + 1}");
    if (newData.isNotEmpty) {
      items.addAll(newData);
    }
    setState(() {
      loading = false;
      allLoaded = newData.isEmpty;
    });
  }

  @override
  void initState() {
    super.initState();

    mockFetch();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent &&
          !loading) {
        mockFetch();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  void _incrementCounter(){
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.settings_display),
              onPressed: (){
                Provider.of<ThemeProvider>(context, listen: false).swapTheme();
              }
          )
        ],
      ),
      body:
      Center(
        child: Container(
            child: ListView.builder(
              itemCount: _counter,
              itemBuilder: (context, int index) {
                return CustomCard(
                  index: ++index,
                );
              },
            )),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.favorite),
      ),
      drawer: NavigationDrawer(),
    );
  }
}


