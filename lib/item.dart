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
              // minimumSize: const Size.fromHeight(40),
            ));
}

Expanded showStats(Item? item, Creature creature, final Function setState,
    final Color textColor) {
  Widget content;
  void Function()? onPressed;

  if (item == null) {
    content = Text("Select an item to see its stats here.",
        textAlign: TextAlign.left, style: TextStyle(color: textColor));
  } else {
    var description = Text(
        "\t\"${item.getName()}\"\n"
        "${item.getDescription()}",
        textAlign: TextAlign.left,
        style: TextStyle(color: textColor, fontSize: 16));

    String text;
    if (creature != player) {
      onPressed = () {
        // Loot
        if (player.inventory.length < player.carryCapacity) {
          player.inventory.add(item);
          creature.inventory.remove(item);
          setState(true);
        }
      };
      text = "Loot";
    } else {
      onPressed = () {
        // Equip or not
        if (creature.hand != item) {
          creature.hand = item;
        } else {
          creature.hand = Nothing();
        }
        setState(false);
      };
      text = creature.hand == item ? "Unequip" : "Equip";
    }

    content = Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      description,
      ItemButton(onPressed: onPressed, text: text),
    ]);
  }

  const borderRadius = BorderRadius.all(Radius.circular(20));

  return Expanded(
      flex: 2,
      child: FractionallySizedBox(
          heightFactor: .9,
          widthFactor: .9,
          child: Align(
              alignment: Alignment.centerLeft,
              child: DecoratedBox(
                  decoration: const BoxDecoration(
                    borderRadius: borderRadius,
                    color: Colors.black12,
                  ),
                  child: InkWell(
                      borderRadius: borderRadius,
                      onTap: onPressed,
                      // TODO denne burde ha akkurat samme som onPressed, bare at InkWell skal ikke være med om det er ingen item...
                      child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: content))))));
}

abstract class Item {
  String name = "";

  String getName();

  String getDescription();

  int attack();
}

enum Elemental {
  none,
  flame,
}

class Weapon extends Item {
  int strength = 0, bonusStrength = 0, speed = 0, depth = 0;
  int hp = 0;
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
        chanceHit = .9;
        speed = 5;
        break;
      case 1:
        name = "Hammer";
        strength = 3;
        bonusStrength = 6;
        speed = 3;
        chanceHit = .75;
        break;
      case 2:
        name = "Axe";
        strength = 5;
        bonusStrength = 3;
        speed = 3;
        chanceHit = .85;
        break;
    }

    var adj = ran.nextDouble() + dropAdjuster;
    if (adj > .99) {
      adjective = "Godlike";
      strength += 5;
      bonusStrength += 5;
      speed += 1;
      hp = 100;
    } else if (adj > .97) {
      adjective = "Masterwork";
      strength += 2;
      bonusStrength += 2;
      speed += 1;
      hp = 75;
    } else if (adj > .90) {
      adjective = "Unbalanced";
      strength -= 1;
      bonusStrength += 2;
      chanceHit *= .8;
      hp = 20;
    } else if (adj > .85) {
      adjective = "Imba";
      strength -= 3;
      bonusStrength += 5;
      chanceHit *= .2;
      speed = 5;
      hp = 20;
    } else if (adj > .75) {
      adjective = "Fancy";
      strength += 1;
      hp = 30;
    } else if (adj > .4) {
      adjective = "Normal";
      hp = 20;
    } else if (adj > .15) {
      adjective = "Boring";
      strength -= 1;
      hp = 15;
    } else if (adj <= .15) {
      adjective = "Grumpy";
      strength -= 2;
      speed -= 1;
      hp = 10;
    }

    if (ran.nextDouble() > .90) {
      elemental = Elemental.flame;
      adjective = "Flamey " + adjective;
    }
  }

  int getHp() {
    return hp;
  }

  @override
  String getName() {
    return adjective + " " + name;
  }

  @override
  String getDescription() {
    return """
Strength: $strength+$bonusStrength+$depth
Chance to hit: ${(chanceHit * 100).toInt()}%
Speed: $speed
Recovers $hp ❤ when discarded""";
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
    hp -= 2;
    if (hp < 0) {
      hp = 0;
    }
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
