import 'package:flutter/material.dart';

var skills = 0;

class DiedPage extends MaterialApp {
  DiedPage({Key? key})
      : super(
            key: key,
            home: Scaffold(
              body: Center(
                  child: Text(skills < 10
                      ? "You died,\n and now you're stuck in the underworld."
                      : "YOU WON!!!")),
            ));
}

class PracticePage extends MaterialApp {
  PracticePage({Key? key, required bool success, required BuildContext context})
      : super(
            key: key,
            home: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
                child: Scaffold(
              body: Center(
                  child: Text(success
                      ? "+1 You SMASHED your opponent"
                      : "You didn't smash... ;-;")),
              backgroundColor: success
                  ? const Color.fromRGBO(105, 234, 105, 1.0)
                  : const Color.fromRGBO(236, 55, 49, 1.0),
            ))) {
    skills++;
  }
}

class RouteMine extends Route {}
