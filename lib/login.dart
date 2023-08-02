// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:stock_management/constant.dart';
import 'package:stock_management/dashboard.dart';
import 'package:stock_management/signin.dart';
import 'package:stock_management/widgets/two_column.dart';

class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  @override
  Widget build(BuildContext context) {
    return TwoColumnPage(
      block: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Text('Login',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFFFFFFF))),
          ),
          Container(
            width: 250,
            height: 47,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Email',
                border: InputBorder.none,
                prefixIcon: Icon(Icons.key),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Container(
            width: 250,
            height: 47,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Password',
                border: InputBorder.none,
                prefixIcon: Icon(Icons.key),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Padding(
              padding: EdgeInsets.all(16.0),
              child: Wrap(
                children: [
                  Text(
                    "You don’t have an account ? ",
                    style: TextStyle(fontSize: 12, color: white),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Signin()));
                    },
                    child: Text(
                      "SingIn",
                      style: TextStyle(fontSize: 12, color: orange),
                    ),
                  ),
                ],
              )),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: SizedBox(
              width: 250,
              height: 47,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => DashBoard()));
                },
                style: ElevatedButton.styleFrom(
                  //<-- SEE HERE
                  backgroundColor: backgroundColor,
                ),
                child: Text('LogIn', style: TextStyle(fontSize: 24)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
