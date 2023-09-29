import 'package:flutter/material.dart';
import 'package:stock_manager/constant.dart';

class CirularButton extends StatelessWidget {
  final Widget icon;
  final Function()? onClick;
  const CirularButton(
      {super.key,
      this.icon = const Icon(
        Icons.close,
        size: 22,
        color: white,
      ),
      required this.onClick});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 35,
      height: 35,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
      ),
      clipBehavior: Clip.hardEdge,
      child: Material(
        color: black,
        child: InkWell(
          onTap: onClick,
          child: icon,
        ),
      ),
    );
  }
}
