import 'package:flutter/material.dart';

import 'favorites_screen.dart';
import 'home_screen.dart';

class BottomNavBer extends StatefulWidget {
  final int initialindex;

  const BottomNavBer({super.key, this.initialindex = 0});

  @override
  State<BottomNavBer> createState() => _BottomNavBerState();
}

class _BottomNavBerState extends State<BottomNavBer> {
  late int currentIndex;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    currentIndex = widget.initialindex;
  }

  final List<Widget> screens = [
    Homescreen(), //0
    const FavoritesScreen() //1
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        elevation: 1,
        height: 65,
        color: Colors.white30,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.max,
          children: [
            IconButton(
              onPressed: () {
                setState(() {
                  currentIndex = 0;
                });
              },
              icon: Icon(
                  Icons.home_outlined,
                  size: 30,
                  color: currentIndex == 0 ? Colors.blue : Colors.grey.shade400
              ),
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  currentIndex = 1;
                });
              },
              icon: Icon(
                Icons.favorite_border_outlined,
                size: 30,
                color: currentIndex == 1 ? Colors.blue : Colors.grey.shade400,
              ),
            ),
          ],
        ),
      ),
      body: screens[currentIndex],
    );
  }
}
