import "package:flutter/material.dart";

class DeckPage extends StatelessWidget {
  const DeckPage({super.key, required this.id, required this.title});

  final int id;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title), centerTitle: true),
      body: Center(child: Text(title)),
    );
  }
}
