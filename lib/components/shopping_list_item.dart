import 'package:flutter/material.dart';
import 'package:shopping_list/components/zero_height_icon_button.dart';
import 'package:shopping_list/models/shopping_item.dart';

class ShoppingListItem extends StatelessWidget {
  const ShoppingListItem(
      {super.key, required this.item, required this.toggleComplete});
  final ShoppingItem item;
  final Function(ShoppingItem item) toggleComplete;

  _toggleComplete() {
    toggleComplete(item);
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
            child: Padding(
                padding: const EdgeInsets.all(10),
                child: Wrap(
                    direction: Axis.horizontal,
                    alignment: WrapAlignment.spaceBetween,
                    children: [
                      FractionallySizedBox(
                        widthFactor: 0.85,
                        child: Text(
                            "${item.name}, ${item.quantity} ${item.unit}",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color:
                                    Theme.of(context).colorScheme.onPrimary)),
                      ),
                      const FractionallySizedBox(
                        widthFactor: 0.05,
                      ),
                      FractionallySizedBox(
                          widthFactor: 0.1,
                          child: ZeroHeightIconButton(
                              icon: Icon(item.complete
                                  ? Icons.cancel_outlined
                                  : Icons.check),
                              color: Theme.of(context).colorScheme.onPrimary,
                              onPressed: _toggleComplete)),
                    ]))));
  }
}
