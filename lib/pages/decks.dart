import "package:flutter/material.dart";
import "package:provider/provider.dart";
import "package:truth_or_drink/services/database.dart";

class DecksPage extends StatelessWidget {
  const DecksPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Kaartenspellen"), centerTitle: true),
      body: Center(child: _buildDeckList(context)),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed:
            () => showModalBottomSheet(
              isScrollControlled: true,
              context: context,
              builder: (context) => _buildDeckBottomSheet(context),
            ),
      ),
    );
  }

  Widget _buildDeckBottomSheet(BuildContext context) {
    final database = Provider.of<AppDatabase>(context);
    final titleController = TextEditingController();

    void submitTitle() {
      if (titleController.text != "") {
        database.insertDeck(titleController.text);
        Navigator.pop(context);
      }
    }

    return SizedBox(
      height: 310 + MediaQuery.of(context).viewInsets.bottom,
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
            const Text("Nieuw kaartenspel"),
            const SizedBox(height: 20),
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                labelText: "Titel",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            FilledButton.tonal(
              onPressed: submitTitle,
              child: const Text("Kaartenspel aanmaken"),
            ),
            const Divider(),
            TextButton(
              onPressed: submitTitle,
              child: const Text("Importeer via QR-code"),
            ),
          ],
        ),
      ),
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
            return ListTile(title: Text(deck.title));
          },
        );
      },
    );
  }
}
