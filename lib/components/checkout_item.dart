import 'package:flutter/material.dart';
import 'package:shopping_list/components/zero_height_icon_button.dart';

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
