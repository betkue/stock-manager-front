import 'package:flutter/material.dart';

dynamic pref;


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

String? id_salle;
String? id_purshase;
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

Map<String, dynamic> product_single = {
  "name": "Product Name",
  "reference": "Product Name",
  "quantity": "56",
  "price": "1344",
  "location": "Product Name",
  "description": "Description",
  "image": "https://picsum.photos/250?image=9",
};
Map<String, dynamic> customer_single = {
  "name": "Product Name",
  "reference": "Product Name",
  "location": "Product Name",
  "description": "Description",
  "image": "https://picsum.photos/250?image=9",
  "products": [
    {
      "name": "Prome",
      "reference": "Pt Name",
      "quantity": 56,
      "delivered": 30,
      "image": "https://picsum.photos/250?image=9",
      "price": 1344,
    },
    {
      "name": "Product Na",
      "reference": "Pr Name",
      "quantity": 56,
      "delivered": 30,
      "image": "https://picsum.photos/250?image=9",
      "price": 1344,
    },
    {
      "name": "Pr Name",
      "reference": "Pme",
      "quantity": 56,
      "delivered": 30,
      "price": 1344,
      "image": "https://picsum.photos/250?image=9",
    },
    {
      "name": "ct Name",
      "reference": "Produe",
      "quantity": 56,
      "delivered": 30,
      "image": "https://picsum.photos/250?image=9",
      "price": 1344,
    },
  ]
};
Map<String, dynamic> supplier_single = {
  "reference": "Product Name",
  "name": "Product Name",
  "location": "Product Name",
  "description": "Description",
  "image": "https://picsum.photos/250?image=9",
  "products": [
    {
      "name": "Prome",
      "reference": "Pt Name",
      "quantity": 56,
      "delivered": 30,
      "image": "https://picsum.photos/250?image=9",
      "price": 1344,
    },
    {
      "name": "Product Na",
      "reference": "Pr Name",
      "quantity": 56,
      "delivered": 30,
      "image": "https://picsum.photos/250?image=9",
      "price": 1344,
    },
    {
      "name": "Pr Name",
      "reference": "Pme",
      "quantity": 56,
      "delivered": 30,
      "price": 1344,
      "image": "https://picsum.photos/250?image=9",
    },
    {
      "name": "ct Name",
      "reference": "Produe",
      "quantity": 56,
      "delivered": 30,
      "image": "https://picsum.photos/250?image=9",
      "price": 1344,
    },
  ]
};
Map<String, dynamic> purshase_single = {
  "reference": "Product Name",
  "supplier": {
    "name": "Product Name",
    "reference": "Product Name",
    "location": "Product Name",
    "description": "Description",
    "image": "https://picsum.photos/250?image=9",
  },
  "products": [
    {
      "name": "Product Name",
      "reference": "Pt Name",
      "quantity": 56,
      "delivered": 30,
      "price": 1344,
    },
    {
      "name": "Product Name",
      "reference": "Product Name",
      "quantity": 56,
      "delivered": 30,
      "price": 1344,
    },
    {
      "name": "Product Name",
      "reference": "Pr Name",
      "quantity": 56,
      "delivered": 30,
      "price": 1344,
    },
    {
      "name": "Product Name",
      "reference": "Product Name",
      "quantity": 56,
      "delivered": 30,
      "price": 1344,
    },
    {
      "name": "Product Name",
      "reference": "Product Name",
      "quantity": 56,
      "delivered": 30,
      "price": 1344,
    },
    {
      "name": "Product Name",
      "reference": "Product Name",
      "quantity": 56,
      "delivered": 30,
      "price": 1344,
    },
    {
      "name": "Product Name",
      "reference": "Product Name",
      "quantity": 56,
      "delivered": 30,
      "price": 1344,
    },
  ],
  "movements": [
    {
      "return": false,
      "created_at": DateTime.now(),
      "total": 123333,
      "user": {
        "name": "Michelle",
        "email": "betkuetjh@gmail.com",
        "image": "https://picsum.photos/250?image=9",
        "rule": "Admin",
        "phone": "+237655203146",
        "active": false
      },
      "products": [
        {
          "name": "Product Name",
          "reference": "Product Name",
          "quantity": 56,
          "price": 1344,
        },
        {
          "name": "Product Name",
          "reference": "Product Name",
          "quantity": 56,
          "price": 1344,
        },
        {
          "name": "Product Name",
          "reference": "Product Name",
          "quantity": 56,
          "price": 1344,
        },
      ]
    },
    {
      "return": true,
      "created_at": DateTime.now(),
      "total": 123333,
      "user": {
        "name": "Michelle",
        "email": "betkuetjh@gmail.com",
        "image": "https://picsum.photos/250?image=9",
        "rule": "Admin",
        "phone": "+237655203146",
        "active": false
      },
      "products": [
        {
          "name": "Product Name",
          "reference": "Product Name",
          "quantity": 56,
          "price": 1344,
        },
        {
          "name": "Product Name",
          "reference": "Product Name",
          "quantity": 56,
          "price": 1344,
        },
        {
          "name": "Product Name",
          "reference": "Product Name",
          "quantity": 56,
          "price": 1344,
        },
      ]
    }
  ]
};
Map<String, dynamic> salle_single = {};

TextEditingController searchProductsController = TextEditingController();
TextEditingController searchPurchasesController = TextEditingController();
TextEditingController searchSalesController = TextEditingController();
TextEditingController searchSuppliersController = TextEditingController();
TextEditingController searchCustomersController = TextEditingController();
