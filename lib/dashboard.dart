// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:stock_management/constant.dart';
import 'package:d_chart/d_chart.dart';

class DashBoard extends StatelessWidget {
  const DashBoard({super.key});

  @override
  Widget build(BuildContext context) {
    double radius = 15;
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
                    title: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Add your widgets for the information bar here
                        Text(
                          "DashBoard/",
                          style: TextStyle(fontSize: 22, color: black),
                        ),
                        Text(
                          'This Month',
                          style: TextStyle(
                            fontFamily: "IBMPlexSans",
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            color: black,
                            height: 24 / 20,
                          ),
                        ),
                        Icon(
                          Icons.arrow_drop_down,
                          color: black,
                        ),
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
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    productInfo(
                                        "count of all product", 20000, true),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Divider(),
                                    productInfo(
                                        "Product out of stock", 20, true),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Divider(),
                                    productInfo("Product overstocked", 2, true),
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
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
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
                                            "Quantity in hand", 450, false),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        productInfo("Quantity to be received",
                                            50, false),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        productInfo("Quantity to be delivered",
                                            250, false),
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
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Center(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                "Purchase order",
                                                style: TextStyle(
                                                  color: black,
                                                  fontSize: 15,
                                                ),
                                              ),
                                              SizedBox(height: 10),
                                              Container(
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: gray, width: 0.5),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0),
                                                ),
                                                width: 550,
                                                height: 180,
                                                child: Row(
                                                  children: const [
                                                    SizedBox(
                                                      width: 270,
                                                      // content of the first section
                                                      child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Text(
                                                              "Quantity Ordered",
                                                              style: TextStyle(
                                                                fontSize: 20,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                color: black,
                                                              ),
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                            ),
                                                            SizedBox(
                                                              height: 12,
                                                            ),
                                                            Text(
                                                              "7620",
                                                              style: TextStyle(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                color: orange,
                                                              ),
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
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
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Text(
                                                              "Total Cost",
                                                              style: TextStyle(
                                                                fontSize: 20,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                color: black,
                                                                height: 24 / 20,
                                                              ),
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                            ),
                                                            SizedBox(
                                                              height: 12,
                                                            ),
                                                            Text(
                                                              "45000 FCFA",
                                                              style: TextStyle(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                color: orange,
                                                              ),
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                            )
                                                          ]),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "Top selling items",
                                              style: TextStyle(
                                                color: black,
                                                fontSize: 15,
                                              ),
                                            ),
                                            SizedBox(height: 10),
                                            Container(
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: gray, width: 0.5),
                                                borderRadius:
                                                    BorderRadius.circular(5.0),
                                              ),
                                              width: 550,
                                              height: 180,
                                              child: Row(
                                                children: [
                                                  SizedBox(
                                                    width: 170,
                                                    // content of the first section
                                                    child: topSellingItems(
                                                      "assets/images/shoes1.png",
                                                      "Women's Air Jordan 1\n Low SE Utility",
                                                      14,
                                                    ),
                                                  ),
                                                  VerticalDivider(
                                                    color: gray,
                                                    thickness: 0.5,
                                                  ),
                                                  SizedBox(
                                                    width: 170,
                                                    // content of the second section
                                                    child: topSellingItems(
                                                      "assets/images/shoes2.png",
                                                      "Women's Air Jordan 1\n Low SE Utility",
                                                      14,
                                                    ),
                                                  ),
                                                  VerticalDivider(
                                                    color: gray,
                                                    thickness: 0.5,
                                                  ),
                                                  SizedBox(
                                                    width: 170,
                                                    // content of the first section
                                                    child: topSellingItems(
                                                      "assets/images/shoes3.png",
                                                      "Women's Air Jordan 1\n Low SE Utility",
                                                      14,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
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
                                                child: Text("Active Items"),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 5),
                                                child: AspectRatio(
                                                  aspectRatio: 10 / 5,
                                                  child: Stack(
                                                    children: [
                                                      DChartPie(
                                                        data: [
                                                          {
                                                            'domain': 'actve',
                                                            'measure': 90
                                                          },
                                                          {
                                                            'domain': 'inactve',
                                                            'measure': 10
                                                          },
                                                        ],
                                                        fillColor:
                                                            (pieData, index) {
                                                          switch (pieData[
                                                              'domain']) {
                                                            case 'actve':
                                                              return orange;
                                                            case 'inactve':
                                                              return gray;
                                                            default:
                                                              return gray;
                                                          }
                                                        },
                                                        pieLabel:
                                                            (pieData, index) {
                                                          return "";
                                                        },
                                                        donutWidth: 30,
                                                        // labelColor:
                                                        //     Colors.white,
                                                      ),
                                                      Align(
                                                          child: Text(
                                                        '90 %',
                                                        style: TextStyle(
                                                            color: orange),
                                                      )),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )),
                                      Column(
                                        children: [
                                          Expanded(
                                            // width: 780,
                                            child: Row(
                                              children: [
                                                Container(
                                                    width: 180,
                                                    height: 80,
                                                    decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: gray,
                                                          width: 0.5),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5.0),
                                                    ),
                                                    child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: const [
                                                          Text(
                                                            "620",
                                                            style: TextStyle(
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              color: orange,
                                                            ),
                                                            textAlign: TextAlign
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
                                                                Icons.person,
                                                                color: black,
                                                              ),
                                                              Text(
                                                                "Customers",
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 15,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  color: black,
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
                                                    decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: gray,
                                                          width: 0.5),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5.0),
                                                    ),
                                                    child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: const [
                                                          Text(
                                                            "20",
                                                            style: TextStyle(
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              color: orange,
                                                            ),
                                                            textAlign: TextAlign
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
                                                                Icons.handshake,
                                                                color: black,
                                                              ),
                                                              Text(
                                                                "Suppliers",
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 15,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  color: black,
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
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Expanded(
                                            child: Container(
                                              // width: 780,
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 10),
                                              height: 126,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: gray, width: 0.5),
                                                borderRadius:
                                                    BorderRadius.circular(5.0),
                                              ),
                                              child: Column(
                                                children: [
                                                  Text(
                                                    "Sale Activity",
                                                    style:
                                                        TextStyle(fontSize: 15),
                                                  ),
                                                  SizedBox(
                                                    height: 8,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Center(
                                                        child: Container(
                                                            width: 160,
                                                            height: 90,
                                                            decoration:
                                                                BoxDecoration(
                                                              border:
                                                                  Border.all(
                                                                      color:
                                                                          gray,
                                                                      width:
                                                                          0.5),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5.0),
                                                            ),
                                                            child: Column(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: const [
                                                                  Text(
                                                                    "20",
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          15,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400,
                                                                      color:
                                                                          orange,
                                                                    ),
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                  ),
                                                                  SizedBox(
                                                                    height: 10,
                                                                  ),
                                                                  Text(
                                                                    "sets",
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .black87,
                                                                        fontSize:
                                                                            10),
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
                                                                ])),
                                                      ),
                                                      SizedBox(
                                                        width: 20,
                                                      ),
                                                      Center(
                                                        child: Container(
                                                            width: 160,
                                                            height: 90,
                                                            decoration:
                                                                BoxDecoration(
                                                              border:
                                                                  Border.all(
                                                                      color:
                                                                          gray,
                                                                      width:
                                                                          0.5),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5.0),
                                                            ),
                                                            child: Column(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: const [
                                                                  Text(
                                                                    "20",
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          15,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400,
                                                                      color:
                                                                          orange,
                                                                    ),
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                  ),
                                                                  SizedBox(
                                                                    height: 10,
                                                                  ),
                                                                  Text(
                                                                    "sets",
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .black87,
                                                                        fontSize:
                                                                            10),
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
                                                                ])),
                                                      ),
                                                      SizedBox(
                                                        width: 20,
                                                      ),
                                                      Center(
                                                        child: Container(
                                                            width: 160,
                                                            height: 90,
                                                            decoration:
                                                                BoxDecoration(
                                                              border:
                                                                  Border.all(
                                                                      color:
                                                                          gray,
                                                                      width:
                                                                          0.5),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5.0),
                                                            ),
                                                            child: Column(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: const [
                                                                  Text(
                                                                    "20",
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          15,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400,
                                                                      color:
                                                                          orange,
                                                                    ),
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                  ),
                                                                  SizedBox(
                                                                    height: 10,
                                                                  ),
                                                                  Text(
                                                                    "sets",
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .black87,
                                                                        fontSize:
                                                                            10),
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
                                                                ])),
                                                      ),
                                                      SizedBox(
                                                        width: 20,
                                                      ),
                                                      Center(
                                                        child: Container(
                                                            width: 160,
                                                            height: 90,
                                                            decoration:
                                                                BoxDecoration(
                                                              border:
                                                                  Border.all(
                                                                      color:
                                                                          gray,
                                                                      width:
                                                                          0.5),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5.0),
                                                            ),
                                                            child: Column(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: const [
                                                                  Text(
                                                                    "20",
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          15,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400,
                                                                      color:
                                                                          orange,
                                                                    ),
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                  ),
                                                                  SizedBox(
                                                                    height: 10,
                                                                  ),
                                                                  Text(
                                                                    "sets",
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .black87,
                                                                        fontSize:
                                                                            10),
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
                                                                ])),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
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
              ),
            ],
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
              style: TextStyle(fontWeight: FontWeight.w400, color: orange),
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
}
