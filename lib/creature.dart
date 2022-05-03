import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

import 'item.dart';

class Creature {
  Item hand = Nothing();
  final List<Item> inventory;

  int currentFrame = 0;

  final int hpOg;
  int hp;
  int kills = 0;
  int totalKills = 0;
  int carryCapacity = 7;

  final String name;

  Creature(this.name, this.hp)
      : inventory = List.empty(growable: true),
        hpOg = hp;

  int attack(Creature enemy) {
    int damage = hand.attack();
    enemy.hp -= damage;
    return damage;
  }
}

final player = Creature("Jack", 100);
int depth = 0;

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
  var enemy = Creature(names[ran.nextInt(names.length - 1)],
      20 + (10.0 * ran.nextDouble()).round() + 10 * depth);

  for (var i = 0; i < ran.nextInt(3) + 1; i++) {
    enemy.inventory.add(
        Weapon(dropAdjuster: depth * .05 - .3, depth: depth)); // +5x% - 30%
  }

  for (var item in enemy.inventory) {
    if (item is Weapon) {
      enemy.hand = item;
      break;
    }
  }

  return enemy;
}

void initPlayer() {
  player.inventory.add(Weapon(dropAdjuster: -0.5));
}
