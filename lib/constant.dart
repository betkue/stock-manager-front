// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

const Color backgroundColor =
    Color.fromARGB(255, 50, 50, 50); //Color(0xFF007272);
const Color black = Color.fromARGB(255, 5, 5, 5);
const Color orange = Color(0xFFF68C49);
const Color white = Color.fromARGB(255, 255, 255, 255);
const Color gray = Color.fromARGB(255, 185, 185, 185); // Color(0xFFD9D9D9);
// const Color logo = Color(0xFF066565);
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
    fillColor: gray);

Map<String, dynamic> company = {
  "currency": {"symbol": "FCFA", "is_double": false},
  "customers": 60,
  "suppliers": 20
};

Map<String, dynamic> user = {
  "name": "Michelle",
  "email": "betkuetjh@gmail.com",
  "image": "https://picsum.photos/250?image=9",
  "rule": "Admin",
  "phone": "+237655203146"
};
List<Map<String, dynamic>> users = [
  {
    "name": "Michelle",
    "email": "betkuetjh@gmail.com",
    "image": "https://picsum.photos/250?image=9",
    "rule": "Admin",
    "phone": "+237655203146",
    "active": true
  },
  {
    "name": "Michelle",
    "email": "betkuetjh@gmail.com",
    "image": "https://picsum.photos/250?image=9",
    "rule": "Admin",
    "phone": "+237655203146",
    "active": false
  },
  {
    "name": "Michelle",
    "email": "betkuetjh@gmail.com",
    "image": "https://picsum.photos/250?image=9",
    "rule": "Admin",
    "phone": "+237655203146",
    "active": true
  },
  {
    "name": "Michelle",
    "email": "betkuetjh@gmail.com",
    "image": "https://picsum.photos/250?image=9",
    "rule": "Admin",
    "phone": "+237655203146",
    "active": false
  }
];
dynamic user_name;
dynamic user_email;
dynamic user_image;
dynamic user_rule;
dynamic user_phone;
dynamic user_password;

String? id_product;
String? id_customer;
String? id_supplier;
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

List<Map<String, dynamic>> customers = [
  {
    "image": "https://picsum.photos/250?image=9",
    "name": "Image test stock manager",
    "reference": "#poijkj454664",
    "product_quantity": 1000,
    "location": "Pk 19"
  },
  {
    "image": "https://picsum.photos/250?image=9",
    "name": "Image test stock manager",
    "reference": "#poijkj454664",
    "product_quantity": 1000,
    "location": "Pk 19"
  }
];

List<Map<String, dynamic>> suppliers = [
  {
    "image": "https://picsum.photos/250?image=9",
    "name": "Image test stock manager",
    "reference": "#poijkj454664",
    "product_quantity": 1000,
    "location": "Pk 19"
  },
  {
    "image": "https://picsum.photos/250?image=9",
    "name": "Image test stock manager",
    "reference": "#poijkj454664",
    "product_quantity": 1000,
    "location": "Pk 19"
  }
];

List<Map<String, dynamic>> purchasesAll = [
  {
    "image": "https://picsum.photos/250?image=9",
    "name": "Image test stock manager",
    "reference": "#poijkj454664",
    "price": 1000,
    "shipping_state": 0,
    "paiement_state": 0
  },
  {
    "image": "https://picsum.photos/250?image=9",
    "name": "Image test stock manager",
    "reference": "#poijkj454664",
    "price": 1000,
    "shipping_state": 2,
    "paiement_state": 0
  },
];

List<Map<String, dynamic>> purchasesPending = [
  {
    "image": "https://picsum.photos/250?image=9",
    "name": "Image test stock manager",
    "reference": "#poijkj454664",
    "price": 1000,
    "shipping_state": 0,
    "paiement_state": 1
  },
];

List<Map<String, dynamic>> purchasesIncomplete = [
  {
    "image": "https://picsum.photos/250?image=9",
    "name": "Image test stock manager",
    "reference": "#poijkj454664",
    "price": 1000,
    "shipping_state": 1,
    "paiement_state": 2
  },
];

List<Map<String, dynamic>> purchasesComplete = [
  {
    "image": "https://picsum.photos/250?image=9",
    "name": "Image test stock manager",
    "reference": "#poijkj454664",
    "price": 1000,
    "shipping_state": 2,
    "paiement_state": 0
  },
];

List<Map<String, dynamic>> salesAll = [
  {
    "image": "https://picsum.photos/250?image=9",
    "name": "Image test stock manager",
    "reference": "#poijkj454664",
    "price": 1000,
    "shipping_state": 0,
    "paiement_state": 0
  },
  {
    "image": "https://picsum.photos/250?image=9",
    "name": "Image test stock manager",
    "reference": "#poijkj454664",
    "price": 1000,
    "shipping_state": 2,
    "paiement_state": 0
  },
];

List<Map<String, dynamic>> salesPending = [
  {
    "image": "https://picsum.photos/250?image=9",
    "name": "Image test stock manager",
    "reference": "#poijkj454664",
    "price": 1000,
    "shipping_state": 0,
    "paiement_state": 1
  },
];

List<Map<String, dynamic>> salesIncomplete = [
  {
    "image": "https://picsum.photos/250?image=9",
    "name": "Image test stock manager",
    "reference": "#poijkj454664",
    "price": 1000,
    "shipping_state": 1,
    "paiement_state": 2
  },
];

List<Map<String, dynamic>> salesComplete = [
  {
    "image": "https://picsum.photos/250?image=9",
    "name": "Image test stock manager",
    "reference": "#poijkj454664",
    "price": 1000,
    "shipping_state": 2,
    "paiement_state": 0
  },
];

Map<String, dynamic> product_single = {};
Map<String, dynamic> customer_single = {};
Map<String, dynamic> supplier_single = {};

TextEditingController searchProductsController = TextEditingController();
TextEditingController searchPurchasesController = TextEditingController();
TextEditingController searchSalesController = TextEditingController();
TextEditingController searchSuppliersController = TextEditingController();
TextEditingController searchCustomersController = TextEditingController();
