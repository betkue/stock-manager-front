// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:stock_manager/constant.dart';
import 'package:stock_manager/load_page.dart';
import 'package:stock_manager/pages/suppliers/details.dart';
import 'package:stock_manager/widgets/supplier/supplier.dart';

class SupplierPage extends StatefulWidget {
  const SupplierPage({super.key});

  @override
  State<SupplierPage> createState() => _SupplierPageState();
}

class _SupplierPageState extends State<SupplierPage> {
  bool details = false;
  bool load = true;
  setStatePage() {
    setState(() {});
  }

  @override
  void initState() {
    Timer(
        Duration(seconds: 5),
        () => setState(() {
              load = false;
            }));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return load
        ? LoadPage()
        : Scaffold(
            backgroundColor: gray,
            body: SafeArea(
                child: Row(
              children: [
                Expanded(
                    flex: 8,
                    child: details
                        ? DetailSupplier(
                            id: id_supplier,
                            setParent: setStatePage,
                            back: () {
                              setState(() {
                                details = false;
                              });
                            },
                          )
                        : Scaffold(
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
                                        controller: searchSuppliersController,
                                        decoration: InputDecoration(
                                          hintText: "Search",
                                          prefixIcon: Icon(Icons.search),
                                          border: OutlineInputBorder(),
                                        ),
                                        onChanged: (value) {
                                          setState(() {
                                            // searchSuppliersController.text = value;
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 18),
                                  ElevatedButton(
                                    onPressed: () {
                                      setState(() {
                                        id_supplier = null;
                                        details = true;
                                      });
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: white,
                                      shadowColor: orange,
                                      surfaceTintColor: orange,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20,
                                          vertical:
                                              10), // Set the button's padding
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
                                  customers[index]['product_quantity']
                                      .toString(),
                                  customers[index]['location'],
                                  customers[index]['image'],
                                  customers[index]['reference'],
                                  context,
                                  () {
                                    details = true;
                                    setStatePage();
                                  },
                                );
                              },
                            ),
                          )),
              ],
            )),
          );
  }
}
