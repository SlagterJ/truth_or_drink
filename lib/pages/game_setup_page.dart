import "package:flutter/material.dart";
import "package:mobile_scanner/mobile_scanner.dart";
import "package:provider/provider.dart";
import "package:truth_or_drink/services/database.dart" as db;

class GameSetupPage extends StatefulWidget {
  const GameSetupPage({super.key, required this.deckId});

  final int deckId;

  @override
  State<GameSetupPage> createState() => _GameSetupPageState();
}

class _GameSetupPageState extends State<GameSetupPage> {
  String? deckTitle;
  List<db.Card>? cards;
  List<String> players = ["John", "Erik"];

  @override
  void initState() {
    super.initState();

    void initStateAsync() async {
      final database = Provider.of<db.AppDatabase>(context, listen: false);

      final deckTitle_ = await database.getDeckTitle(widget.deckId);
      // get the cards here so that there is no load time during gameplay
      final cards_ = await database.selectCardsFromDeck(widget.deckId);

      setState(() {
        deckTitle = deckTitle_;
        cards = cards_;
      });
    }

    initStateAsync();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Spel"), centerTitle: true),
      body: Flexible(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(flex: 2, child: Container()),
            deckTitle != null
                ? Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40.0),
                  child: FittedBox(
                    fit: BoxFit.contain,
                    child: Text(
                      "Nieuw spel met kaartenspel '$deckTitle'",
                      style: TextStyle(
                        fontSize: 400.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                )
                : CircularProgressIndicator(),

            Expanded(flex: 1, child: Container()),

            const Text("Spelers"),
            ListView.builder(
              itemCount: players.length,
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemBuilder: (_, index) {
                final player = players[index];

                return ListTile(
                  leading: const Icon(Icons.person),
                  title: Text(player),
                );
              },
            ),
            TextButton(
              child: const Text("Voeg speler toe"),
              onPressed: () {
                _buildAddPlayerBottomSheet();
              },
            ),

            Expanded(flex: 2, child: Container()),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        label: const Text("Start spel"),
        icon: const Icon(Icons.play_arrow),
      ),
    );
  }

  _buildAddPlayerBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder:
          (_) => Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              children: [
                SizedBox(
                  height: 350.0,
                  width: 350.0,
                  child: MobileScanner(
                    controller: MobileScannerController(
                      detectionSpeed: DetectionSpeed.normal,
                    ),
                    onDetect: (capture) {
                      Navigator.pop(context);
                    },
                  ),
                ),
                const Divider(),
                TextButton(
                  child: const Text("Voeg handmatig toe"),
                  onPressed: () {},
                ),
              ],
            ),
          ),
    );
  }
}
