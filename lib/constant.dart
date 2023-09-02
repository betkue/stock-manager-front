// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

const Color backgroundColor = Color(0xFF007272);
const Color black = Color.fromARGB(255, 5, 5, 5);
const Color orange = Color(0xFFF68C49);
const Color white = Color.fromARGB(255, 255, 255, 255);
const Color gray = Color(0xFFD9D9D9);
const Color logo = Color(0xFF066565);
const Color dark = Color(0xFF3a3737);
const Color red = Colors.red;
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

Map<String, dynamic> company = {
  "currency": {"symbol": "FCFA", "is_double": false},
  "customers": 60,
  "suppliers": 20
};

Map<String, dynamic> user = {
  "name": "Michelle",
  "email": "betkuetjh@gmail.com",
  "image":"https://picsum.photos/250?image=9",
  "rule": "Admin"
};
Map<String, dynamic> dashboard = {
  "time": DateTime.now(),
  "count_of_all_product": 20000,
  "product_out_of_stock": 20,
  "product_overstocked": 2,
  "quantity_in_hand": 400,
  "quantity_to_be_received": 50,
  "quantity_to_be_delivered": 40,
  "purchases": {
    "quantity_ordered": 2000,
    "price_ordered": 45000,
    "amount_paid": 200,
    "price": 30000
  },
  "sales": {
    "quantity_sold": 2000,
    "price_sold": 45000,
    "amount_paid": 200,
    "price": 30000
  },
  "winning_percentage": -90,
  "benefit": -1000000,
};

List<Map<String, dynamic>> productsAll = [
  {
    "image": "https://picsum.photos/250?image=9",
    "name": "Image test stock manager",
    "available": true,
    "price": 1000,
  },
  {
    "image": "https://picsum.photos/250?image=9",
    "name": "Image test stock manager",
    "available": false,
    "price": 1000,
  }
];

List<Map<String, dynamic>> productsAvailable = [
  {
    "image": "https://picsum.photos/250?image=9",
    "name": "Image test stock manager",
    "available": true,
    "price": 1000,
  }
];

List<Map<String, dynamic>> productsUnavalaible = [
  {
    "image": "https://picsum.photos/250?image=9",
    "name": "Image test stock manager",
    "available": false,
    "price": 1000,
  }
];
