// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:stock_manager/config/parameter.dart';
import 'package:stock_manager/config/style.dart';
import 'package:stock_manager/create_store.dart';
import 'package:stock_manager/functions/auth_function.dart';
import 'package:stock_manager/home.dart';
import 'package:stock_manager/signin.dart';
import 'package:stock_manager/widgets/two_column.dart';

class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  bool loading = false;

  dynamic error;
  @override
  Widget build(BuildContext context) {
    return TwoColumnPage(
      loading: loading,
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
              controller: emailController,
              cursorColor: black,
              keyboardType: TextInputType.emailAddress,
              onChanged: (value) {
                setState(() {});
              },
              decoration: InputDecoration(
                labelStyle: TextStyle(color: black),
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
              controller: passwordController,
              cursorColor: black,
              onChanged: (value) {
                setState(() {});
              },
              obscureText: true,
              decoration: InputDecoration(
                labelStyle: TextStyle(color: black),
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
                      style: TextStyle(fontSize: 12, color: primaryColor),
                    ),
                  ),
                ],
              )),
          emailController.text.isNotEmpty && passwordController.text.isNotEmpty
              ? Padding(
                  padding: EdgeInsets.all(16.0),
                  child: SizedBox(
                    width: 250,
                    height: 47,
                    child: ElevatedButton(
                      onPressed: () async {
                        error = null;
                        setState(() {
                          loading = true;
                        });
                        var result = await login(
                          emailController.text,
                          passwordController.text,
                        );

                        if (result == true) {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CreateStore()),
                              (route) => false);
                        } else if (result == false) {
                          error = "echec";
                        } else {
                          setState(() {
                            error = result;
                          });
                        }
                        setState(() {
                          loading = false;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        //<-- SEE HERE
                        backgroundColor: backgroundColor,
                      ),
                      child: Text('LogIn', style: TextStyle(fontSize: 24)),
                    ),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
