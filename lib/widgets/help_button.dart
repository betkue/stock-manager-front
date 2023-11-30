import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:stock_manager/config/parameter.dart';
import 'package:stock_manager/config/style.dart';
import 'package:stock_manager/functions/function.dart';

class HelpButton extends StatefulWidget {
  const HelpButton({super.key});

  @override
  State<HelpButton> createState() => _HelpButtonState();
}

class _HelpButtonState extends State<HelpButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        openBrowser(url_help);
      },
      child: Icon(
        Icons.help,
        color: black,
      ),
    );
  }
}
