import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shopping_list/models/shopping_item.dart';
import 'package:shopping_list/utils/constants.dart';

class AddNewItemContainer extends StatefulWidget {
  const AddNewItemContainer({super.key, required this.addNewItem});

  final Function(ShoppingItem item) addNewItem;

  @override
  State<AddNewItemContainer> createState() => _AddNewItemContainerState();
}

class _AddNewItemContainerState extends State<AddNewItemContainer> {
  String? name = null;
  String quantity = "1";
  String? unit = null;
  bool showErrors = false;

  _addNewItem() {
    setState(() {
      var quantityNumber = double.tryParse(quantity);
      if (name != null && quantityNumber != null && unit != null) {
        widget.addNewItem(
            ShoppingItem(name: name!, quantity: quantityNumber, unit: unit!));
      } else {
        showErrors = true;
      }
    });
  }

  _onChangeItemName(String? name) {
    if (name == null) return;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        this.name = name;
      });
    });
  }

  _onChangeItemQuantity(String quantity) {
    setState(() {
      this.quantity = quantity;
    });
  }

  _onChangeItemUnit(String? unit) {
    if (unit == null) return;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        this.unit = unit;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
            padding:
                const EdgeInsets.only(left: 15, top: 10, right: 15, bottom: 10),
            child: Column(children: [
              DropdownMenu(
                label: const Text("Name"),
                onSelected: _onChangeItemName,
                requestFocusOnTap: true,
                width: MediaQuery.sizeOf(context).width,
                errorText: showErrors && name == null ? "Required" : null,
                searchCallback: (entries, query) {
                  _onChangeItemName(query);
                  return null;
                },
                dropdownMenuEntries: const [
                  DropdownMenuEntry(value: "example", label: "example")
                ],
              ),
              Container(height: 10),
              Row(
                children: [
                  Expanded(
                      child: TextFormField(
                    keyboardType: TextInputType.number,
                    initialValue: quantity,
                    onChanged: _onChangeItemQuantity,
                    decoration: const InputDecoration(labelText: "Quantity"),
                  )),
                  Container(width: 10),
                  DropdownMenu(
                      label: const Text("Unit"),
                      onSelected: _onChangeItemUnit,
                      requestFocusOnTap: true,
                      errorText: showErrors && unit == null ? "Required" : null,
                      searchCallback: (entries, query) {
                        _onChangeItemUnit(query);
                        return null;
                      },
                      dropdownMenuEntries: BASE_UNITS
                          .map((unit) =>
                              DropdownMenuEntry(value: unit, label: unit))
                          .toList()),
                ],
              )
            ])),
        floatingActionButton: FloatingActionButton(
          onPressed: _addNewItem,
          child: const Icon(Icons.add),
        ));
  }
}
