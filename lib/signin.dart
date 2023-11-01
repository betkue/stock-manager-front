// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:stock_manager/config/constant.dart';
import 'package:stock_manager/config/style.dart';
import 'package:stock_manager/create_store.dart';
import 'package:stock_manager/login.dart';
import 'package:stock_manager/widgets/two_column.dart';

class Signin extends StatefulWidget {
  const Signin({super.key});

  @override
  State<Signin> createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  @override
  Widget build(BuildContext context) {
    return TwoColumnPage(
      block: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Create your account',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFFFFFFF)),
            ),
          ),
          const SizedBox(height: 40),
          Container(
            width: 250,
            height: 47,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.white,
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
                prefixIcon: Icon(Icons.email),
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
                labelText: 'Confirm Password',
                border: InputBorder.none,
                prefixIcon: Icon(Icons.key),
              ),
            ),
          ),
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
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const LogIn()));
                  },
                  child: Text(
                    "LogIn",
                    style: TextStyle(fontSize: 12, color: primaryColor),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: SizedBox(
              width: 250,
              height: 47,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => CreateStore()));
                },
                style: ElevatedButton.styleFrom(
                  //<-- SEE HERE
                  backgroundColor: backgroundColor,
                ),
                child: Text('SignIn', style: TextStyle(fontSize: 24)),
              ),
            ),
          ),
          /*Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Divider(
                          color: white,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          'Or continue with',
                          style:
                              TextStyle(fontSize: 10, color: Color(0xFFFFFFFF)),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          color: white,
                        ),
                      ),
                    ],
                  ),
                ),*/
          /*Padding(
                  padding: EdgeInsets.all(16.0),
                ),*/
        ],
      ),
    );
  }
}
