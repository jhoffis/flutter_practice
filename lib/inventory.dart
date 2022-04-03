import 'package:flutter/material.dart';
import 'package:untitled3/creature.dart';

import 'item.dart';

class Inventory extends StatefulWidget {
  final Creature creature;

  const Inventory(this.creature, {Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _InventoryState();
}

class _InventoryState extends State<Inventory> {
  Item? selectedItem;

  @override
  Widget build(BuildContext context) {
    var creature = super.widget.creature;
    var inventory = creature.inventory;

    return Scaffold(
      appBar: AppBar(
        title: Text(
            (creature == player ?
            'Your inventory  -  HP: ${player.hp}'
            :
            '${creature.name}\'s inventory')

        ),
      ),
      backgroundColor: Colors.blueGrey,
      body: Column(children: [
        Flexible(
            child: FractionallySizedBox(
                heightFactor: 0.2,
                widthFactor: 0.9,
                alignment: FractionalOffset.center,
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: selectedItem == null
                        ? const Text(
                            "Select an item to see its stats here.",
                            textAlign: TextAlign.left,
                            style: TextStyle(color: Color(0xFFE3E3E3))
                          )
                        : selectedItem!.showStats(creature, () {
                            setState(() {});
                          })))),
        SizedBox(
          height: 200,
          child: ListView.separated(
              itemBuilder: (BuildContext context, int index) {
                return OutlinedButton(
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
                    super.widget.creature.hand == inventory[index] ?
                    (selectedItem != inventory[index]
                        ? const Color(0xFF345034)
                        : const Color(0xFF7FA779))
                        :
                    (selectedItem != inventory[index]
                        ? const Color(0xFF26262D)
                        : const Color(0xFF5D5D6D)),
                    side: const BorderSide(width: 4.0, color: Colors.black26),
                    padding: const EdgeInsets.all(24),
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(),
              itemCount: inventory.length),
        ),
      ]),
    );
  }
}
