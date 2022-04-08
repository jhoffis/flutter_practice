import 'dart:async';

import 'package:flutter/material.dart';
import 'package:untitled3/inventory.dart';
import 'package:image_sequence_animator/image_sequence_animator.dart';

import 'creature.dart';
import 'game_over.dart';
import 'item.dart';

class Battle extends StatefulWidget {
  Creature enemy = createEnemy();

  Battle({Key? key}) : super(key: key);

  @override
  State<Battle> createState() => _BattleState();
}

class BattleButton extends OutlinedButton {
  BattleButton(
      {Key? key,
      required VoidCallback? onPressed,
      required String text,
      bool enabled = true})
      : super(
            key: key,
            onPressed: enabled ? onPressed : () {},
            child: Text(text,
                style: const TextStyle(color: Color(0xFFDDC9B4), fontSize: 24)),
            style: ElevatedButton.styleFrom(
              primary:
                  enabled ? const Color(0xFFDB3B3F) : const Color(0xFF474747),
              side: const BorderSide(width: 4.0, color: Colors.black26),
              padding: const EdgeInsets.all(24),
            ));
}

class _BattleState extends State<Battle> {
  int amountSeen = 0;
  int damage = -1;
  bool canAttack = true;

  @override
  Widget build(BuildContext context) {
    amountSeen++;
    var enemy = super.widget.enemy;

    var enemyAnimation = const ImageSequenceAnimator(
      "assets/images", //folderName
      "enemy_spider", //fileName
      0, //suffixStart
      1, //suffixCount
      "png", //fileFormat
      2, //frameCount
      fps: 1,
      isLooping: true,
    );

    if (amountSeen <= 1) {
      return Container(
        color: Colors.green,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                damage >= 0
                    ? "-$damage  -  ${enemy.hp}/${enemy.hpOg}"
                    : (amountSeen <= 1
                        ? "Woah! A weird spider!"
                        : "Darn spiders..."),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  decoration: TextDecoration.none,
                  shadows: [Shadow(color: Colors.black, offset: Offset(5, 5))],
                ),
              ),
              enemyAnimation,
              BattleButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Inventory(player, killedEnemy: false),
                        ));
                    setState(() {});
                  },
                  text: 'Equip something!')
            ],
          ),
        ),
      );
    }

    return Container(
      color: Colors.green,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              damage >= 0
                  ? "-$damage  -  ${enemy.hp}/${enemy.hpOg}"
                  : "Darn spiders...",
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
                decoration: TextDecoration.none,
                shadows: [Shadow(color: Colors.black, offset: Offset(5, 5))],
              ),
            ),
            enemyAnimation,
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
              BattleButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Inventory(player, killedEnemy: false),
                        ));
                    setState(() {});
                  },
                  text: 'Inventory'),
              BattleButton(
                  enabled: canAttack,
                  onPressed: () {
                    setState(() {
                      damage = player.attack(enemy);
                      if (enemy.hp <= 0) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Inventory(enemy, killedEnemy: true),
                            ));
                        super.widget.enemy = createEnemy();
                        player.hp = 100;
                      } else {
                        canAttack = false;
                        Timer(const Duration(milliseconds: 800), () {
                          setState(() {
                            canAttack = true;
                            enemy.attack(player);
                            if (player.hp <= 0) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const GameOver(),
                                  ));
                            }
                          });
                        });
                      }
                    });
                  },
                  text: 'Attack!')
            ]),
            Text("HP: ${player.hp}/${player.hpOg}"),
            Text(
              "test",
              style: TextStyle(fontSize: 28, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
