import 'dart:math';

import 'package:flutter/material.dart';

import 'creature.dart';

class ItemButton extends OutlinedButton {
  ItemButton({Key? key, required VoidCallback? onPressed, required String text})
      : super(
            key: key,
            onPressed: onPressed,
            child: Text(text,
                style: const TextStyle(color: Color(0xFF292929), fontSize: 16)),
            style: ElevatedButton.styleFrom(
              primary: const Color(0xFF34eb77),
              padding: const EdgeInsets.all(8),
            ));
}

abstract class Item {
  String name = "";

  String getName();

  String getDescription();

  int attack();

  Widget showStats(Creature creature, Function setState) {
    var description = Text(
        "${getName()}\n"
        "${getDescription()}\n",
        textAlign: TextAlign.left,
        style: const TextStyle(color: Color(0xFFE3E3E3)));

    List<Widget> row;
    if (creature != player) {
      row = [
        description,
        ItemButton(
            onPressed: () {
              // Loot
              if (player.inventory.length < 6) {
                player.inventory.add(this);
                creature.inventory.remove(this);
              }
              setState();
            },
            text: "Loot"),
      ];
    } else {
      row = [
        description,
        ItemButton(
            onPressed: () {
              // Equip or not
              if (creature.hand != this) {
                creature.hand = this;
              } else {
                creature.hand = Nothing();
              }
              setState();
            },
            text: creature.hand == this ? "Unequip" : "Equip"),
      ];
    }

    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween, children: row);
  }
}

enum Elemental {
  none,
  flame,
}

class Weapon extends Item {
  int strength = 0, bonusStrength = 0, speed = 0, depth = 0;
  int hp = 100;
  double chanceHit = 1;
  String adjective = "";
  Elemental elemental = Elemental.none;

  Weapon({double dropAdjuster = 0, this.depth = 0}) {
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

    var adj = ran.nextDouble() + dropAdjuster;
    if (adj > .99) {
      adjective = "Godlike";
      strength += 5;
      bonusStrength += 5;
      speed += 1;
    } else if (adj > .97) {
      adjective = "Masterwork";
      strength += 2;
      bonusStrength += 2;
      speed += 1;
    } else if (adj > .90) {
      adjective = "Unbalanced";
      strength -= 1;
      bonusStrength += 2;
      chanceHit *= .8;
    } else if (adj > .85) {
      adjective = "Imba";
      strength -= 3;
      bonusStrength += 5;
      chanceHit *= .2;
      speed = 5;
    } else if (adj > .75) {
      adjective = "Fancy";
      strength += 1;
    } else if (adj > .4) {
      adjective = "Normal";
    } else if (adj > .15) {
      adjective = "Boring";
      strength -= 1;
    } else if (adj <= .15) {
      adjective = "Grumpy";
      strength -= 2;
      speed -= 1;
    }

    if (ran.nextDouble() > .90) {
      elemental = Elemental.flame;
      adjective = "Flamey " + adjective;
    }
  }

  @override
  String getName() {
    return adjective + " " + name;
  }

  @override
  String getDescription() {
    return "Strength: $strength+$bonusStrength+$depth\n"
        "Chance to hit: $chanceHit\n"
        "Speed: $speed";
  }

  @override
  int attack() {
    int damage = 0;
    var ran = Random();
    if (ran.nextDouble() < chanceHit) {
      damage += strength + depth;
      if (ran.nextDouble() < 0.2) {
        damage += bonusStrength;
      }
      damage *= speed;
      if (elemental == Elemental.flame) {
        damage *= ran.nextDouble().round() + 1;
      }
    }
    hp -= 10;
    return damage;
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

  @override
  int attack() {
    return 2;
  }
}
