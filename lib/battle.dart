import 'package:flutter/material.dart';
import 'package:untitled3/inventory.dart';
import 'package:image_sequence_animator/image_sequence_animator.dart';

import 'creature.dart';

class Battle extends StatefulWidget {
  const Battle({Key? key}) : super(key: key);

  @override
  State<Battle> createState() => _BattleState();
}

class _BattleState extends State<Battle> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              "Woah! A weird spider!",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                decoration: TextDecoration.none,
                shadows: [Shadow(color: Colors.black, offset: Offset(5, 5))],
              ),
            ),
            const ImageSequenceAnimator(
              "assets/images", //folderName
              "enemy_spider", //fileName
              0, //suffixStart
              1, //suffixCount
              "png", //fileFormat
              2, //frameCount
              fps: 1,
              isLooping: true,
            ),
            OutlinedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Inventory(player),
                    ));
              },
              child: const Text('Equip something!',
                  style: TextStyle(color: Color(0xFFDDC9B4), fontSize: 24)),
              style: ElevatedButton.styleFrom(
                primary: const Color(0xFFDB3B3F),
                side: const BorderSide(width: 4.0, color: Colors.black26),
                padding: const EdgeInsets.all(24),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
