import 'package:flutter/material.dart';
import 'package:shopping_list/components/add_new_item_modal.dart';
import 'package:shopping_list/models/shopping_item.dart';

class Footer extends StatelessWidget {
  const Footer(
      {super.key,
      required this.items,
      required this.addNewItem,
      required this.units,
      required this.itemNames});
  final List<ShoppingItem> items;
  final Function(ShoppingItem item) addNewItem;
  final Set<String> units;
  final Set<String> itemNames;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
            color: Colors.white,
            border: Border(top: BorderSide(color: Colors.blue, width: 3)),
            boxShadow: [
              BoxShadow(
                blurRadius: 1,
              )
            ]),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Row(children: [
            Expanded(
                child: Text(
              items.isEmpty
                  ? ""
                  : "${items.where((item) => !item.complete).length} items left",
              style: const TextStyle(fontSize: 24),
            )),
            InkWell(
                onTap: () => showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (context) => AddNewItemModal(
                        addNewItem: addNewItem,
                        units: units,
                        itemNames: itemNames)),
                child: Container(
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5)),
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 1, offset: Offset.fromDirection(1))
                        ]),
                    child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        child: Text("Add new",
                            style: TextStyle(
                                fontSize: 18,
                                color:
                                    Theme.of(context).colorScheme.onPrimary)))))
          ]),
        ));
  }
}
