import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int _bottomNavIndex = 0;

  List<IconData> iconsList = [
    Icons.whatshot_sharp,
    Icons.settings,
  ];
  @override
  Widget build(BuildContext context) {
    return AnimatedBottomNavigationBar(
      icons: iconsList,elevation: 3,
      rightCornerRadius: 40,
      leftCornerRadius: 40,
      height: 50,
      shadow: Shadow(color: Colors.deepPurple,blurRadius: 10),

      backgroundColor: Colors.black,
      notchSmoothness:NotchSmoothness.defaultEdge,
      activeIndex: _bottomNavIndex,
      activeColor: Colors.deepPurple.shade400, // Set the color for the active icon
      inactiveColor: Colors.white, // Set the color for inactive icons
      onTap: (index) => setState(() => _bottomNavIndex = index),
      gapLocation: GapLocation.center,
    );
  }
}
