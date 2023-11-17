// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:stock_manager/config/constant.dart';
import 'package:stock_manager/config/parameter.dart';
import 'package:stock_manager/config/style.dart';
import 'package:stock_manager/functions/product_function.dart';
import 'package:stock_manager/load_page.dart';
import 'package:stock_manager/pages/movement/details.dart';
import 'package:stock_manager/pages/products/details.dart';
import 'package:stock_manager/widgets/movements/movement_block.dart';
import 'package:stock_manager/widgets/products/products_block.dart';

class Movements extends StatefulWidget {
  const Movements({super.key});

  @override
  State<Movements> createState() => _MovementsState();
}

class _MovementsState extends State<Movements> {
  bool? index;
  bool load = true;
  bool details = false;
  changeState(bool? i) async {
    setState(() {
      index = i ?? null;
    });
    await getData(i);
  }

  setStatePage() async {
    setState(() {
      load = !load;
    });
    if (!load) {
      await getData(index);
    }
  }

  @override
  void initState() {
    getData(null);
    super.initState();
  }

  getData(bool? i) async {
    setState(() {
      load = true;
    });

    await getMovements(i);

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
              child: Row(children: [
                Expanded(
                    flex: 8,
                    child: details
                        ? DetailMovement(
                            id: id_product,
                            setParent: setStatePage,
                            back: () async {
                              setState(() {
                                details = false;
                              });
                              await getData(index);
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
                                      "Add Movement",
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
                                        onPressed: () async {
                                          await changeState(null);
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: index == null
                                              ? primaryColor
                                              : white,
                                          shadowColor: primaryColor,
                                          surfaceTintColor: primaryColor,
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20,
                                              vertical:
                                                  10), // Set the button's padding
                                        ),
                                        child: Text(
                                          "All Movements",
                                          style: TextStyle(
                                              fontSize: 16,
                                              color:
                                                  index == null ? white : black,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ),
                                      const SizedBox(width: 80),
                                      ElevatedButton(
                                        onPressed: () async {
                                          await changeState(false);
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: index == false
                                              ? primaryColor
                                              : white,
                                          shadowColor: primaryColor,
                                          surfaceTintColor: primaryColor,
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20,
                                              vertical:
                                                  10), // Set the button's padding
                                        ),
                                        child: Text(
                                          "Exit",
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: index == false
                                                  ? white
                                                  : black,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ),
                                      const SizedBox(width: 80),
                                      ElevatedButton(
                                        onPressed: () async {
                                          await changeState(true);
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: index == true
                                              ? primaryColor
                                              : white,
                                          shadowColor: primaryColor,
                                          surfaceTintColor: primaryColor,
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20,
                                              vertical:
                                                  10), // Set the button's padding
                                        ),
                                        child: Text(
                                          "Entry",
                                          style: TextStyle(
                                              fontSize: 16,
                                              color:
                                                  index == true ? white : black,
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
    if (index == null) {
      return Allmovement(
        setParent: () {
          // details = true;
          setStatePage();
        },
      );
    } else if (index == true) {
      return EntryMovement(
        setParent: () {
          // details = true;
          setStatePage();
        },
      );
    } else {
      return ExitMovement(
        setParent: () {
          // details = true;
          setStatePage();
        },
      );
    }
  }
}
