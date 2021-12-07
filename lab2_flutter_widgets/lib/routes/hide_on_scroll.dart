import 'package:flutter/material.dart';
import 'package:lab_2/routes/notification.dart';
import 'package:lab_2/routes/profile.dart';
import 'package:lab_2/routes/calls_page.dart';
import 'package:badges/badges.dart';


class HideOnScroll extends StatefulWidget {
  const HideOnScroll({Key? key}) : super(key: key);

  @override
  _HideOnScrollState createState() => _HideOnScrollState();
}

class _HideOnScrollState extends State<HideOnScroll>
    with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;
  late AnimationController animationController;
  late List<Widget> _pages;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));

    _pages = <Widget>[
      CallsPage(
        isHideBottomNavBar: (isHideBottomNavBar) {
          isHideBottomNavBar
              ? animationController.forward()
              : animationController.reverse();
        },
      ),
      const Notifications(),
      const Profile(),
    ];
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        children: _pages,
        index: _selectedIndex,
      ),
      bottomNavigationBar: SizeTransition(
        sizeFactor: animationController,
        axisAlignment: -1.0,
        child: BottomNavigationBar(
          showSelectedLabels: false,
          showUnselectedLabels: false,
          items: <BottomNavigationBarItem>[
            const BottomNavigationBarItem(
              label: 'Home',
              icon: Icon(Icons.home_filled),
            ),
            BottomNavigationBarItem(
              icon: Stack(
                  children: <Widget>[
                    Badge(
                      badgeContent: Text(""),
                      child: const Icon(Icons.chat_rounded),
                    )
                  ]
              ),
              label: 'Notifications',
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.account_circle),
              label: 'Profile',
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}