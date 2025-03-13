import "package:flutter/material.dart";

class UserPage extends StatelessWidget {
  const UserPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Column(
        children: [
          Text(
            "Jordy Slagter",
            style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
          ),
          Expanded(flex: 1, child: Container()),
          ListTile(
            title: const Text("Wijzig naam"),
            leading: const Icon(Icons.edit),
            trailing: const Icon(Icons.chevron_right),
          ),
          ListTile(
            title: const Text("Instellingen"),
            leading: const Icon(Icons.settings),
            trailing: const Icon(Icons.chevron_right),
          ),
        ],
      ),
    );
  }
}
