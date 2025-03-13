import "package:flutter/material.dart";
import "package:truth_or_drink/pages/deck.dart";

class DeckItem extends StatelessWidget {
  const DeckItem({super.key, required this.id, required this.title});

  final int id;
  final String title;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      subtitle: Text("Bevat 0 kaarten"),
      trailing: Icon(Icons.chevron_right),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => DeckPage(id: id, title: title)),
        );
      },
    );
  }
}
