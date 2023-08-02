// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:stock_management/auth.dart';
import 'package:stock_management/constant.dart';
import 'package:stock_management/home.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Connection page',
      home: Scaffold(backgroundColor: backgroundColor, body: Home() //Auth(),
          ),
    );
  }
}
