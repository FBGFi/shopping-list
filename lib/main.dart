import 'package:flutter/material.dart';

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
  final List<String> _items = [];
  _addItem() {
    setState(() {
      _items.add(
          "new itemnew itemnew itemnew itemnew itemnew itemnew itemnew itemnew itemnew itemnew itemnew itemnew itemnew itemnew itemnew itemnew itemnew item");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.blue, title: const Text("Shopping list")),
      body: GroceriesList(items: _items),
      floatingActionButton: FloatingActionButton(
          onPressed: _addItem, child: const Icon(Icons.add)),
    );
  }
}

class GroceriesList extends StatelessWidget {
  const GroceriesList({super.key, required this.items});
  final List<String> items;

  @override
  Widget build(BuildContext context) {
    return ListView(
        children: items
            .map((item) => Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                            color: Theme.of(context).colorScheme.primary,
                            width: 3),
                        color: Theme.of(context)
                            .colorScheme
                            .primary
                            .withAlpha(200)),
                    child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Wrap(
                            direction: Axis.horizontal,
                            alignment: WrapAlignment.spaceBetween,
                            children: [
                              FractionallySizedBox(
                                widthFactor: 0.85,
                                child: Text(item,
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onPrimary)),
                              ),
                              const FractionallySizedBox(
                                widthFactor: 0.05,
                              ),
                              FractionallySizedBox(
                                widthFactor: 0.1,
                                child: IconButton(
                                  onPressed: () {},
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                  icon: const Icon(Icons.check),
                                  padding: EdgeInsets.zero,
                                  constraints: const BoxConstraints(),
                                  style: const ButtonStyle(
                                      tapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap),
                                ),
                              ),
                            ])))))
            .toList());
  }
}
