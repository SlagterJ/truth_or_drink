import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:provider/provider.dart";
import "package:truth_or_drink/pages/home_page.dart";
import "package:truth_or_drink/services/database.dart";

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: [SystemUiOverlay.bottom],
    );

    return MultiProvider(
      providers: [Provider<AppDatabase>(create: (_) => AppDatabase())],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Truth or Drink",
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.pink),
        ),
        home: HomePage(),
      ),
    );
  }
}
