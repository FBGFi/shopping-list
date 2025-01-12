import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const ShoppingListPage(),
    );
  }
}

class ShoppingListPage extends StatefulWidget {
  const ShoppingListPage({super.key});

  @override
  State<ShoppingListPage> createState() => _ShoppingListPageState();
}

class _ShoppingListPageState extends State<ShoppingListPage> {
  List<ShoppingItem> _items = [];

  _addNewItem(ShoppingItem item) {
    setState(() {
      _items.add(item);
    });
  }

  _toggleComplete(ShoppingItem item) {
    setState(() {
      item.complete = !item.complete;
    });
  }

  _onCheckout() {
    setState(() {
      _items = _items.where((item) => !item.complete).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.blue, title: const Text("Shopping list")),
      body: Column(children: [
        _items.isEmpty
            ? const Expanded(
                child: Center(
                child: Text("No items added", style: TextStyle(fontSize: 20)),
              ))
            : Expanded(
                child: ShoppingList(
                items: _items,
                toggleComplete: _toggleComplete,
                onCheckout: _onCheckout,
              )),
        AddNewItemContainer(addNewItem: _addNewItem)
      ]),
      // floatingActionButton: FloatingActionButton(
      //     onPressed: _addItem, child: const Icon(Icons.add)),
    );
  }
}

const BASE_UNITS = ["kpl", "g", "kg", "l"];

class ShoppingItem {
  String name;
  late double quantity;
  late String unit;
  late bool complete;
  ShoppingItem(
      {required this.name,
      this.quantity = 1,
      this.unit = "kpl",
      this.complete = false});
}

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

class CheckoutItem extends StatefulWidget {
  const CheckoutItem({super.key, required this.onCheckout});

  final Function() onCheckout;

  @override
  State<CheckoutItem> createState() => _CheckoutItemState();
}

class _CheckoutItemState extends State<CheckoutItem> {
  bool _checkingOut = false;

  _toggleConfirmation() {
    setState(() {
      _checkingOut = !_checkingOut;
    });
  }

  _onCheckout() {
    setState(() {
      _checkingOut = false;
      widget.onCheckout();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding:
            const EdgeInsets.only(left: 15, top: 10, right: 15, bottom: 10),
        child: Wrap(
            direction: Axis.horizontal,
            alignment: WrapAlignment.spaceBetween,
            children: [
              Text(_checkingOut ? "Are you sure?" : "In cart",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  )),
              _checkingOut
                  ? Wrap(direction: Axis.horizontal, children: [
                      ZeroHeightIconButton(
                        onPressed: _onCheckout,
                        icon: const Icon(Icons.check),
                        color: Colors.green,
                      ),
                      Container(
                        width: 10,
                      ),
                      ZeroHeightIconButton(
                        onPressed: _toggleConfirmation,
                        icon: const Icon(Icons.cancel_outlined),
                        color: Colors.red,
                      ),
                    ])
                  : ZeroHeightIconButton(
                      onPressed: _toggleConfirmation,
                      icon: const Icon(Icons.check),
                      color: Colors.green,
                    )
            ]));
  }
}

class ZeroHeightIconButton extends StatelessWidget {
  const ZeroHeightIconButton(
      {super.key,
      required this.icon,
      required this.color,
      required this.onPressed});
  final Widget icon;
  final Color color;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      color: color,
      icon: icon,
      padding: EdgeInsets.zero,
      constraints: const BoxConstraints(),
      style: const ButtonStyle(tapTargetSize: MaterialTapTargetSize.shrinkWrap),
    );
  }
}

class AddNewItemContainer extends StatefulWidget {
  const AddNewItemContainer({super.key, required this.addNewItem});

  final Function(ShoppingItem item) addNewItem;

  @override
  State<AddNewItemContainer> createState() => _AddNewItemContainerState();
}

class _AddNewItemContainerState extends State<AddNewItemContainer> {
  late String? name;
  late double? quantity;
  late String? unit;

  _addNewItem() {
    setState(() {
      if (name != null && quantity != null && unit != null) {
        widget.addNewItem(
            ShoppingItem(name: name!, quantity: quantity!, unit: unit!));
        name = null;
        quantity = null;
        unit = null;
      }
    });
  }

  _onChangeItemName(String name) {
    setState(() {
      this.name = name;
    });
  }

  _onChangeItemQuantity(String quantity) {
    setState(() {
      this.quantity = double.parse(quantity);
    });
  }

  _onChangeItemUnit(String? unit) {
    if (unit == null) return;
    setState(() {
      this.unit = unit;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
            border: Border(top: BorderSide(color: Colors.blue, width: 5))),
        child: Padding(
            padding:
                const EdgeInsets.only(left: 15, top: 10, right: 15, bottom: 10),
            child: Row(children: [
              Expanded(
                  child: Column(children: [
                TextField(
                  onChanged: _onChangeItemName,
                  decoration: const InputDecoration(labelText: "Name"),
                ),
                Container(
                  height: 10,
                ),
                Row(
                  children: [
                    Expanded(
                        child: TextField(
                      keyboardType: TextInputType.number,
                      onChanged: _onChangeItemQuantity,
                      decoration: const InputDecoration(labelText: "Quantity"),
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    )),
                    Container(width: 10),
                    DropdownMenu(
                        label: const Text("Unit"),
                        onSelected: _onChangeItemUnit,
                        dropdownMenuEntries: BASE_UNITS
                            .map((unit) =>
                                DropdownMenuEntry(value: unit, label: unit))
                            .toList()),
                  ],
                )
              ])),
              Container(width: 10),
              Center(
                  child: IconButton(
                      onPressed: _addNewItem, icon: const Icon(Icons.add)))
            ])));
  }
}
