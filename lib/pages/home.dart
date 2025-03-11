import "package:flutter/material.dart";
import "package:truth_or_drink/pages/root/game.dart";
import "package:truth_or_drink/pages/root/participate.dart";
import "package:truth_or_drink/pages/root/user.dart";

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentPageIndex = 0;
  final List<Widget> pages = [
    const GamePage(),
    const ParticipatePage(),
    const UserPage(),
  ];

  int getCurrentPageIndex() {
    return _currentPageIndex < pages.length && _currentPageIndex >= 0
        ? _currentPageIndex
        : 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title), centerTitle: true),

      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            _currentPageIndex = index;
          });
        },
        selectedIndex: getCurrentPageIndex(),
        destinations: [
          NavigationDestination(
            icon: const Icon(Icons.sports_bar_outlined),
            selectedIcon: const Icon(Icons.sports_bar),
            label: "Spel",
          ),
          NavigationDestination(
            icon: const Icon(Icons.qr_code_scanner_outlined),
            selectedIcon: const Icon(Icons.qr_code_scanner),
            label: "Deelnemen",
          ),
          NavigationDestination(
            icon: const Icon(Icons.account_circle_outlined),
            selectedIcon: const Icon(Icons.account_circle),
            label: "Jij",
          ),
        ],
      ),

      body: pages[getCurrentPageIndex()],
    );
  }
}
