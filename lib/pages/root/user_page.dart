import "package:flutter/material.dart";
import "package:shared_preferences/shared_preferences.dart";

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
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
          Expanded(flex: 1, child: Container()),
          name != ""
              ? Text(
                name,
                style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
              )
              : CircularProgressIndicator(),
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

  void _getName() async {
    final preferences = SharedPreferencesAsync();

    final storedName = await preferences.getString("username") ?? "";

    setState(() {
      name = storedName;
    });
  }
}
