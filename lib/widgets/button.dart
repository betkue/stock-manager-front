// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:stock_manager/config/constant.dart';
import 'package:stock_manager/config/style.dart';

class Button extends StatefulWidget {
  dynamic onTap;
  final String text;
  dynamic color;
  dynamic borcolor;
  dynamic textcolor;
  dynamic width;
  dynamic height;
  // ignore: use_key_in_widget_constructors
  Button({
    required this.onTap,
    required this.text,
    this.color,
    this.borcolor,
    this.textcolor,
    this.width,
    this.height,
  });

  @override
  State<Button> createState() => _ButtonState();
}


class _ButtonState extends State<Button> {
  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;

    return InkWell(
      onTap: widget.onTap,
      child: Container(
        height: widget.height ?? media.width * 0.12,
        width: (widget.width != null) ? widget.width : null,
        padding: EdgeInsets.only(
            left: media.width * twenty, right: media.width * twenty),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: (widget.color != null) ? widget.color : buttonColor,
            border: Border.all(
              color: (widget.borcolor != null) ? widget.borcolor : buttonColor,
              width: 1,
            )),
        alignment: Alignment.center,
        child: FittedBox(
          fit: BoxFit.contain,
          child: Text(
            widget.text,
            style: TextStyle(
                fontSize: media.width * sixteen,
                color:
                    (widget.textcolor != null) ? widget.textcolor : buttonText,
                fontWeight: FontWeight.bold,
                letterSpacing: 1),
          ),
        ),
      ),
    );
  }
}
