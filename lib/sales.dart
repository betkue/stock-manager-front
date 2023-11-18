// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:stock_manager/config/constant.dart';
import 'package:stock_manager/config/parameter.dart';
import 'package:stock_manager/config/style.dart';
import 'package:stock_manager/load_page.dart';
import 'package:stock_manager/pages/salles/details.dart';
import 'package:stock_manager/widgets/help_button.dart';
import 'package:stock_manager/widgets/sales/sales_block.dart';

class SalesPage extends StatefulWidget {
  const SalesPage({super.key});

  @override
  State<SalesPage> createState() => _SalesPageState();
}

class _SalesPageState extends State<SalesPage> {
  int index = 0;

  bool details = false;
  changeState(int i) {
    setState(() {
      index = i;
    });
  }

  setStatePage() {
    setState(() {});
  }

  bool load = true;
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
                        ? DetailSalle(
                            id: id_salle,
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
                               HelpButton(),
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
                                        controller: searchSalesController,
                                        decoration: InputDecoration(
                                          hintText: "Search",
                                          prefixIcon: Icon(Icons.search),
                                          border: OutlineInputBorder(),
                                        ),
                                        onChanged: (value) {
                                          setState(() {
                                            // searchSalesController.text = value;
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 18),
                                  ElevatedButton(
                                    onPressed: () {
                                      setState(() {
                                        id_salle = null;
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
                                      "New Sales",
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: black,
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
                                          "All Sales",
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
                                          "Pending",
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
                                          "Incomplete",
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: index == 2 ? white : black,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ),
                                      const SizedBox(width: 80),
                                      ElevatedButton(
                                        onPressed: () {
                                          changeState(3);
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              index == 3 ? primaryColor : white,
                                          shadowColor: primaryColor,
                                          surfaceTintColor: primaryColor,
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20,
                                              vertical:
                                                  10), // Set the button's padding
                                        ),
                                        child: Text(
                                          "Complete",
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: index == 3 ? white : black,
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
      return AllSales(
        setParent: () {
          details = true;
          setStatePage();
        },
      );
    } else if (index == 1) {
      return PendingSales(
        setParent: () {
          details = true;
          setStatePage();
        },
      );
    } else if (index == 2) {
      return IncompleteSales(
        setParent: () {
          details = true;
          setStatePage();
        },
      );
    } else {
      return CompleteSales(
        setParent: () {
          details = true;
          setStatePage();
        },
      );
    }
  }
}
