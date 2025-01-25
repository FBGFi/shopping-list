import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shopping_list/components/add_new_item_container.dart';
import 'package:shopping_list/components/add_new_item_modal.dart';
import 'package:shopping_list/components/footer.dart';
import 'package:shopping_list/components/shopping_list.dart';
import 'package:shopping_list/models/shopping_item.dart';
import 'package:shopping_list/utils/constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final documentsDir = await getApplicationDocumentsDirectory();
  Hive.init(documentsDir.path);
  Hive.registerAdapter<ShoppingItem>(ShoppingItemAdapter());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shopping List',
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
  Box<List<dynamic>>? _shoppingListBox;
  final List<ShoppingItem> _items = [];
  final Set<String> _units = BASE_UNITS.toSet();
  final Set<String> _itemNames = {};

  _addNewItem(ShoppingItem item) {
    setState(() {
      _items.add(item);
      _units.add(item.unit);
      _itemNames.add(item.name);
      _shoppingListBox?.put("items", _items);
      _shoppingListBox?.put("units", _units.toList());
      _shoppingListBox?.put("itemNames", _itemNames.toList());
      Navigator.pop(context);
    });
  }

  _toggleComplete(ShoppingItem item) {
    setState(() {
      item.complete = !item.complete;
      _shoppingListBox?.put("items", _items);
    });
  }

  _onCheckout() {
    setState(() {
      _items.removeWhere((item) => item.complete);
      _shoppingListBox?.put("items", _items);
    });
  }

  @override
  void initState() {
    super.initState();
    if (!Hive.isBoxOpen("shopping_list")) {
      Hive.openBox<List<dynamic>>("shopping_list").then((box) {
        setState(() {
          _shoppingListBox = box;
          _items.addAll(box.get("items")?.cast<ShoppingItem>() ?? []);
          _units.addAll(box.get("units")?.cast<String>() ?? []);
          _itemNames.addAll(box.get("itemNames")?.cast<String>() ?? []);
        });
      });
    } else {
      setState(() {
        final box = Hive.box<List<dynamic>>("shopping_list");
        _shoppingListBox = box;
        _items.addAll(box.get("items")?.cast<ShoppingItem>() ?? []);
        _units.addAll(box.get("units")?.cast<String>() ?? []);
        _itemNames.addAll(box.get("itemNames")?.cast<String>() ?? []);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Text("Shopping List",
              style:
                  TextStyle(color: Theme.of(context).colorScheme.onPrimary))),
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
        Footer(
            items: _items,
            addNewItem: _addNewItem,
            units: _units,
            itemNames: _itemNames)
      ]),
    );
  }
}
