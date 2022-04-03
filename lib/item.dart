import 'dart:math';

import 'package:flutter/material.dart';

import 'creature.dart';

abstract class Item {
  String name = "";

  String getName();

  String getDescription();

  Widget showStats(Creature creature, Function setState) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text(
          "${getName()}\n"
          "${getDescription()}\n",
          textAlign: TextAlign.left,
          style: const TextStyle(color: Color(0xFFE3E3E3))),
      OutlinedButton(
        onPressed: () {
          if (creature.hand != this) {
            creature.hand = this;
          } else {
            creature.hand = Nothing();
          }
          setState();
        },
        child: Text(creature.hand == this ? "Unequip" : "Equip",
            style: const TextStyle(color: Color(0xFF292929), fontSize: 16)),
        style: ElevatedButton.styleFrom(
          primary: const Color(0xFF34eb77),
          padding: const EdgeInsets.all(8),
        ),
      ),
    ]);
  }
}

class Weapon extends Item {
  int strength = 0, bonusStrength = 0, speed = 0;
  double chanceHit = 1;
  String adjective = "";

  Weapon() {
    var ran = Random();
    var weaponType = ran.nextInt(3);
    switch (weaponType) {
      case 0:
        name = "Sword";
        strength = 3;
        bonusStrength = 1;
        speed = 5;
        break;
      case 1:
        name = "Hammer";
        strength = 3;
        bonusStrength = 4;
        speed = 2;
        chanceHit = .5;
        break;
      case 2:
        name = "Axe";
        strength = 5;
        bonusStrength = 2;
        speed = 2;
        break;
    }

    var adj = ran.nextInt(5);
    switch (adj) {
      case 0:
        adjective = "Boring";
        strength -= 1;
        break;
      case 1:
        adjective = "Normal";
        break;
      case 2:
        adjective = "Fancy";
        strength += 1;
        break;
      case 3:
        adjective = "Unbalanced";
        strength -= 1;
        bonusStrength += 2;
        chanceHit *= .8;
        break;
      case 4:
        adjective = "Masterwork";
        strength += 2;
        bonusStrength += 2;
        speed += 1;
        break;
    }
  }

  @override
  String getName() {
    return adjective + " " + name;
  }

  @override
  String getDescription() {
    return "Strength: $strength+$bonusStrength\n"
        "Chance to hit: $chanceHit\n"
        "Speed: $speed";
  }
}

class Nothing extends Item {
  @override
  String getDescription() {
    throw UnimplementedError();
  }

  @override
  String getName() {
    throw UnimplementedError();
  }
}
