import "package:flutter/material.dart";
import "package:truth_or_drink/pages/new_game_page.dart";

import "../decks_page.dart";

class GamePage extends StatelessWidget {
  const GamePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Column(
        children: [
          Expanded(flex: 1, child: Container()),
          Text(
            "Spel",
            style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
          ),
          Expanded(flex: 2, child: Container()),
          ListTile(
            leading: const Icon(Icons.star),
            trailing: const Icon(Icons.chevron_right),
            title: const Text("Nieuw spel"),
            subtitle: const Text("Start een nieuw spel"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const NewGamePage()),
              );
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.style),
            trailing: const Icon(Icons.chevron_right),
            title: const Text("Kaartenspellen"),
            subtitle: const Text(
              "Bekijk, verwijder, deel en pas kaartenspellen aan",
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const DecksPage()),
              );
            },
          ),
        ],
      ),
    );
  }
}
