// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:stock_manager/config/constant.dart';
import 'package:stock_manager/config/style.dart';

class TwoColumnPage extends StatefulWidget {
  Widget block;
  TwoColumnPage({super.key, required this.block});

  @override
  State<TwoColumnPage> createState() => _TwoColumnPageState();
}

class _TwoColumnPageState extends State<TwoColumnPage> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
        backgroundColor: backgroundColor,
        body: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: Text(
                    'Welcome to back Stock\n manager',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 50,
                      color: Color(0xFFFFFFFF),
                      fontWeight: FontWeight.bold,
                      shadows: <Shadow>[
                        Shadow(
                          offset: Offset(10.0, 10.0),
                          blurRadius: 3.0,
                          color: Color.fromARGB(166, 0, 0, 0),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: Text(
                    'The best solution for managing, monitoring\n and study sales for small, medium\n and large companies',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24,
                      color: Color(0xFFFFFFFF),
                      shadows: <Shadow>[
                        Shadow(
                          offset: Offset(10.0, 10.0),
                          blurRadius: 3.0,
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Container(
                padding: const EdgeInsets.all(20),
                width: width / 5,
                height: height / 1.2,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      primaryColor, // First color stop
                      backgroundColor, // Second color stop
                    ],
                    stops: [0.492, 0.69], // Relative position of color stops
                    transform: GradientRotation(
                        9 * 1.1415 / 180), // Rotation in radians
                  ),
                  boxShadow: const [
                    BoxShadow(
                      color: black,
                      offset: Offset(
                        2.0,
                        2.0,
                      ),
                      blurRadius: 10.0,
                      spreadRadius: 2.0,
                    ), //BoxShadow
                    BoxShadow(
                      color: Colors.white,
                      offset: Offset(0.0, 0.0),
                      blurRadius: 0.0,
                      spreadRadius: 0.0,
                    ), //BoxShadow
                  ],
                ),
                child: widget.block),
          ],
        ));
  }
}
