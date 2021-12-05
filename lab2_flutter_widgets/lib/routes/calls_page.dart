import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:lab_2/routes/favourites.dart';
import 'package:lab_2/routes/main_page.dart';


class CallsPage extends StatelessWidget {
  CallsPage({required this.isHideBottomNavBar});

  final Function(bool) isHideBottomNavBar;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          flexibleSpace: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: const [
              TabBar(
                tabs: [
                  Tab(
                    text: 'All pins',
                  ),
                  Tab(
                    text: 'Favourites',
                  )
                ],
              )
            ],
          ),
        ),
        body: TabBarView(
          children: [
            MainPage(
              isHideBottomNavBar: (value) {
                isHideBottomNavBar(value);
              },
            ),
            Favourites(
              isHideBottomNavBar: (value) {
                isHideBottomNavBar(value);
              },
            ),
          ],
        ),
      ),
    );
  }
}