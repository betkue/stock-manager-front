// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:stock_management/constant.dart';
import 'package:stock_management/widgets/supplier/supplier.dart';

class SupplierPage extends StatefulWidget {
  const SupplierPage({super.key});

  @override
  State<SupplierPage> createState() => _SupplierPageState();
}

class _SupplierPageState extends State<SupplierPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: gray,
      body: SafeArea(
          child: Row(
        children: [
          Expanded(
              flex: 8,
              child: Scaffold(
                appBar: AppBar(
                  backgroundColor: white,
                  toolbarHeight: 80,
                  elevation: 0,
                  automaticallyImplyLeading: false,
                  actions: const [
                    InkWell(
                      child: Icon(
                        Icons.help,
                        color: black,
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    )
                  ],
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 40,
                          width: 50,
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: "Search",
                              prefixIcon: Icon(Icons.search),
                              border: OutlineInputBorder(),
                            ),
                            onChanged: (value) {
                              setState(() {
                                searchSuppliersController.text = value;
                              });
                            },
                          ),
                        ),
                      ),
                      const SizedBox(width: 18),
                      ElevatedButton(
                        onPressed: () {
                          // Handle button press for "Add product"
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: white,
                          shadowColor: orange,
                          surfaceTintColor: orange,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 10), // Set the button's padding
                        ),
                        child: const Text(
                          "Add Supplier",
                          style: TextStyle(
                              fontSize: 16,
                              color: black,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    ],
                  ),
                ),
                body: ListView.builder(
                  itemCount: suppliers.length,
                  itemBuilder: (context, index) {
                    return supplier(
                        customers[index]['id'].toString(),
                        customers[index]['name'],
                        customers[index]['product_quantity'].toString(),
                        customers[index]['location'],
                        customers[index]['image'],
                        customers[index]['reference'],
                        context);
                  },
                ),
              )),
        ],
      )),
    );
  }
}
