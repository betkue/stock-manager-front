// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:stock_management/constant.dart';

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
                    return Container(
                      color: white,
                      child: Container(
                        // Add any styling properties for the item container here
                        margin: const EdgeInsets.all(8.0),
                        padding: const EdgeInsets.all(8.0),
                        decoration: const BoxDecoration(
                          color: white,
                          // borderRadius: BorderRadius.circular(8.0),
                          boxShadow: [
                            BoxShadow(
                              color: gray,
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset:
                                  Offset(0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Container(
                              height: 100,
                              width: 100,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage(
                                        suppliers[index]['image'])),
                                color: orange,
                                borderRadius: BorderRadius.circular(
                                    MediaQuery.of(context).size.height),
                                // color: widget.color ?? orange,
                              ),
                              // child: Image.network(
                              //  ,
                              //   // fit: BoxFit.cover,
                              // )
                            ),
                            const SizedBox(width: 30),
                            Expanded(child: Text(suppliers[index]['name'])),
                            Expanded(
                                child: Text(
                                    "${suppliers[index]['reference']} $index")),
                            Expanded(
                                child: Text(
                                    "Quantity : ${suppliers[index]['product_quantity']}")),
                            Expanded(
                                child: Text(
                                    "Location : ${suppliers[index]['location']}")),
                            Expanded(
                              child: IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.edit_outlined,
                                  color: Colors.orange,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              )),
        ],
      )),
    );
  }
}
