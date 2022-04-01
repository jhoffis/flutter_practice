import 'dart:math';

import 'package:flutter/material.dart';

class Effect {}
class Adjective{}


abstract class Item {
  int strength = 0,
      bonusStrength = 0,
      speed = 0;
  double chanceHit = 1;
  String name = "";

  String getName();
  String getDescription();
  Effect getSpecialEffect();
  List<Adjective> getAdjectives();

  Widget showStats() {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text(
        "$getName()\n"
            "Strength: $strength\n"
            "Chance to hit: $chanceHit\n"
            "Speed: $speed\n"
            "$getDescription()",
        textAlign: TextAlign.left,
      ),
      OutlinedButton(
        onPressed: () {},
        child: const Text('Equip',
            style: TextStyle(color: Color(0xFF292929), fontSize: 16)),
        style: ElevatedButton.styleFrom(
          primary: const Color(0xFF34eb77),
          padding: const EdgeInsets.all(8),
        ),
      ),
    ]);
  }
}

class Weapon extends Item {

  Weapon() {
    strength = 2;

    var ran = Random();
    var types = List<String>{
      "Sword",
    };
    var weaponType = ran.nextInt(types.length - 1);

    name = types[weaponType];
  }

  @override
  String getName() {
    return name;
  }


}