import 'package:flutter/material.dart';
import 'package:stock_management/constant.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: const Column(),
      drawer: Drawer(
        backgroundColor: backgroundColor,
        child: ListView(
          children: [
            // Add your vertical menu items here
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () {
                // Logic to navigate to the home page
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {
                // Logic to navigate to the settings page
              },
            ),
          ],
        ),
      ),
    );
  }
}
