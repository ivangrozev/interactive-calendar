import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BottomNavbar extends StatefulWidget {
  const BottomNavbar({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  State<BottomNavbar> createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {
  void _onTap(index) {
    widget.navigationShell.goBranch(index,
        initialLocation: index == widget.navigationShell.currentIndex);
  }

  final List<BottomNavigationBarItem> barItems = const [
    BottomNavigationBarItem(
      label: "Calendar",
      icon: Icon(Icons.calendar_month),
    ),
    BottomNavigationBarItem(
      label: "Profile",
      icon: Icon(Icons.account_circle),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        backgroundColor: const Color.fromARGB(255, 20, 19, 79),
        type: BottomNavigationBarType.fixed,
        elevation: 2.1,
        onTap: _onTap,
        currentIndex: widget.navigationShell.currentIndex,
        selectedItemColor: const Color.fromARGB(255, 60, 228, 237),
        unselectedItemColor: const Color.fromARGB(255, 255, 255, 255),
        items: [...barItems]);
  }
}
