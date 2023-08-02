import 'package:flutter/material.dart';
import 'package:stock_management/constant.dart';

class InfoPage extends StatelessWidget {
  const InfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: backgroundColor,
      body: Center(
          child: Text(
        "Thank you for providing us with the necessary information to create your online store\n for stock management. We appreciate your interest in our application.\n We kindly ask you to patiently wait for the validation of your store. Our team will review the\n details you've provided to ensure everything is set up correctly. Once the validation process\n is complete, we will send a confirmation message to your registered email address.",
        textAlign: TextAlign.center,
        style: TextStyle(
          color: white,
          fontSize: 24,
        ),
      )),
    );
  }
}
