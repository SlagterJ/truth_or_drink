import "package:flutter/material.dart";
import "package:provider/provider.dart";
import "package:truth_or_drink/services/database.dart" as db;

class DeckPage extends StatelessWidget {
  const DeckPage({super.key, required this.id, required this.title});

  final int id;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title), centerTitle: true),
      body: _buildCardList(context),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed:
            () => showModalBottomSheet(
              isScrollControlled: true,
              context: context,
              builder: (context) => _buildCardBottomSheet(context),
            ),
      ),
    );
  }

  Widget _buildCardBottomSheet(BuildContext context) {
    final database = Provider.of<db.AppDatabase>(context);
    final questionController = TextEditingController();

    void submitCard() {
      if (questionController.text != "") {
        database.insertCard(questionController.text, id);
        Navigator.pop(context);
      }
    }

    return SizedBox(
      height: 250 + MediaQuery.of(context).viewInsets.bottom,
      child: Padding(
        padding: EdgeInsets.only(
          top: 30.0,
          left: 20.0,
          right: 20.0,
          // make the sheet dodge the keyboard
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Column(
          children: [
            const Text("Nieuwe kaart"),
            const SizedBox(height: 20),
            TextField(
              controller: questionController,
              decoration: const InputDecoration(
                labelText: "Vraag",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            FilledButton.tonal(
              onPressed: submitCard,
              child: const Text("Kaart aanmaken"),
            ),
          ],
        ),
      ),
    );
  }

  StreamBuilder<List<db.Card>> _buildCardList(BuildContext context) {
    final database = Provider.of<db.AppDatabase>(context);

    return StreamBuilder(
      stream: database.watchCardsFromDeck(id),
      builder: (_, AsyncSnapshot<List<db.Card>> snapshot) {
        final cards = snapshot.data ?? [];

        return ListView.builder(
          itemCount: cards.length,
          itemBuilder: (_, index) {
            final card = cards[index];
            return Text(card.question);
          },
        );
      },
    );
  }
}
