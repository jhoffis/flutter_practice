import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

import 'item.dart';

class Creature {
  Item hand = Nothing();
  final List<Item> inventory;

  int currentFrame = 0;
  final List<Image> frames;

  final int hpOg;
  int hp;

  final String name;

  Creature(this.name, this.hp)
      : inventory = List.empty(growable: true),
        frames = List.empty(growable: true),
        hpOg = hp;

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

  int attack(Creature enemy) {
    int damage = hand.attack();
    enemy.hp -= damage;
    return damage;
  }
}



final player = Creature("Jack", 100);

Creature createEnemy() {
  var names = [
    'Lowri',
    'Molly',
    'Ria',
    'Irene (Rina)',
    'Hazel',
    'Yasmin',
    'Maxwell',
    'Conner',
    'Jeremiah',
    'Erik',
    'Harley',
    'Omar',
    'Farhan',
    'Robin',
    'Gard',
    'Thomas',
    'Sunniva',
    'Min Dång',
    'Anas Bananas',
    'Petter',
  ];
  var ran = Random();
  var enemy = Creature(names[ran.nextInt(names.length - 1)], 100);

  for (var i = 0; i < ran.nextInt(3) + 1; i++) {
    enemy.inventory.add(Weapon());
  }

  for (var item in enemy.inventory) {
    if (item is Weapon) {
      enemy.hand = item;
      break;
    }
  }

  return enemy;
}

void initCreatures() {
  player.inventory.add(Weapon());
  player.inventory.add(Weapon());
}
