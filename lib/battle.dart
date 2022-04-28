import 'dart:async';
import 'dart:developer';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:untitled3/inventory.dart';
import 'package:image_sequence_animator/image_sequence_animator.dart';

import 'creature.dart';
import 'game_over.dart';
import 'item.dart';

class BattleText extends Text {
  const BattleText(String data)
      : super(data,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              decoration: TextDecoration.none,
              shadows: [Shadow(color: Colors.black, offset: Offset(5, 5))],
            ));
}

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
  int damage = 0;
  bool canAttack = true;
  int timeWhenAvailableToStrike = 0;

  @override
  Widget build(BuildContext context) {
    amountSeen++;
    var enemy = super.widget.enemy;
    var ran = Random();

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

    var inventoryBtn = BattleButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Inventory(player, setState, killedEnemy: false),
              ));
          setState(() {});
        },
        text: 'Inventory');

    return Container(
      color: Color.fromARGB(255, 20, (200 / (depth+1)).round(), 42),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            BattleText(player.hand is! Nothing
                ? "Depth:$depth\n"
                    "Enemy's HP: ${enemy.hp}/${enemy.hpOg} -$damage"
                : (amountSeen <= 1
                    ? "Woah! A weird spider!"
                    : "Darn spiders...")),
            enemyAnimation,
            player.hand is Nothing
                ? inventoryBtn
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                        inventoryBtn,
                        BattleButton(
                            enabled: canAttack,
                            onPressed: () {
                              setState(() {
                                /*
                                Attack
                                 */
                                damage = player.attack(enemy);
                                if (enemy.hp <= 0) {
                                  /*
                                  Killed enemy
                                   */
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            Inventory(enemy, setState, killedEnemy: true),
                                      ));
                                  /*
                                  Reset after fight
                                   */
                                  super.widget.enemy = createEnemy();
                                  player.hp = 100;
                                  if (ran.nextDouble() + player.kills * .05 > .75) {
                                    depth++;
                                    player.kills = 0;
                                  } else {
                                    player.kills += 1;
                                    player.totalKills += 1;
                                  }
                                } else {
                                  /*
                                  Wait until next attack
                                   */
                                  canAttack = false;
                                  var waitTime = ran.nextInt(400) + 600;
                                  timeWhenAvailableToStrike =
                                      DateTime.now().millisecond + waitTime;
                                  Timer(Duration(milliseconds: waitTime), () {
                                    setState(() {
                                      canAttack = true;
                                      enemy.attack(player);
                                      if (player.hp <= 0) {
                                        /*
                                        Died
                                         */
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  const GameOver(),
                                            ));
                                      }
                                    });
                                  });
                                }
                              });
                            },
                            text: 'Attack!')
                      ]),
            BattleText("My HP: ${player.hp}/${player.hpOg}"),
            // BattleButton(onPressed: () {
            //   Navigator.pushReplacement(
            //       context,
            //       MaterialPageRoute(
            //         builder: (context) =>
            //         const GameOver(),
            //       ));
            // }, text: "Kill yourself")
          ],
        ),
      ),
    );
  }
}
