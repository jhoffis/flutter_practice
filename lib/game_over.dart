
import 'package:flutter/material.dart';

class GameOver extends StatelessWidget {
  const GameOver({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Column(
      children: const [
        Text("You died."),

      ]),
    );
  }
}
