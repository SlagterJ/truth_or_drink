import "package:flutter/material.dart";

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView(
          children: [
            ListTile(
              leading: Icon(Icons.star),
              trailing: Icon(Icons.chevron_right),
              title: Text("Start nieuw spel"),
            ),
            ListTile(
              leading: Icon(Icons.apps),
              trailing: Icon(Icons.chevron_right),
              title: Text("Zie kaarten in"),
            ),
          ],
        ),
      ),
    );
  }
}
