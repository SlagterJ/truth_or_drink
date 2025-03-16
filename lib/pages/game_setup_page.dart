import "package:flutter/material.dart";

class GameSetupPage extends StatelessWidget {
  const GameSetupPage({super.key, required this.deckId});

  final int deckId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Spel"), centerTitle: true),
      body: Flexible(
        child: Column(
          children: [
            Expanded(flex: 1, child: Container()),
            Text("Game with deckId $deckId"),
            Expanded(flex: 1, child: Container()),
          ],
        ),
      ),
    );
  }
}
