import "package:flutter/material.dart";
import "package:qr_flutter/qr_flutter.dart";
import "package:shared_preferences/shared_preferences.dart";
import "package:truth_or_drink/pages/new_game_page.dart";

class ParticipatePage extends StatefulWidget {
  const ParticipatePage({super.key});

  @override
  State<ParticipatePage> createState() => _ParticipatePageState();
}

class _ParticipatePageState extends State<ParticipatePage> {
  String name = "";

  @override
  void initState() {
    super.initState();
    _getName();
  }

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Column(
        children: [
          Expanded(flex: 2, child: Container()),
          Padding(
            padding: EdgeInsets.all(40.0),
            child: Card(
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child:
                    name != ""
                        ? QrImageView(data: name, version: QrVersions.auto)
                        : CircularProgressIndicator(),
              ),
            ),
          ),
          Expanded(flex: 1, child: Container()),
          const Text("Laat deze code gescand worden door de host"),
          TextButton(
            child: const Text("Host je eigen spel"),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => NewGamePage()),
              );
            },
          ),
          Expanded(flex: 1, child: Container()),
        ],
      ),
    );
  }

  void _getName() async {
    final preferences = SharedPreferencesAsync();

    final storedName = await preferences.getString("username") ?? "";

    setState(() {
      name = storedName;
    });
  }
}
