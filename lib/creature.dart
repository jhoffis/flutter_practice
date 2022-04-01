import 'dart:async';

import 'package:flutter/material.dart';

import 'item.dart';

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
