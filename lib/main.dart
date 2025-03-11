import "package:flutter/material.dart";
import "package:truth_or_drink/pages/root/game.dart";
import "package:truth_or_drink/pages/root/participate.dart";
import "package:truth_or_drink/pages/root/user.dart";

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Truth or Drink",
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.pink),
      ),
      home: const AppRoot(title: "Truth or Drink"),
    );
  }
}

class AppRoot extends StatefulWidget {
  const AppRoot({super.key, required this.title});

  final String title;

  @override
  State<AppRoot> createState() => _AppRootState();
}

class _AppRootState extends State<AppRoot> {
  int currentPageIndex = 0;
  final List<Widget> pages = [
    const GamePage(),
    const ParticipatePage(),
    const UserPage(),
  ];

  int getCurrentPageIndex() {
    return currentPageIndex < pages.length && currentPageIndex >= 0
        ? currentPageIndex
        : 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title), centerTitle: true),

      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        selectedIndex: getCurrentPageIndex(),
        destinations: [
          NavigationDestination(
            icon: const Icon(Icons.sports_bar),
            label: "Spel",
          ),
          NavigationDestination(
            icon: const Icon(Icons.qr_code_scanner),
            label: "Deelnemen",
          ),
          NavigationDestination(
            icon: const Icon(Icons.account_circle),
            label: "Jij",
          ),
        ],
      ),

      body: pages[getCurrentPageIndex()],
    );
  }
}
