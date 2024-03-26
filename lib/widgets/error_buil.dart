import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:stock_manager/config/style.dart';

class ErrorBuild extends StatelessWidget {
  const ErrorBuild({super.key});

  @override
  Widget build(BuildContext context) {
         return Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 30),
          child: Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
                color: primaryColor, borderRadius: BorderRadius.circular(16)),
            child: Text(
              "Error building",
              style: TextStyle(color: white),
            ),
          ),
        ),
      );
  }
}