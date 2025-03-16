import "package:flutter/material.dart";
import "package:provider/provider.dart";
import "package:truth_or_drink/services/database.dart";

import "../pages/game_setup_page.dart";

class NewGameDeckItem extends StatelessWidget {
  const NewGameDeckItem({super.key, required this.id, required this.title});

  final int id;
  final String title;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      subtitle: _buildCardCount(context, id),
      leading: const Icon(Icons.quiz),
      trailing: const Icon(Icons.chevron_right),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => GameActivePage(deckId: id)),
        );
      },
    );
  }

  StreamBuilder<int> _buildCardCount(BuildContext context, int id) {
    final database = Provider.of<AppDatabase>(context);

    return StreamBuilder(
      stream: database.watchCardCount(id),
      builder: (_, AsyncSnapshot<int> snapshot) {
        final int? count = snapshot.data;

        if (count == null) {
          return const CircularProgressIndicator();
        }

        // make the 'kaarten' text grammatically correct
        final pluralText = count == 1 ? "kaart" : "kaarten";

        return Text("Bevat $count $pluralText");
      },
    );
  }
}
