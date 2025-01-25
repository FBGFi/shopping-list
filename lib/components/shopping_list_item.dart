import 'package:flutter/material.dart';
import 'package:shopping_list/models/shopping_item.dart';

class ShoppingListItem extends StatelessWidget {
  const ShoppingListItem(
      {super.key, required this.item, required this.toggleComplete});
  final ShoppingItem item;
  final Function(ShoppingItem item) toggleComplete;

  _toggleComplete() {
    toggleComplete(item);
  }

  String _removeDecimalZeroFormat(double n) {
    return n.toStringAsFixed(n.truncateToDouble() == n ? 0 : 1);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(10),
        child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(
                    color: item.complete
                        ? Colors.green
                        : Theme.of(context).colorScheme.primary,
                    width: 3),
                color: Theme.of(context).colorScheme.primary.withAlpha(200)),
            child: InkWell(
                onTap: _toggleComplete,
                child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Flex(direction: Axis.horizontal, children: [
                      Expanded(
                        child: Text(item.name,
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color:
                                    Theme.of(context).colorScheme.onPrimary)),
                      ),
                      Container(width: 10),
                      Text(
                          "${_removeDecimalZeroFormat(item.quantity)} ${item.unit}",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.onPrimary)),
                    ])))));
  }
}
