import "package:flutter/material.dart";
import "package:flutter_slidable/flutter_slidable.dart";
import "package:provider/provider.dart";
import "package:truth_or_drink/services/database.dart";

class CardItem extends StatelessWidget {
  const CardItem({super.key, required this.id, required this.question});

  final int id;
  final String question;

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(
        motion: BehindMotion(),
        children: [
          SlidableAction(
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: "Verwijder",
            onPressed: (_) {
              showDialog(
                context: context,
                builder:
                    (_) => Dialog(
                      child: SizedBox(
                        height: 150,
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Weet je zeker dat je de kaart '$question' wilt verwijderen?",
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  TextButton(
                                    child: const Text("Annuleren"),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                  TextButton(
                                    child: const Text("Verwijderen"),
                                    onPressed: () {
                                      final database = Provider.of<AppDatabase>(
                                        context,
                                        listen: false,
                                      );

                                      database.deleteCard(id);

                                      Navigator.pop(context);
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
              );
            },
          ),
        ],
      ),
      child: ListTile(
        title: Text(question),
        leading: const Icon(Icons.help_center),
      ),
    );
  }
}
