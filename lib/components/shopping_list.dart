import 'package:flutter/material.dart';
import 'package:shopping_list/components/checkout_item.dart';
import 'package:shopping_list/components/shopping_list_item.dart';
import 'package:shopping_list/models/shopping_item.dart';

class ShoppingList extends StatelessWidget {
  const ShoppingList(
      {super.key,
      required this.items,
      required this.toggleComplete,
      required this.onCheckout});
  final List<ShoppingItem> items;
  final Function(ShoppingItem item) toggleComplete;
  final Function() onCheckout;

  @override
  Widget build(BuildContext context) {
    List<ShoppingItem> remainingItems =
        items.where((item) => !item.complete).toList();
    List<ShoppingItem> completedItems =
        items.where((item) => item.complete).toList();
    return ListView(children: [
      ...remainingItems.map((item) => ShoppingListItem(
            item: item,
            toggleComplete: toggleComplete,
          )),
      ...(completedItems.isNotEmpty
          ? [CheckoutItem(onCheckout: onCheckout)]
          : []),
      ...completedItems.map((item) => ShoppingListItem(
            item: item,
            toggleComplete: toggleComplete,
          )),
    ]);
  }
}
