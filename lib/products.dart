// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:stock_manager/config/constant.dart';
import 'package:stock_manager/config/parameter.dart';
import 'package:stock_manager/config/style.dart';
import 'package:stock_manager/load_page.dart';
import 'package:stock_manager/pages/products/details.dart';
import 'package:stock_manager/widgets/products/products_block.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  int index = 0;
  bool load = true;
  bool details = false;
  changeState(int i) {
    setState(() {
      index = i;
    });
  }

  setStatePage() {
    setState(() {});
  }

  @override
  void initState() {
    Timer(
        Duration(seconds: timedalay),
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
              child: Row(children: [
                Expanded(
                    flex: 8,
                    child: details
                        ? DetailProduct(
                            id: id_product,
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
                                    color: Colors.black,
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
                                        controller: searchProductsController,
                                        decoration: InputDecoration(
                                          hintText: "Search",
                                          prefixIcon: Icon(Icons.search),
                                          border: OutlineInputBorder(),
                                        ),
                                        onChanged: (value) {
                                          setState(() {
                                            // searchProductsController.text = value;
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 18),
                                  ElevatedButton(
                                    onPressed: () {
                                      setState(() {
                                        id_product = null;
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
                                    child: Text(
                                      "Add product",
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            body: SafeArea(
                                child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 20.0, bottom: 40.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      ElevatedButton(
                                        onPressed: () {
                                          changeState(0);
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              index == 0 ? primaryColor : white,
                                          shadowColor: primaryColor,
                                          surfaceTintColor: primaryColor,
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20,
                                              vertical:
                                                  10), // Set the button's padding
                                        ),
                                        child: Text(
                                          "All Products",
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: index == 0 ? white : black,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ),
                                      const SizedBox(width: 80),
                                      ElevatedButton(
                                        onPressed: () {
                                          changeState(1);
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              index == 1 ? primaryColor : white,
                                          shadowColor: primaryColor,
                                          surfaceTintColor: primaryColor,
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20,
                                              vertical:
                                                  10), // Set the button's padding
                                        ),
                                        child: Text(
                                          "Available",
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: index == 1 ? white : black,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ),
                                      const SizedBox(width: 80),
                                      ElevatedButton(
                                        onPressed: () {
                                          changeState(2);
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              index == 2 ? primaryColor : white,
                                          shadowColor: primaryColor,
                                          surfaceTintColor: primaryColor,
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20,
                                              vertical:
                                                  10), // Set the button's padding
                                        ),
                                        child: Text(
                                          "Unavailable",
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: index == 2 ? white : black,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(child: determineWidget()),
                              ],
                            )),
                          )),
              ]),
            ),
          );
  }

  Widget determineWidget() {
    if (index == 0) {
      return Allproduct(
        setParent: () {
          details = true;
          setStatePage();
        },
      );
    } else if (index == 1) {
      return Availableproduct(
        setParent: () {
          details = true;
          setStatePage();
        },
      );
    } else {
      return Unavailableproduct(
        setParent: () {
          details = true;
          setStatePage();
        },
      );
    }
  }
}
