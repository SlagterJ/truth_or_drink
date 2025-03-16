import 'dart:math';

import 'package:flutter/material.dart';

import 'home_page.dart';

class GameActivePage extends StatefulWidget {
  const GameActivePage({
    super.key,
    required this.deckTitle,
    required this.questions,
    required this.players,
  });

  final String deckTitle;
  final List<String> questions;
  final List<String> players;

  @override
  State<GameActivePage> createState() => _GameActivePageState();
}

class _GameActivePageState extends State<GameActivePage> {
  List<Map<String, String>>? interactions;
  bool turnAccepted = false;

  @override
  void initState() {
    super.initState();

    List<Map<String, String>> interactions_ = [];

    for (var i = 0; i < widget.players.length; i++) {
      for (var j = 0; j < widget.players.length; j++) {
        if (i == j) continue;

        for (var question in widget.questions) {
          interactions_.add({
            "asker": widget.players[i],
            "receiver": widget.players[j],
            "question": question,
          });
        }
      }
    }

    interactions_.shuffle(Random());

    setState(() {
      interactions = interactions_;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Spel"), centerTitle: true),
      body: Flexible(
        child:
            interactions != null
                ? _buildGameLoop()
                : const Center(child: CircularProgressIndicator()),
      ),
    );
  }

  Widget _buildGameLoop() {
    if (interactions!.isEmpty) return _buildGameFinished();

    var interaction = interactions![0];
    var asker = interaction["asker"]!;
    var receiver = interaction["receiver"]!;
    var question = interaction["question"]!;

    return !turnAccepted
        ? _buildTurnStart(asker)
        : _buildQuestion(asker, receiver, question);
  }

  Widget _buildTurnStart(String asker) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(flex: 1, child: Container()),
        const Text("Geef de telefoon aan..."),
        const SizedBox(height: 10.0),
        Text(
          asker,
          style: TextStyle(fontSize: 100.0, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20.0),
        FilledButton(
          child: const Text("Ik ben er"),
          onPressed: () {
            setState(() {
              turnAccepted = true;
            });
          },
        ),
        Expanded(flex: 1, child: Container()),
      ],
    );
  }

  Widget _buildQuestion(String asker, String receiver, String question) {
    var question = interactions![0]["question"]!;

    void finishQuestion() {
      setState(() {
        interactions!.removeAt(0);
        turnAccepted = false;
      });
    }

    return Padding(
      padding: EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(flex: 3, child: Container()),
          Card.filled(
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40.0),
                    child: FittedBox(
                      fit: BoxFit.contain,
                      child: Text(
                        "$asker, vraag aan $receiver:",
                        style: TextStyle(fontSize: 400.0),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40.0),
                    child: FittedBox(
                      fit: BoxFit.contain,
                      child: Text(
                        question,
                        style: TextStyle(
                          fontSize: 400.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(flex: 1, child: Container()),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              FilledButton(
                onPressed: () {
                  finishQuestion();
                },
                child: const Row(
                  children: [
                    Icon(Icons.diamond),
                    SizedBox(width: 10.0),
                    Text("Truth!"),
                  ],
                ),
              ),
              FilledButton(
                onPressed: () {
                  finishQuestion();
                },
                child: const Row(
                  children: [
                    Icon(Icons.sports_bar),
                    SizedBox(width: 10.0),
                    Text("Drink!"),
                  ],
                ),
              ),
            ],
          ),

          Expanded(flex: 3, child: Container()),
        ],
      ),
    );
  }

  Widget _buildGameFinished() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(flex: 3, child: Container()),
        const Text("Het spel is afgelopen"),
        const SizedBox(height: 10.0),
        FilledButton(
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => HomePage()),
              (_) => false,
            );
          },
          child: const Text("Terug naar home"),
        ),
        Expanded(flex: 3, child: Container()),
      ],
    );
  }
}
