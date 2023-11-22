import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';
import 'package:shopify_app/pages/home_page.dart';

class MasterPage extends StatefulWidget {
  const MasterPage({
    super.key,
  });

  @override
  State<MasterPage> createState() => _MasterPageState();
}

class _MasterPageState extends State<MasterPage> {
  int _selectedIndex = 0;

  List<Widget> _pages = [
    HomePage(),
    Text(
      'Categories Page',
    ),
    Text(
      'Profile Page',
    ),
    Text(
      'Cart Page',
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {},
      //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: AnimatedBottomNavigationBar.builder(
        height: 50,
        onTap: (index) {
          _selectedIndex = index;
          setState(() {});
        },
        backgroundColor: Colors.black.withOpacity(.002),
        elevation: 0,
        gapLocation: GapLocation.none,
        notchSmoothness: NotchSmoothness.smoothEdge,
        leftCornerRadius: 15,
        rightCornerRadius: 15,
        activeIndex: _selectedIndex,
        itemCount: 4,
        tabBuilder: ((index, isActive) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                index == 0
                    ? LineIcons.home
                    : index == 1
                        ? LineIcons.icons
                        : index == 2
                            ? LineIcons.user
                            : LineIcons.shoppingCart,
                size: 25,
                color: isActive ? Colors.green : Colors.grey,
              ),
              Text(
                index == 0
                    ? 'Home'
                    : index == 1
                        ? 'Category'
                        : index == 2
                            ? 'Profile'
                            : 'Cart',
                style: TextStyle(
                  color: isActive ? Colors.green : Colors.grey,
                ),
              )
            ],
          );
        }),
      ),
      appBar: AppBar(
        title: Text('Let\'s Have Shopping..'),
      ),
      body: Column(
        children: <Widget>[_pages[_selectedIndex]],
      ),
    );
  }
}
