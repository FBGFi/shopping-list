import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shopping_list/components/add_new_item_container.dart';
import 'package:shopping_list/components/shopping_list.dart';
import 'package:shopping_list/models/shopping_item.dart';

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
      Navigator.pop(context);
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
      ]),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              builder: (context) => GestureDetector(
                  onTap: () {
                    WidgetsBinding.instance.focusManager.primaryFocus
                        ?.unfocus();
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
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onPrimary),
                                  )))),
                      body: AddNewItemContainer(
                        addNewItem: _addNewItem,
                      ))));
        },
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        child: const Icon(Icons.add),
      ),
    );
  }
}
