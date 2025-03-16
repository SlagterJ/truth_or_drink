import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:mobile_scanner/mobile_scanner.dart";
import "package:provider/provider.dart";
import "package:shared_preferences/shared_preferences.dart";
import "package:truth_or_drink/pages/game_active_page.dart";
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
  List<String> players = [];

  @override
  void initState() {
    super.initState();

    void initStateAsync() async {
      final database = Provider.of<db.AppDatabase>(context, listen: false);
      final preferences = SharedPreferencesAsync();

      final deckTitle_ = await database.getDeckTitle(widget.deckId);
      // get the cards here so that there is no load time during gameplay
      final cards_ = await database.selectCardsFromDeck(widget.deckId);

      String? username = await preferences.getString("username");

      var players_ = players;
      if (username != null) players_.add(username);

      setState(() {
        deckTitle = deckTitle_;
        cards = cards_;
        players = players_;
      });
    }

    initStateAsync();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Spel instellen"), centerTitle: true),
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

            const Text(
              "Spelers",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            players.isNotEmpty
                ? ListView.builder(
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
                )
                : const Text("Er zijn nog geen spelers..."),
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
        onPressed: () {
          if (deckTitle == null) return;
          if (cards == null) return;
          if (players.isEmpty || players.length < 2) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Je moet meer spelers toevoegen!")),
            );
            return;
          }

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) {
                return GameActivePage(
                  deckTitle: deckTitle!,
                  cards: cards!,
                  players: players,
                );
              },
            ),
          );
        },
        label: const Text("Start spel"),
        icon: const Icon(Icons.play_arrow),
      ),
    );
  }

  void _submitName(BuildContext context, String name) {
    if (name == "") {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Een spelers naam mag niet leeg zijn!")),
      );

      return;
    }

    final newPlayers = players;
    newPlayers.add(name);

    setState(() {
      players = newPlayers;
    });

    Navigator.pop(context);
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
                      HapticFeedback.vibrate();
                      Navigator.pop(context);
                    },
                  ),
                ),
                const Divider(),
                TextButton(
                  child: const Text("Voeg handmatig toe"),
                  onPressed: () {
                    _buildAddPlayerManuallyDialog();
                  },
                ),
              ],
            ),
          ),
    );
  }

  _buildAddPlayerManuallyDialog() {
    final nameController = TextEditingController();

    showDialog(
      context: context,
      builder:
          (_) => Dialog(
            child: SizedBox(
              height: 250,
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text("Nieuwe speler"),
                    const SizedBox(height: 30.0),
                    TextField(
                      controller: nameController,
                      decoration: const InputDecoration(
                        label: Text("Naam"),
                        border: OutlineInputBorder(),
                      ),
                      onSubmitted: (_) {
                        _submitName(context, nameController.text);
                      },
                    ),
                    const SizedBox(height: 10.0),
                    TextButton(
                      child: const Text("Bevestig"),
                      onPressed: () {
                        _submitName(context, nameController.text);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
    );
  }
}
