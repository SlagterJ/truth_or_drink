import "package:flutter/material.dart";
import "package:qr_flutter/qr_flutter.dart";

class ParticipatePage extends StatelessWidget {
  const ParticipatePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(40.0),
        child: Card(
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: QrImageView(
              data: "Truth or Drink Test!",
              version: QrVersions.auto,
            ),
          ),
        ),
      ),
    );
  }
}
