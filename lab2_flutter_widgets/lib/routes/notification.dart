import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';


class Notifications extends StatefulWidget {
  const Notifications({Key? key}) : super(key: key);

  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  final ScrollController _scrollController = ScrollController();
  List<String> items = [];
  bool loading = false, allLoaded = false;

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
    // TODO: implement dispose
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
      ),
      body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            if (items.isNotEmpty) {
              return Stack(
                children: [
                  ListView.separated(
                      controller: _scrollController,
                      itemBuilder: (context, index) {
                        if (index < items.length) {
                          if (index.isEven) {
                            return Card(
                              child: ListTile(
                                title: Text("User${index + 1} likes your post."),
                                trailing: const Icon(Icons.favorite),
                              ),
                            );
                          } else {
                            return Expanded(
                              child: ListTile(
                                leading: const FlutterLogo(),
                                title: Text(
                                    "Seems you should be interested in topic${index + 1}"),
                              ),
                            );
                          }
                        } else {
                          return SizedBox(
                            width: constraints.maxWidth,
                            height: 50,
                            child: const Center(
                              child: Text('No notifications any more'),
                            ),
                          );
                        }
                      },
                      separatorBuilder: (context, index) {
                        return const Divider(height: 1);
                      },
                      itemCount: items.length + (allLoaded ? 1 : 0)),
                  if (loading) ...[
                    Positioned(
                      left: 0,
                      bottom: 0,
                      child: SizedBox(
                        width: constraints.maxWidth,
                        height: 80,
                        child: const Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                    ),
                  ]
                ],
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.redAccent,
              ),
              child: Center(
                child: ListTile(
                  title: Text('Settings',
                      style:
                      TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                  subtitle: Text('Turn on/off the notifications:',
                      style:
                      TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
                ),
              ),
            ),
            Card(
              child: ListTile(
                leading: const Icon(Icons.subscriptions_outlined),
                title: const Text('Subscription'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ),
            Card(
              child: ListTile(
                leading: const Icon(Icons.favorite),
                title: const Text('Likes'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ),
            Card(
              child: ListTile(
                leading: const Icon(Icons.image_outlined),
                title: const Text('Suggestion'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}


