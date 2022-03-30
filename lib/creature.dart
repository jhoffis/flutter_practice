import 'dart:async';

import 'package:flutter/material.dart';

abstract class Item {
  String getName();

  Widget showStats();
}

class Weapon extends Item {
  int strength = 0,
      bonusStrength = 0,
      speed = 0;
  double chanceHit = 1;

  Weapon() {
    strength = 2;
  }

  @override
  String getName() {
    return "Weapon";
  }

  @override
  Widget showStats() {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text(
        "Strength: $strength\n"
            "Chance to hit: $chanceHit\n"
            "Speed: $speed",
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

class Creature {
  final List<Item> inventory;

  int currentFrame = 0;
  final List<Image> frames;

  Creature()
      : inventory = List.empty(growable: true),
        frames = List.empty(growable: true);

  Image getFrame(Function setState) {
    if (frames.isEmpty) {
      throw Exception("No frames init for creature");
    }
    Timer(const Duration(milliseconds: 750),()
    {
      setState(() {
        currentFrame = (currentFrame + 1) % frames.length;
      });
    });

    return frames[currentFrame];
  }
}

final player = Creature();

final testMonster = Creature();

void initCreatures() {
  player.inventory.add(Weapon());
  player.inventory.add(Weapon());

  testMonster.frames.add(const Image(
    image: AssetImage('assets/images/enemy_spider0.png'),
  ));
  testMonster.frames.add(const Image(
    image: AssetImage('assets/images/enemy_spider1.png'),
  ));
}
