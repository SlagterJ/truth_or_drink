import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:mobile_scanner/mobile_scanner.dart";
import "package:provider/provider.dart";
import "package:truth_or_drink/services/database.dart";
import "package:truth_or_drink/widgets/deck_item.dart";

class DecksPage extends StatelessWidget {
  const DecksPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Kaartenspellen"), centerTitle: true),
      body: Center(child: _buildDeckList(context)),
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
      builder: (context) => _buildDeckBottomSheet(context),
    );
  }

  Widget _buildDeckBottomSheet(BuildContext context) {
    final database = Provider.of<AppDatabase>(context);
    final titleController = TextEditingController();

    void submitDeck() {
      if (titleController.text == "") {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("De titel mag niet leeg zijn!")),
        );

        return;
      }

      try {
        database.insertDeck(titleController.text);
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

    Future<dynamic> scanQRCode() {
      return showModalBottomSheet(
        context: context,
        builder:
            (_) => Padding(
              padding: EdgeInsets.all(20),
              child: MobileScanner(
                controller: MobileScannerController(
                  detectionSpeed: DetectionSpeed.normal,
                ),
                onDetect: (capture) {
                  HapticFeedback.vibrate();
                  Navigator.pop(context);
                },
              ),
            ),
      );
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
              onSubmitted: (_) {
                submitDeck();
              },
            ),
            const SizedBox(height: 20),
            FilledButton.tonal(
              onPressed: submitDeck,
              child: const Text("Kaartenspel aanmaken"),
            ),
            const Divider(),
            TextButton(
              onPressed: scanQRCode,
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
                  child: const Text("Maak er een"),
                  onPressed: () => _buildShowBottomSheet(context),
                ),
              ],
            ),
          );
        }

        return ListView.builder(
          itemCount: decks.length,
          itemBuilder: (_, index) {
            final deck = decks[index];
            return DeckItem(id: deck.id, title: deck.title);
          },
        );
      },
    );
  }
}
