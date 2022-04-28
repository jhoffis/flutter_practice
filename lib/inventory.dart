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
    var creature = super.widget.creature;
    var inventory = creature.inventory;

    String title;
    Color bc;

    if (creature == player) {
      title = 'Your inventory  -  HP: ${player.hp}';
      bc = Colors.blueGrey;
    } else {
      title = '${creature.name}\'s inventory';
      bc = Colors.deepOrange;
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
          title: Text(title),
        ),
        backgroundColor: bc,
        body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 1,
                child: FractionallySizedBox(
                    // heightFactor: 1,
                    widthFactor: .9,
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: DecoratedBox(
                            decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              color: Colors.black12,
                            ),
                            child: selectedItem == null
                                ? const Text(
                                    "Select an item to see its stats here.",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(color: Color(0xFFE3E3E3)))
                                : selectedItem!.showStats(creature, () {
                                    setState(() {});
                                  })))),
              ),
              Expanded(
                flex: 4,
                child: ListView.separated(
                    // shrinkWrap: true,
                    // padding: const EdgeInsets.all(20.0),
                    itemBuilder: (BuildContext context, int index) {
                      return Dismissible(
                        // Each Dismissible must contain a Key. Keys allow Flutter to
                        // uniquely identify widgets.
                        key: Key("$index"),
                        onDismissed: (direction) {
                          setState(() {
                            bool isInHand = inventory[index] == player.hand;
                            if (isInHand && inventory.length > 1) {
                              if (index != 0) {
                                player.hand = inventory.first;
                              } else {
                                player.hand = inventory.last;
                              }
                              inventory.removeAt(index);
                            }
                          });
                        },
                        background: Container(color: Colors.red),
                        child: OutlinedButton(
                          onPressed: () {
                            setState(() {
                              selectedItem = inventory[index];
                            });
                          },
                          child: Text(inventory[index].getName(),
                              style: const TextStyle(
                                  color: Color(0xFFDDC9B4), fontSize: 24)),
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
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) =>
                        const Divider(),
                    itemCount: inventory.length),
              ),
            ]),
      ),
    );
  }
}
