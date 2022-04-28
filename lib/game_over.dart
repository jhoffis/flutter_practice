import 'package:flutter/material.dart';

import 'battle.dart';
import 'creature.dart';

class GameOver extends StatelessWidget {
  const GameOver({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Container(
        decoration: const BoxDecoration(color: Colors.white10),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BattleText("${player.name} died.\n"
                  "But nice, you got ${player.totalKills} kills!"),
              Image.asset('assets/images/died.png',
                  filterQuality: FilterQuality.none, fit: BoxFit.fill),
            ]),
      ),
    );
  }
}
