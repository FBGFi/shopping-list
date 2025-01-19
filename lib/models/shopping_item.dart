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
