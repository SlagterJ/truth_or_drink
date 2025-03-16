import "package:flutter/material.dart";
import "package:shared_preferences/shared_preferences.dart";
import "package:truth_or_drink/pages/root/game_page.dart";
import "package:truth_or_drink/pages/root/participate_page.dart";
import "package:truth_or_drink/pages/root/user_page.dart";

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _currentPageIndex = 0;
  final _pages = [const GamePage(), const ParticipatePage(), const UserPage()];

  int getCurrentPageIndex() {
    return _currentPageIndex < _pages.length && _currentPageIndex >= 0
        ? _currentPageIndex
        : 0;
  }

  @override
  Widget build(BuildContext context) {
    _checkNameExists(context);

    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (index) {
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
            icon: const Icon(Icons.qr_code_outlined),
            selectedIcon: const Icon(Icons.qr_code),
            label: "Deelnemen",
          ),
          NavigationDestination(
            icon: const Icon(Icons.account_circle_outlined),
            selectedIcon: const Icon(Icons.account_circle),
            label: "Jij",
          ),
        ],
      ),

      body: _pages[getCurrentPageIndex()],
    );
  }

  void _checkNameExists(BuildContext context) async {
    final preferences = SharedPreferencesAsync();

    String? username = await preferences.getString("username");

    if (username != null) return;
    if (!context.mounted) return;

    var nameController = TextEditingController();

    void submitName() {
      if (nameController.text == "") {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Je naam mag niet leeg zijn!")),
        );

        return;
      }

      preferences.setString("username", nameController.text);

      Navigator.pop(context);
    }

    showDialog(
      context: context,
      barrierDismissible: false,
      builder:
          (_) => Dialog(
            child: SizedBox(
              height: 250,
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text("Geef jezelf een naam"),
                    const SizedBox(height: 30.0),
                    TextField(
                      controller: nameController,
                      decoration: const InputDecoration(
                        label: Text("Je naam"),
                        border: OutlineInputBorder(),
                      ),
                      onSubmitted: (_) {
                        submitName();
                      },
                    ),
                    const SizedBox(height: 10.0),
                    TextButton(
                      child: const Text("Bevestig"),
                      onPressed: () {
                        submitName();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
    );
  }
}
