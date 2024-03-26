// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:stock_manager/config/constant.dart';
import 'package:stock_manager/config/parameter.dart';
import 'package:stock_manager/config/style.dart';
import 'package:stock_manager/functions/customer_function.dart';
import 'package:stock_manager/load_page.dart';
import 'package:stock_manager/pages/customers/details.dart';
import 'package:stock_manager/widgets/customer/customer.dart';
import 'package:stock_manager/widgets/help_button.dart';

class CustomerPage extends StatefulWidget {
  const CustomerPage({super.key});

  @override
  State<CustomerPage> createState() => _CustomerPageState();
}

class _CustomerPageState extends State<CustomerPage> {
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

    await getCustomers();

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
                        ? DetailCustomer(
                            id: id_customer,
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
                                        controller: searchCustomersController,
                                        decoration: InputDecoration(
                                          hintText: "Search",
                                          prefixIcon: Icon(Icons.search),
                                          border: OutlineInputBorder(),
                                        ),
                                        onChanged: (value) {
                                          setState(() {
                                            // searchCustomersController.text = value;
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 18),
                                  ElevatedButton(
                                    onPressed: () {
                                      setState(() {
                                        id_customer = null;
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
                                      "Add Customer",
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            body: ListView.builder(
                              itemCount: customers.length,
                              itemBuilder: (context, index) {
                                return customer(
                                  customers[index]['id'].toString(),
                                  customers[index]['name'],
                                  customers[index]['sigle'] ?? "",
                                  customers[index]['location'],
                                  customers[index]['logo'] ??
                                      'https://picsum.photos/200/300',
                                  customers[index]['reference'],
                                  context,
                                  () {
                                    details = true;
                                    setStatePage();
                                  },
                                );
                              },
                            ))),
              ],
            )),
          );
  }

  // Widget buildItemContainer(int index, BuildContext context) {
  //   return Container(
  //     color: Colors.white,
  //     child: Container(
  //       margin: const EdgeInsets.all(8.0),
  //       padding: const EdgeInsets.all(8.0),
  //       decoration: BoxDecoration(
  //         color: Colors.white,
  //         boxShadow: [
  //           BoxShadow(
  //             color: Colors.grey.withOpacity(0.5),
  //             spreadRadius: 2,
  //             blurRadius: 5,
  //             offset: const Offset(0, 3),
  //           ),
  //         ],
  //       ),
  //       child: Row(
  //         children: [
  //           Container(
  //             height: 100,
  //             width: 100,
  //             decoration: BoxDecoration(
  //               image: DecorationImage(
  //                   image: NetworkImage(customers[index]['image'])),
  //               color: primaryColor,
  //               borderRadius:
  //                   BorderRadius.circular(MediaQuery.of(context).size.height),
  //               // color: widget.color ?? orange,
  //             ),
  //             // child: Image.network(
  //             //  ,
  //             //   // fit: BoxFit.cover,
  //             // )
  //           ),
  //           const SizedBox(width: 30),
  //           Expanded(child: Text(customers[index]['name'])),
  //           Expanded(child: Text("${customers[index]['reference']} $index")),
  //           Expanded(
  //               child:
  //                   Text("Quantity : ${customers[index]['product_quantity']}")),
  //           Expanded(child: Text("Location : ${customers[index]['location']}")),
  //           Expanded(
  //             child: IconButton(
  //               onPressed: () {},
  //               icon: const Icon(
  //                 Icons.edit_outlined,
  //                 color: Colors.orange,
  //               ),
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }
}
