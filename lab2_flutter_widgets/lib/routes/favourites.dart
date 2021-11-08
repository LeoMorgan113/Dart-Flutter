import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Favourites extends StatefulWidget {
  final Function(bool) isHideBottomNavBar;
  static const String routeName = '/favourites';

  Favourites({required this.isHideBottomNavBar});

  @override
  _FavouritesState createState() => _FavouritesState();
}

class _FavouritesState extends State<Favourites>
    with AutomaticKeepAliveClientMixin<Favourites> {
  int count = 10;
  List data = [];
  List imagesUrl = [];

  bool _handleScrollNotification(ScrollNotification notification) {
    if (notification.depth == 0) {
      if (notification is UserScrollNotification) {
        final UserScrollNotification userScroll = notification;
        switch (userScroll.direction) {
          case ScrollDirection.forward:
            widget.isHideBottomNavBar(true);
            break;
          case ScrollDirection.reverse:
            widget.isHideBottomNavBar(false);
            break;
          case ScrollDirection.idle:
            break;
        }
      }
    }
    return false;
  }

  Future<String> fetchDataFromApi() async {
    var jsonData = await http.get(
        Uri.parse("https://picsum.photos/v2/list?page=2&limit=10"),
        headers: {
          "Accept": "application/json",
          "Access-Control-Allow-Origin": "*"
        });
    var fetchData = jsonDecode(jsonData.body);
    setState(() {
      data = fetchData;
      data.forEach((element) {
        imagesUrl.add(element['download_url']);
      });
    });
    return "Success";
  }

  void clear() {
    setState(() {
      count = 0;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchDataFromApi();
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
        onNotification: _handleScrollNotification,
        child: Scaffold(
          body: Center(
            child: GridView.builder(
              gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              itemCount: imagesUrl.length,
              itemBuilder: (BuildContext context, int index) {
                return SingleChildScrollView(
                  child: Card(
                    child: Column(
                      children: <Widget>[
                        Image.network(
                          'https://picsum.photos/600/400?random=' +
                              index.toString(),
                          fit: BoxFit.fill,
                        ),
                        ListTile(
                          title: Text('Image' + (index + 1).toString()),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            IconButton(
                              icon: Icon(Icons.favorite_border_rounded),
                              color: Colors.redAccent,
                              onPressed: () {
                                /* ... */
                              },
                            ),
                            const SizedBox(width: 4),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ));
  }

  @override
  bool get wantKeepAlive => true;
}
