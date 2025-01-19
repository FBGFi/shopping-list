import 'package:hive/hive.dart';

part 'shopping_item.g.dart';

@HiveType(typeId: 0)
class ShoppingItem {
  @HiveField(0)
  String name;
  @HiveField(1)
  late double quantity;
  @HiveField(2)
  late String unit;
  @HiveField(3)
  late bool complete;
  ShoppingItem(
      {required this.name,
      this.quantity = 1,
      this.unit = "kpl",
      this.complete = false});
}
