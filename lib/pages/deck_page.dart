import "package:flutter/material.dart";
import "package:provider/provider.dart";
import "package:truth_or_drink/services/database.dart" as db;
import "package:truth_or_drink/widgets/card_item.dart";
import "package:truth_or_drink/widgets/card_suggestions.dart";

class DeckPage extends StatelessWidget {
  const DeckPage({super.key, required this.id, required this.title});

  final int id;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Kaartenspellen: $title"), centerTitle: true),
      body: _buildCardList(context),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => _buildShowBottomSheet(context),
      ),
    );
  }

  Future<dynamic> _buildShowBottomSheet(BuildContext context) {
    return showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) => _buildCardBottomSheet(context),
    );
  }

  Widget _buildCardBottomSheet(BuildContext context) {
    final database = Provider.of<db.AppDatabase>(context);
    final questionController = TextEditingController();

    void submitCard() {
      if (questionController.text == "") {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("De vraag mag niet leeg zijn!")),
        );

        return;
      }

      try {
        database.insertCard(questionController.text, id);
        Navigator.pop(context);
      } catch (_) {
        showDialog(
          context: context,
          builder:
              (_) => Dialog(
                child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: const Text(
                    "Er is iets misgegaan bij het aanmaken van dit kaartenspel.",
                  ),
                ),
              ),
        );
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
            const Text("Nieuwe kaart"),
            const SizedBox(height: 20),
            TextField(
              controller: questionController,
              decoration: const InputDecoration(
                labelText: "Vraag",
                border: OutlineInputBorder(),
              ),
              onSubmitted: (_) {
                submitCard();
              },
            ),
            const SizedBox(height: 20),
            FilledButton.tonal(
              onPressed: submitCard,
              child: const Text("Kaart aanmaken"),
            ),
            const Divider(),
            TextButton(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Icon(Icons.stars),
                  SizedBox(width: 10.0),
                  Text("Suggestie"),
                ],
              ),
              onPressed: () {
                showDialog(
                  context: context,
                  builder:
                      (_) => CardSuggestions(
                        onConfirm: (suggestion) {
                          questionController.text = suggestion;
                          submitCard();
                        },
                      ),
                );
              },
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
        final List<db.Card>? cards = snapshot.data;

        if (cards == null) {
          return CircularProgressIndicator();
        }

        if (cards.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text("Er zijn nog geen kaarten..."),
                const SizedBox(height: 10),
                TextButton(
                  child: const Text("Maak er een"),
                  onPressed: () => _buildShowBottomSheet(context),
                ),
              ],
            ),
          );
        }

        return ListView.builder(
          itemCount: cards.length,
          itemBuilder: (_, index) {
            final card = cards[index];
            return CardItem(id: card.id, question: card.question);
          },
        );
      },
    );
  }
}
