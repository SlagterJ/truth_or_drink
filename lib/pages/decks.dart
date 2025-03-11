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
            () => showDialog(
              context: context,
              builder:
                  (context) => Dialog.fullscreen(child: createDeckDialog()),
            ),
      ),
    );
  }

  Scaffold createDeckDialog() {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Voeg kaartenspel toe"),
        centerTitle: true,
      ),
      body: const Center(child: Text("Voeg kaartenspel toe!")),
    );
  }
}
