// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:stock_management/constant.dart';
import 'package:stock_management/home.dart';
import 'create_store.dart';
import 'package:stock_management/dashboard.dart';

class Auth extends StatefulWidget {
  const Auth({super.key});

  @override
  State<Auth> createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  bool inSign = true;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
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
            SizedBox(
              width: width / 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: Text(
                      'Welcome ${inSign ? 'to' : 'back to'} Stock\n manager',
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
                      orange, // First color stop
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
                child: inSign ? signin() : login()),
          ],
        ));
  }

  Widget signin() {
    return Column(
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
        input('Email', Icons.email, emailController, null),
        const SizedBox(height: 20),
        input('PassWord', Icons.key, passwordController, null),
        const SizedBox(height: 20),
        input('Confirm PassWord', Icons.key, confirmPasswordController, null),
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
                  setState(() {
                    inSign = false;
                  });
                },
                child: Text(
                  "LogIn",
                  style: TextStyle(fontSize: 12, color: orange),
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
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CreateStore()),
                );
              },
              style: ElevatedButton.styleFrom(
                //<-- SEE HERE
                backgroundColor: backgroundColor,
              ),
              child: Text('SignIn', style: TextStyle(fontSize: 24)),
            ),
          ),
        ),
      ],
    );
  }

  Widget input(String label, IconData icon, TextEditingController controller,
      dynamic fuction) {
    return Container(
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
          controller: controller,
          decoration: InputDecoration(
            labelText: label,
            border: InputBorder.none,
            prefixIcon: Icon(icon),
          ),
        ));
  }

  Widget login() {
    return Column(
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
        const SizedBox(height: 40),
        input('Email', Icons.email, emailController, null),
        const SizedBox(height: 20),
        input('PassWord', Icons.key, passwordController, null),
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
                    setState(() {
                      inSign = true;
                    });
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
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Home()),
                );
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
    );
  }
}
