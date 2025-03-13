import "package:flutter/material.dart";
import "package:flutter_slidable/flutter_slidable.dart";
import "package:provider/provider.dart";
import "package:qr_flutter/qr_flutter.dart";
import "package:truth_or_drink/pages/deck_page.dart";
import "package:truth_or_drink/services/database.dart";

class DeckItem extends StatelessWidget {
  const DeckItem({super.key, required this.id, required this.title});

  final int id;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Slidable(
      startActionPane: ActionPane(
        motion: BehindMotion(),
        children: [
          SlidableAction(
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
            icon: Icons.share,
            label: "Delen",
            onPressed: (_) {
              showDialog(
                context: context,
                builder:
                    (_) => Dialog(
                      child: Padding(
                        padding: EdgeInsets.all(25.0),
                        child: QrImageView(
                          data: title,
                          version: QrVersions.auto,
                        ),
                      ),
                    ),
              );
            },
          ),
        ],
      ),
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
                          padding: EdgeInsets.all(20.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Weet je zeker dat je kaartenspel '$title' wilt verwijderen? Dit zal ook alle kaarten in dit spel verwijderen.",
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

                                      database.deleteDeck(id);

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
        title: Text(title),
        subtitle: Text("Bevat 0 kaarten"),
        trailing: Icon(Icons.chevron_right),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => DeckPage(id: id, title: title)),
          );
        },
      ),
    );
  }
}
