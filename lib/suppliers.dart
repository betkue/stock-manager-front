// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:stock_manager/config/constant.dart';
import 'package:stock_manager/config/parameter.dart';
import 'package:stock_manager/config/style.dart';
import 'package:stock_manager/functions/supplier_function.dart';
import 'package:stock_manager/load_page.dart';
import 'package:stock_manager/pages/suppliers/details.dart';
import 'package:stock_manager/widgets/supplier/supplier.dart';

class SupplierPage extends StatefulWidget {
  const SupplierPage({super.key});

  @override
  State<SupplierPage> createState() => _SupplierPageState();
}

class _SupplierPageState extends State<SupplierPage> {
  bool load = true;

  bool details = false;

  setStatePage() {
    setState(() {});
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() async {
    setState(() {
      load = true;
    });

    await getSuppliers();

    setState(() {
      load = false;
    });
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
                            back: () async {
                              setState(() {
                                details = false;
                              });
                              await getData();
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
                                      shadowColor: primaryColor,
                                      surfaceTintColor: primaryColor,
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
                                  suppliers[index]['id'].toString(),
                                  suppliers[index]['name'],
                                  suppliers[index]['sigle'] ?? "",
                                  suppliers[index]['location'],
                                  suppliers[index]['logo'] ??
                                      'https://picsum.photos/200/300',
                                  suppliers[index]['reference'],
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
