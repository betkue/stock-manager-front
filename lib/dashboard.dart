// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:stock_manager/config/constant.dart';
import 'package:d_chart/d_chart.dart';
import 'package:stock_manager/config/parameter.dart';
import 'package:stock_manager/config/style.dart';
import 'package:stock_manager/functions/store_function.dart';
import 'package:stock_manager/load_page.dart';
import 'package:stock_manager/pages/no_data.dart';
import 'package:stock_manager/pages/no_internet.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({super.key});

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  bool loading = true;
  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() async {
    setState(() {
      loading = true;
    });

    await getDashboard();

    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    double radius = 15;
    return loading
        ? LoadPage()
        : Scaffold(
            backgroundColor: gray,
            body: SafeArea(
              child: dashboard.isEmpty
                  ? NoData(onTap: () async {
                      await getData();
                    })
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
                        title: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Add your widgets for the information bar here
                            Text(
                              "DashBoard",
                              style: TextStyle(fontSize: 22, color: black),
                            ),
                            Text(
                              '', // '/This Month',
                              style: TextStyle(
                                fontFamily: "IBMPlexSans",
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                color: black,
                                height: 24 / 20,
                              ),
                            ),
                            // Icon(
                            //   Icons.arrow_drop_down,
                            //   color: black,
                            // ),
                          ],
                        ),
                      ),
                      body: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 20),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                // container 2

                                Expanded(
                                  child: Container(
                                    height: 200,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 10),
                                    decoration: BoxDecoration(
                                        color: white,
                                        borderRadius:
                                            BorderRadius.circular(radius)),
                                    // Add your widgets for container 2 here
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        productInfo(
                                            "count of all product",
                                            dashboard['count_of_all_product'],
                                            true),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Divider(),
                                        productInfo(
                                            "Product out of stock",
                                            dashboard['product_out_of_stock'],
                                            true),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Divider(),
                                        productInfo(
                                            "Product overstocked",
                                            dashboard['product_overstocked'],
                                            true),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 20),
                                // container 3
                                Expanded(
                                  child: Container(
                                    height: 200,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 28, vertical: 10),
                                    decoration: BoxDecoration(
                                        color: white,
                                        borderRadius:
                                            BorderRadius.circular(radius)),
                                    // Add your widgets for container 3 here
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Inventory Summary",
                                          style: const TextStyle(
                                            fontFamily: "IBMPlexSans",
                                            fontSize: 15,
                                            fontWeight: FontWeight.w400,
                                            color: Color(0xff000000),
                                            height: 24 / 20,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 30,
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            productInfo(
                                                "Quantity in hand",
                                                dashboard['quantity_in_hand'],
                                                false),
                                            SizedBox(
                                              height: 15,
                                            ),
                                            productInfo(
                                                "Quantity to be received",
                                                dashboard[
                                                    'quantity_to_be_received'],
                                                false),
                                            SizedBox(
                                              height: 15,
                                            ),
                                            productInfo(
                                                "Quantity to be delivered",
                                                dashboard[
                                                    'quantity_to_be_delivered'],
                                                false),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            // Large container 4

                            Expanded(
                              child: Container(
                                decoration: const BoxDecoration(
                                  color: white,
                                ),
                                // Add your widgets for the large container 4 here
                                child: Column(
                                  children: [
                                    Expanded(
                                      child: SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            orderInfo(
                                                "Purchase Order",
                                                dashboard['purchases']
                                                    ['quantity_ordered'],
                                                dashboard['purchases']
                                                    ['price_ordered'],
                                                dashboard['purchases']
                                                    ['amount_paid'],
                                                dashboard['purchases']['price'],
                                                "Ordered"),
                                            orderInfo(
                                                "Sales Order",
                                                dashboard['sales']
                                                    ['quantity_sold'],
                                                dashboard['sales']
                                                    ['price_sold'],
                                                dashboard['sales']
                                                    ['amount_paid'],
                                                dashboard['sales']['price'],
                                                "Sold"),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          SizedBox(
                                              width: 380,
                                              height: 220,
                                              child: Column(
                                                children: [
                                                  SizedBox(
                                                    child: Text(
                                                        "Winning Percentage"),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 5),
                                                    child: AspectRatio(
                                                      aspectRatio: 10 / 5,
                                                      child: Stack(
                                                        children: [
                                                          DChartPie(
                                                            data: [
                                                              {
                                                                'domain':
                                                                    'actve',
                                                                'measure':
                                                                    dashboard[
                                                                            'winning_percentage']
                                                                        .abs()
                                                              },
                                                              {
                                                                'domain':
                                                                    'inactve',
                                                                'measure': 100 -
                                                                    dashboard[
                                                                            'winning_percentage']
                                                                        .abs()
                                                              },
                                                            ],
                                                            fillColor: (pieData,
                                                                index) {
                                                              switch (pieData[
                                                                  'domain']) {
                                                                case 'actve':
                                                                  return dashboard[
                                                                              'winning_percentage'] >
                                                                          0
                                                                      ? primaryColor
                                                                      : red;
                                                                case 'inactve':
                                                                  return gray;
                                                                default:
                                                                  return gray;
                                                              }
                                                            },
                                                            pieLabel: (pieData,
                                                                index) {
                                                              return "";
                                                            },
                                                            donutWidth: 30,
                                                            // labelColor:
                                                            //     Colors.white,
                                                          ),
                                                          Align(
                                                              child: Text(
                                                            '${dashboard['winning_percentage']} %',
                                                            style: TextStyle(
                                                                color:
                                                                    primaryColor),
                                                          )),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              )),
                                          Column(
                                            children: [
                                              Container(
                                                // width: 780,
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 10),
                                                height: 90,
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: gray, width: 0.5),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0),
                                                ),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      "Benefit",
                                                      style: TextStyle(
                                                          fontSize: 15),
                                                    ),
                                                    SizedBox(
                                                      height: 8,
                                                    ),
                                                    Text(
                                                      "${dashboard['benefit'] > 0 ? "+" : ""} ${dashboard['benefit']} ${company['currency']['symbol']}",
                                                      style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color: primaryColor,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                height: 20,
                                              ),
                                              Expanded(
                                                // width: 780,
                                                child: Row(
                                                  children: [
                                                    Container(
                                                        width: 180,
                                                        height: 80,
                                                        decoration:
                                                            BoxDecoration(
                                                          border: Border.all(
                                                              color: gray,
                                                              width: 0.5),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      5.0),
                                                        ),
                                                        child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Text(
                                                                "${company['customers']}",
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 15,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  color:
                                                                      primaryColor,
                                                                ),
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                              ),
                                                              SizedBox(
                                                                height: 10,
                                                              ),
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  Icon(
                                                                    Icons
                                                                        .person,
                                                                    color:
                                                                        black,
                                                                  ),
                                                                  Text(
                                                                    "Customers",
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          15,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400,
                                                                      color:
                                                                          black,
                                                                    ),
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                  ),
                                                                ],
                                                              ),
                                                            ])),
                                                    SizedBox(
                                                      width: 25,
                                                    ),
                                                    Container(
                                                        width: 180,
                                                        height: 80,
                                                        decoration:
                                                            BoxDecoration(
                                                          border: Border.all(
                                                              color: gray,
                                                              width: 0.5),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      5.0),
                                                        ),
                                                        child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Text(
                                                                "${company['suppliers']}",
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 15,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  color:
                                                                      primaryColor,
                                                                ),
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                              ),
                                                              SizedBox(
                                                                height: 10,
                                                              ),
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  Icon(
                                                                    Icons
                                                                        .handshake,
                                                                    color:
                                                                        black,
                                                                  ),
                                                                  Text(
                                                                    "Suppliers",
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          15,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400,
                                                                      color:
                                                                          black,
                                                                    ),
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                  ),
                                                                ],
                                                              ),
                                                            ])),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
            ));
  }

  Widget productInfo(String title, int number, bool showPrduct) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.w400,
            color: black,
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              number.toString(),
              style:
                  TextStyle(fontWeight: FontWeight.w400, color: primaryColor),
              textAlign: TextAlign.center,
            ),
            Divider(
              height: 5,
            ),
            showPrduct
                ? Text(
                    "Products",
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.center,
                  )
                : Container()
          ],
        )
      ],
    );
  }

  Widget topSellingItems(String imagePath, String productName, int quantity) {
    return SizedBox(
      width: 200,
      height: 200,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 80,
            width: double.infinity,
            child: Image.asset(
              imagePath,
              fit: BoxFit.cover,
            ),
          ),
          Text(
            productName,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 10),
          Text(
            quantity.toString(),
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(
            "sets",
            style: TextStyle(color: Colors.black87, fontSize: 10),
          ),
        ],
      ),
    );
  }

  Widget orderInfo(String title, int quantity1, int price1, int quantity2,
      int price2, String type) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(
              color: black,
              fontSize: 15,
            ),
          ),
          SizedBox(height: 10),
          Container(
            padding: EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              border: Border.all(color: gray, width: 0.5),
              borderRadius: BorderRadius.circular(5.0),
            ),
            width: 550,
            // height: 160,
            child: Column(
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: 270,
                      // content of the first section
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Quantity $type",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w400,
                                color: black,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            Text(
                              "$quantity1",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                color: primaryColor,
                              ),
                              textAlign: TextAlign.center,
                            )
                          ]),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    SizedBox(
                      width: 270,

                      // content of the second section
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Text(
                            //   "Total Cost",
                            //   style: TextStyle(
                            //     fontSize: 20,
                            //     fontWeight: FontWeight.w400,
                            //     color: black,
                            //     height: 24 / 20,
                            //   ),
                            //   textAlign: TextAlign.center,
                            // ),
                            // SizedBox(
                            //   height: 12,
                            // ),
                            Text(
                              "$price1 ${company['currency']['symbol']}",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                color: primaryColor,
                              ),
                              textAlign: TextAlign.center,
                            )
                          ]),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 270,
                      // content of the first section
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Amount paid",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w400,
                                color: black,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            Text(
                              "$quantity2",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                color: primaryColor,
                              ),
                              textAlign: TextAlign.center,
                            )
                          ]),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    SizedBox(
                      width: 270,

                      // content of the second section
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Text(
                            //   "Total Cost",
                            //   style: TextStyle(
                            //     fontSize: 20,
                            //     fontWeight: FontWeight.w400,
                            //     color: black,
                            //     height: 24 / 20,
                            //   ),
                            //   textAlign: TextAlign.center,
                            // ),
                            // SizedBox(
                            //   height: 12,
                            // ),
                            Text(
                              "$price2 ${company['currency']['symbol']}",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                color: primaryColor,
                              ),
                              textAlign: TextAlign.center,
                            )
                          ]),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
