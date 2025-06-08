import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:interactive_calendar/ui/bottom_navbar.dart';

class ScaffoldWithBottomNavbar extends StatelessWidget {
  /// Constructs an [ScaffoldWithNavBar].
  const ScaffoldWithBottomNavbar({
    required this.navigationShell,
    Key? key,
  }) : super(key: key ?? const ValueKey<String>('ScaffoldWithNavBar'));

  /// The navigation shell and container for the branch Navigators.
  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: BottomNavbar(navigationShell: navigationShell),
    );
  }
}