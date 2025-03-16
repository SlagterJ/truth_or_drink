import "package:flutter/material.dart";
import "package:provider/provider.dart";

import "../services/database.dart";
import "../widgets/new_game_deck_item.dart";

class NewGamePage extends StatelessWidget {
  const NewGamePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Nieuw spel"), centerTitle: true),
      body: Center(child: _buildDeckList(context)),
    );
  }

  StreamBuilder<List<Deck>> _buildDeckList(BuildContext context) {
    final database = Provider.of<AppDatabase>(context);

    return StreamBuilder(
      stream: database.watchAllDecks(),
      builder: (_, AsyncSnapshot<List<Deck>> snapshot) {
        final decks = snapshot.data ?? [];

        return ListView.builder(
          itemCount: decks.length,
          itemBuilder: (_, index) {
            final deck = decks[index];
            return NewGameDeckItem(id: deck.id, title: deck.title);
          },
        );
      },
    );
  }
}
