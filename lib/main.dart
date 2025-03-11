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
        selectedIndex: currentPageIndex,
        destinations: [
          NavigationDestination(icon: Icon(Icons.sports_bar), label: "Spel"),
          NavigationDestination(
            icon: Icon(Icons.qr_code_scanner),
            label: "Deelnemen",
          ),
          NavigationDestination(icon: Icon(Icons.account_circle), label: "Jij"),
        ],
      ),

      body: pages[currentPageIndex],
    );
  }
}
