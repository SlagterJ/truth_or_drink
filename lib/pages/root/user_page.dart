import "package:flutter/material.dart";

class UserPage extends StatelessWidget {
  const UserPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Column(
        children: [
          Expanded(flex: 1, child: Container()),
          Text(
            "Jordy Slagter",
            style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
          ),
          Expanded(flex: 2, child: Container()),
          ListTile(
            title: const Text("Wijzig naam"),
            subtitle: const Text(
              "Wijzig de naam die zichtbaar is voor andere spelers",
            ),
            leading: const Icon(Icons.edit),
            trailing: const Icon(Icons.chevron_right),
          ),
          const Divider(),
          ListTile(
            title: const Text("Instellingen"),
            subtitle: const Text("Verander persoonlijke instellingen"),
            leading: const Icon(Icons.settings),
            trailing: const Icon(Icons.chevron_right),
          ),
        ],
      ),
    );
  }
}
