import 'package:flutter/material.dart';
import 'package:untitled3/creature.dart';
import 'package:untitled3/walking.dart';

import 'item.dart';

class Inventory extends StatefulWidget {
  final Creature creature;
  final bool killedEnemy;
  final void Function(VoidCallback fn) setBattleState;

  const Inventory(this.creature, this.setBattleState,
      {Key? key, required this.killedEnemy})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _InventoryState();
}

class _InventoryState extends State<Inventory> {
  Item? selectedItem;

  @override
  Widget build(BuildContext context) {
    const textColor = Color(0xFFDDC9B4);
    var creature = super.widget.creature;
    var inventory = creature.inventory;

    String title;
    Color bc;

    if (creature == player) {
      title =
          'Your inventory has ${inventory.length}/${creature.carryCapacity} items';
      bc = const Color.fromARGB(255, 44, 66, 81);
    } else {
      title = '${creature.name}\'s inventory';
      bc = const Color.fromARGB(255, 140, 40, 50);
    }

    return WillPopScope(
      onWillPop: () {
        if (widget.killedEnemy) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => const Walking(),
            ),
          );
          return Future.value(false);
        }
        widget.setBattleState(() {});
        return Future.value(true); // Fortsett å poppe
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            title,
            style: const TextStyle(color: textColor),
          ),
          backgroundColor: bc,
        ),
        backgroundColor: bc,
        body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              showStats(selectedItem, creature, (removeSelected) {
                setState(() {
                  if (removeSelected) {
                    selectedItem = null;
                  }
                });
              }, textColor),
              Expanded(
                flex: 6,
                child: Align(
                  alignment: Alignment.center,
                  child: FractionallySizedBox(
                    // heightFactor: 1,
                    widthFactor: .9,
                    child: ListView.separated(
                        // shrinkWrap: true,
                        // padding: const EdgeInsets.all(20.0),
                        itemBuilder: (BuildContext context, int index) {
                          var btn = OutlinedButton(
                            onPressed: () {
                              setState(() {
                                selectedItem = inventory[index];
                              });
                            },
                            child: Text(inventory[index].getName(),
                                style: const TextStyle(
                                    color: textColor, fontSize: 24)),
                            style: ElevatedButton.styleFrom(
                              primary:
                                  super.widget.creature.hand == inventory[index]
                                      ? (selectedItem != inventory[index]
                                          ? const Color(0xFF345034)
                                          : const Color(0xFF7FA779))
                                      : (selectedItem != inventory[index]
                                          ? const Color(0xFF26262D)
                                          : const Color(0xFF5D5D6D)),
                              side: const BorderSide(
                                  width: 4.0, color: Colors.black26),
                              padding: const EdgeInsets.all(24),
                            ),
                          );

                          if (creature == player && inventory.length > 1) {
                            // Make item dismissible
                            return Dismissible(
                                // Each Dismissible must contain a Key. Keys allow Flutter to
                                // uniquely identify widgets.
                                key: UniqueKey(),
                                confirmDismiss: (direction) {
                                  return Future.value(true);
                                },
                                onDismissed: (direction) {
                                  setState(() {
                                    if (player.hand == inventory[index]) {
                                      if (index != 0) {
                                        player.hand = inventory.first;
                                      } else {
                                        player.hand = inventory.last;
                                      }
                                    }
                                  });
                                  if (inventory[index] is Weapon) {
                                    player.hp +=
                                        (inventory[index] as Weapon).getHp();
                                  }
                                  inventory.removeAt(index);
                                },
                                // background: Container(color: Colors.red),
                                child: btn);
                          }
                          return btn;
                        },
                        separatorBuilder: (BuildContext context, int index) =>
                            const Divider(),
                        itemCount: inventory.length),
                  ),
                ),
              ),
            ]),
      ),
    );
  }
}
