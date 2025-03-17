import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CardSuggestions extends StatefulWidget {
  const CardSuggestions({super.key, required this.onConfirm});

  final Function(String) onConfirm;

  @override
  State<CardSuggestions> createState() => _CardSuggestionsState();
}

class _CardSuggestionsState extends State<CardSuggestions> {
  String? suggestion;

  @override
  void initState() {
    super.initState();

    void showError() {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Er was een fout bij het verkrijgen van een suggestie"),
        ),
      );
      Navigator.pop(context);
    }

    void initStateAsync() async {
      final response = await http.get(
        Uri.parse("https://api.truthordarebot.xyz/v1/truth"),
      );

      if (response.statusCode != 200) {
        showError();
      }

      final data = jsonDecode(response.body.toString());

      setState(() {
        suggestion = data["question"];
      });
    }

    initStateAsync();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog.fullscreen(
      child: Center(
        child:
            suggestion != null
                ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    FittedBox(
                      fit: BoxFit.contain,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 40),
                        child: Text(
                          suggestion!,
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        FilledButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(Icons.cancel),
                              SizedBox(width: 10),
                              Text("Weiger"),
                            ],
                          ),
                        ),
                        FilledButton(
                          onPressed: () {
                            widget.onConfirm(suggestion!);
                            Navigator.pop(context);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(Icons.check),
                              SizedBox(width: 10),
                              Text("Accepteer"),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                )
                : CircularProgressIndicator(),
      ),
    );
  }
}
