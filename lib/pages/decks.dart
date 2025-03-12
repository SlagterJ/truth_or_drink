import "package:flutter/material.dart";

class DecksPage extends StatelessWidget {
  const DecksPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Kaartenspellen"), centerTitle: true),
      body: const Center(child: Text("Geen kaartenspellen gevonden...")),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed:
            () => showModalBottomSheet(
              context: context,
              builder:
                  (context) =>
                      Dialog.fullscreen(child: _buildDeckBottomSheet(context)),
            ),
      ),
    );
  }

  Widget _buildDeckBottomSheet(BuildContext context) {
    return SizedBox(
      height: 275,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
        child: Column(
          children: [
            const Text("Maak een kaartspel aan"),
            const SizedBox(height: 20),
            const TextField(
              decoration: InputDecoration(
                labelText: "Titel",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            FilledButton.tonal(
              onPressed: () {
                print("Send it button pressed");
                Navigator.pop(context);
              },
              child: const Text("Kaartenspel aanmaken"),
            ),
          ],
        ),
      ),
    );
  }
}
