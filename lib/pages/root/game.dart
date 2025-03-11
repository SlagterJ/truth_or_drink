import "package:flutter/material.dart";

import "../cards.dart";

class GamePage extends StatelessWidget {
  const GamePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ListTile(
          leading: Icon(Icons.star),
          trailing: Icon(Icons.chevron_right),
          title: Text("Nieuw spel"),
          subtitle: Text("Start een nieuw spel"),
        ),
        const Divider(),
        ListTile(
          leading: Icon(Icons.apps),
          trailing: Icon(Icons.chevron_right),
          title: Text("Kaartenspellen"),
          subtitle: Text("Bekijk, verwijder, deel en pas kaartenspellen aan"),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const CardsPage()),
            );
          },
        ),
      ],
    );
  }
}
