import 'package:flutter/material.dart';

const Color backgroundColor =
    Color.fromARGB(255, 50, 50, 50); //Color(0xFF007272);
const Color black = Color.fromARGB(255, 5, 5, 5);

const Color primaryColor = Color(0xFFF68C49);
const Color white = Color.fromARGB(255, 255, 255, 255);
const Color gray = Color.fromARGB(255, 185, 185, 185); // Color(0xFFD9D9D9);
// const Color logo = Color(0xFF066565);
const Color dark = Color(0xFF3a3737);
const Color red = Colors.red;
const Color textColor = Colors.black;

const Color colorTestTab = Colors.grey;

const Color hintColor = Color.fromARGB(120, 158, 158, 158);
const Color buttonText = Colors.white;
const Color buttonColor = primaryColor;
const Color loaderColor = primaryColor;



InputDecoration inputDecoration(String hintText) => InputDecoration(
    filled: true,
    border: OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.circular((5)),
    ),
    hintText: hintText,
    focusedBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: white, width: 2.0),
      borderRadius: BorderRadius.circular(5),
    ),
    fillColor: gray);