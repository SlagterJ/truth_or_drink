import "package:flutter/material.dart";

class GameActivePage extends StatelessWidget {
  const GameActivePage({super.key, required this.deckId});

  final int deckId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Spel"), centerTitle: true),
      body: Text("Game with deckId $deckId"),
    );
  }
}
