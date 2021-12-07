import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;


class ImageHero {
  final String img;
  final String author;
  final String link;

  ImageHero(this.img, this.author, this.link);
}

class MainPage extends StatefulWidget {
  final Function(bool) isHideBottomNavBar;
  static const String routeName = '/main';

  MainPage({required this.isHideBottomNavBar});

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>
    with AutomaticKeepAliveClientMixin<MainPage> {
  int count = 10;
  List data = [];
  List imagesUrl = [];
  List imagesAuthor = [];
  List imagesPath = [];
  List<ImageHero> imageHero = <ImageHero>[];

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

  parseJson(data){
    jsonDecode(data).forEach((element) {
      imagesUrl.add(element['download_url']);
      imagesAuthor.add(element['author']);
      imagesPath.add(element['url']);
      imageHero.add(ImageHero(
          element['download_url'], element['author'], element['url']));
    });
  }

  Future<String> fetchDataFromApi() async {
    var jsonData = await http.get(
        Uri.parse("https://picsum.photos/v2/list?page=2&limit=50"),
        headers: {
          "Accept": "application/json",
          "Access-Control-Allow-Origin": "*"
        });
    setState(() {
      parseJson(jsonData.body);
    });
    return "Success";
  }

  @override
  void initState() {
    super.initState();
    fetchDataFromApi();
  }

  Widget ImageHeroCell(BuildContext context, int index) {
    return GestureDetector(
        onTap: () {
          final snackBar = SnackBar(content: Text("Tap"));
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => MyDetailPage(imageHero[index])));
        },
        child: SingleChildScrollView(
            child: Column(children: [
          Card(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Image.network(imagesUrl[index], fit: BoxFit.contain),
                ListTile(
                  title: Text('Author: ' + imagesAuthor[index]),
                  subtitle: Text('Link: ' + imagesPath[index]),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    IconButton(
                      icon: const Icon(Icons.more_horiz_rounded),
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
        ])));
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: _handleScrollNotification,
      child: Scaffold(
        body: Center(
          child: GridView.builder(
            gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            itemCount: imagesUrl.length,
            itemBuilder: (BuildContext context, int index) {
              return ImageHeroCell(context, index);
            },
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class MyDetailPage extends StatefulWidget {
  late ImageHero _superHero;

  MyDetailPage(ImageHero superHero) {
    _superHero = superHero;
  }

  @override
  _MyDetailPageState createState() => _MyDetailPageState(_superHero);
}

class _MyDetailPageState extends State<MyDetailPage> {
  ImageHero superHero;

  _MyDetailPageState(this.superHero);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Author: ' + superHero.author),
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Hero(
            transitionOnUserGestures: true,
            tag: superHero,
            child: Transform.scale(
              scale: 2.0,
              child: Image.network(superHero.img),
            ),
          ),
          Card(
              elevation: 8,
              margin: const EdgeInsets.all(16),
              child: Container(
                padding: const EdgeInsets.all(16),
                child: Text('Link to photo: ' + superHero.link),
              )),
        ],
      )),
    );
  }
}
