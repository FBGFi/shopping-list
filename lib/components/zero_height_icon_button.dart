import 'package:flutter/material.dart';

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
