// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

const Color backgroundColor = Color(0xFF007272);
const Color black = Color.fromARGB(255, 5, 5, 5);
const Color orange = Color(0xFFF68C49);
const Color white = Color.fromARGB(255, 255, 255, 255);
const Color gray = Color(0xFFD9D9D9);
const Color logo = Color(0xFF066565);
const Color dark = Color(0xFF3a3737);
int home_index = 0;

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
    fillColor: white);
