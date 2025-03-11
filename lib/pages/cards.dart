import "package:flutter/material.dart";

class CardsPage extends StatelessWidget {
  const CardsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Kaartenspellen"), centerTitle: true),
      body: const Center(child: Text("Card page!")),
    );
  }
}
