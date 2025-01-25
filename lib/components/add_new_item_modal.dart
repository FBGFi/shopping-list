import 'package:flutter/material.dart';
import 'package:shopping_list/components/add_new_item_container.dart';
import 'package:shopping_list/models/shopping_item.dart';

class AddNewItemModal extends StatelessWidget {
  const AddNewItemModal(
      {super.key,
      required this.addNewItem,
      required this.units,
      required this.itemNames});

  final Function(ShoppingItem item) addNewItem;
  final Set<String> units;
  final Set<String> itemNames;

  @override
  Widget build(context) {
    return GestureDetector(
        onTap: () {
          WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
        },
        child: Scaffold(
            extendBody: true,
            appBar: AppBar(
                backgroundColor: Colors.blue,
                toolbarHeight: 80.0,
                leading: Align(
                    alignment: Alignment.bottomLeft,
                    child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.arrow_back))),
                title: SizedBox(
                    height: 60.0,
                    child: Align(
                        alignment: Alignment.bottomLeft,
                        child: Text(
                          "Add new item",
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.onPrimary),
                        )))),
            body: AddNewItemContainer(
              addNewItem: addNewItem,
              units: units.toList(),
              itemNames: itemNames.toList(),
            )));
  }
}
