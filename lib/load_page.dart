// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:stock_manager/config/constant.dart';
import 'package:stock_manager/config/style.dart';

class LoadPage extends StatelessWidget {
  const LoadPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor.withOpacity(0.4),
      body: Center(
        child: CircularProgressIndicator(
          color: primaryColor,
        ),
      ),
    );
  }
}
