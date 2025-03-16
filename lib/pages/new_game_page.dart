import "package:flutter/material.dart";
import "package:provider/provider.dart";
import "package:truth_or_drink/pages/decks_page.dart";

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
        final List<Deck>? decks = snapshot.data;

        if (decks == null) {
          return CircularProgressIndicator();
        }

        if (decks.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text("Er zijn nog geen kaartenspellen..."),
                const SizedBox(height: 10),
                TextButton(
                  child: const Text("Naar het kaartenspellenmenu"),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => DecksPage()),
                    );
                  },
                ),
              ],
            ),
          );
        }

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
