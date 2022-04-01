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
    var inventory = super.widget.creature.inventory;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your inventory'),

      ),
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
                          )
                        : selectedItem!.showStats()))),
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
                    primary: selectedItem != inventory[index]
                        ? const Color(0xFF26262D)
                        : const Color(0xFF5D5D6D),
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
