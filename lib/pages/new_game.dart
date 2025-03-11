import "package:flutter/material.dart";

class NewGamePage extends StatelessWidget {
  const NewGamePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Nieuw spel"), centerTitle: true),
      body: const Center(child: Text("Nieuw spel!")),
    );
  }
}
