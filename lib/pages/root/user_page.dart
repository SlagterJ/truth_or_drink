import "package:flutter/material.dart";
import "package:shared_preferences/shared_preferences.dart";

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  String? name;

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
          name != null
              ? Padding(
                padding: EdgeInsets.symmetric(horizontal: 40.0),
                child: FittedBox(
                  // make the box as big as it can be
                  fit: BoxFit.contain,
                  child: Text(
                    name!,
                    style: TextStyle(
                      // make the text as big as it can be within the box
                      fontSize: 400.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
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
            onTap: () {
              final nameController = TextEditingController(text: name);

              void submitName() {
                if (nameController.text == "") {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Je naam mag niet leeg zijn!"),
                    ),
                  );
                  return;
                }

                final preferences = SharedPreferencesAsync();

                preferences.setString("username", nameController.text);

                _getName();
                Navigator.pop(context);
              }

              showModalBottomSheet(
                isScrollControlled: true,
                context: context,
                builder:
                    (_) => SizedBox(
                      height: 220 + MediaQuery.of(context).viewInsets.bottom,
                      child: Padding(
                        padding: EdgeInsets.only(
                          top: 30.0,
                          left: 20.0,
                          right: 20.0,
                          // make the sheet dodge the keyboard
                          bottom: MediaQuery.of(context).viewInsets.bottom,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text("Verander je naam"),
                            const SizedBox(height: 20),
                            TextField(
                              controller: nameController,
                              decoration: const InputDecoration(
                                label: Text("Je nieuwe naam"),
                                border: OutlineInputBorder(),
                              ),
                              onSubmitted: (_) {
                                submitName();
                              },
                            ),
                            const SizedBox(height: 20),
                            TextButton(
                              child: const Text("Bevestig"),
                              onPressed: () {
                                submitName();
                              },
                            ),
                            const SizedBox(height: 20),
                          ],
                        ),
                      ),
                    ),
              );
            },
          ),
        ],
      ),
    );
  }

  void _getName() async {
    final preferences = SharedPreferencesAsync();

    final storedName = await preferences.getString("username");

    setState(() {
      name = storedName;
    });
  }
}
