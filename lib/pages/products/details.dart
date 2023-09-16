// ignore_for_file: must_be_immutable, prefer_const_constructors, prefer_interpolation_to_compose_strings

import 'dart:async';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:stock_management/constant.dart';
import 'package:stock_management/load_page.dart';
import 'package:stock_management/widgets/account/account.dart';

class DetailProduct extends StatefulWidget {
  String? id;
  Function back;
  DetailProduct({super.key, this.id, required this.back});

  @override
  State<DetailProduct> createState() => _DetailProductState();
}

class _DetailProductState extends State<DetailProduct> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController refController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController searchController = TextEditingController();
  TextEditingController searchListController = TextEditingController();
  bool load = true;
  bool showList = false;
  bool loadList = false;
  List<Map<String, dynamic>> listSeach = [
    {"id": 12, "name": "Patrick", "price": 2000},
    {"id": 12, "name": "Patrick", "price": 2000},
    {"id": 12, "name": "Patrick", "price": 2000},
    {"id": 12, "name": "Patrick", "price": 2000},
    {"id": 12, "name": "Patrick", "price": 2000},
    {"id": 12, "name": "Patrick", "price": 2000},
    {"id": 12, "name": "Patrick", "price": 2000},
    {"id": 12, "name": "Patrick", "price": 2000},
  ];

  List<Map<String, dynamic>> listLoad = [
    {"id": 12, "name": "Patrick", "price": 2000},
    {"id": 12, "name": "Patrick", "price": 2000},
    {"id": 12, "name": "Patrick", "price": 2000},
    {"id": 12, "name": "Patrick", "price": 2000},
    {"id": 125, "name": "Patrick", "price": 2000},
    {"id": 123, "name": "Patrick", "price": 2000},
    {"id": 126, "name": "Patrick", "price": 2000},
    {"id": 128, "name": "Patrick", "price": 2000},
  ];

  detrmineContainId(int id) {
    for (var i = 0; i < listSeach.length; i++) {
      if (listSeach[i]['id'] == id) {
        return true;
      }
    }

    return false;
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
    dynamic media = MediaQuery.of(context).size;
    double width = media.width;
    double height = media.height;

    return load
        ? LoadPage()
        : Scaffold(
            backgroundColor: gray,
            appBar: AppBar(
              backgroundColor: white,
              elevation: 0,
              leading: InkWell(
                onTap: () {
                  widget.back();
                },
                child: Icon(
                  Icons.arrow_back,
                  color: orange,
                ),
              ),
              title: Text(
                widget.id != null ? product['name'] : "NEW PRODUCT",
                style: TextStyle(color: black),
              ),
            ),
            body: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: [
                      Expanded(
                          child: Center(
                        child: ListView(
                          // mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(
                              child: Container(
                                margin: EdgeInsets.symmetric(
                                    vertical: media.height / 40),
                                width: media.width / 5,
                                height: media.width / 5,
                                child: DottedBorder(
                                  borderType: BorderType.RRect,
                                  color: white,
                                  borderPadding: EdgeInsets.all(6),
                                  dashPattern: [8, 8],
                                  radius: Radius.circular(12),
                                  padding: EdgeInsets.all(6),
                                  child: ClipRRect(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(12)),
                                    child: SizedBox(
                                      height: media.width / 5,
                                      width: media.width / 5,

                                      child: Center(
                                        child: DottedBorder(
                                          borderType: BorderType.RRect,
                                          radius: Radius.circular(12),
                                          padding: EdgeInsets.all(6),
                                          dashPattern: [8, 8],
                                          color: white,
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(12)),
                                            child: SizedBox(
                                              height: media.width / 8,
                                              width: media.width / 8,
                                              child: Center(
                                                child: Icon(
                                                  Icons.add,
                                                  color: white,
                                                ),
                                              ),
                                              // color: Colors.amber,
                                            ),
                                          ),
                                        ),
                                      ),
                                      // color: Colors.amber,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              width: media.width,
                              child: Text(
                                "Description",
                                textAlign: TextAlign.left,
                                textScaleFactor: 1.4,
                                style: TextStyle(
                                  color: white,
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(
                                  vertical: media.height / 40, horizontal: 10),
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(color: white),
                              width: media.width / 3,
                              height: media.width / 4,
                              child: TextField(
                                maxLines: null, // Set this
                                expands: true, // and this
                                keyboardType: TextInputType.multiline,
                              ),
                            )
                          ],
                        ),
                      )),
                      Expanded(
                          child: Center(
                        child: ListView(
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Form(
                              key: _formKey,
                              child: Padding(
                                padding: const EdgeInsets.all(4),
                                child: Center(
                                  child: SizedBox(
                                    width: width / 4,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        label('Product name'),
                                        inputContain(
                                            width,
                                            'Enter the product name',
                                            nameController, (String value) {
                                          setState(() {
                                            nameController.text = value;
                                            user_name = nameController.text;
                                          });
                                        }, false, false),
                                        const SizedBox(height: 20),
                                        label('Reference'),
                                        inputContain(
                                            width,
                                            'Enter the product reference',
                                            refController, (String value) {
                                          setState(() {
                                            refController.text = value;
                                            user_email = refController.text;
                                          });
                                        }, false, false),
                                        const SizedBox(height: 20),
                                        label(' Quantity'),
                                        inputContain(
                                            width,
                                            ' Enter the product quantity',
                                            quantityController, (String value) {
                                          quantityController.text = value;
                                          user_password =
                                              quantityController.text;
                                        }, false, false),
                                        const SizedBox(height: 20),
                                        label(' Unit price'),
                                        inputContain(
                                            width,
                                            ' Enter the unit price',
                                            priceController, (String value) {
                                          setState(() {
                                            priceController.text = value;
                                            user_phone = priceController.text;
                                          });
                                        }, false, false),
                                        const SizedBox(height: 20),
                                        label(' Location'),
                                        inputContain(
                                            width,
                                            ' Enter the product location',
                                            locationController, (String value) {
                                          setState(() {
                                            locationController.text = value;
                                            user_rule = locationController.text;
                                          });
                                        }, false, false),
                                        const SizedBox(height: 20),
                                        Row(
                                          children: [
                                            label(
                                                ' Supplers (${listSeach.length})'),
                                            InkWell(
                                              onTap: () {
                                                setState(() {
                                                  showList = true;
                                                });

                                                Timer(
                                                    Duration(seconds: 5),
                                                    () => setState(() {
                                                          loadList = false;
                                                        }));
                                              },
                                              child: Container(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 5,
                                                    horizontal: 20),
                                                margin:
                                                    EdgeInsets.only(left: 10),
                                                decoration: BoxDecoration(
                                                    color: orange,
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                10))),
                                                child: Text(
                                                  "ADD",
                                                  style: TextStyle(
                                                      color: white,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(top: 10),
                                          width: width,
                                          child: TextField(
                                            controller: searchController,
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
                                        Container(
                                          margin: EdgeInsets.only(top: 10),
                                          width: width,
                                          height: width / 10,
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: white, width: 0.5)),
                                          child: ListView.builder(
                                              itemCount: listSeach.length,
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                if (searchController
                                                        .text.isNotEmpty &&
                                                    !listSeach[index]['name'].toLowerCase()
                                                        .contains(
                                                            searchController
                                                                .text.toLowerCase())) {
                                                  return Container();
                                                } else {
                                                  return ListTile(
                                                      leading: InkWell(
                                                        onTap: () {
                                                          setState(() {
                                                            listSeach.removeAt(
                                                                index);
                                                          });
                                                        },
                                                        child:
                                                            Icon(Icons.remove),
                                                      ),
                                                      trailing: Text(
                                                        '${listSeach[index]['price']} ' +
                                                            company['currency']
                                                                ['symbol'],
                                                        style: TextStyle(
                                                            color: Colors.green,
                                                            fontSize: 15),
                                                      ),
                                                      title: Text(
                                                          listSeach[index]
                                                              ['name']));
                                                }
                                              }),
                                        ),
                                        const SizedBox(height: 20),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 4),
                                          child: SizedBox(
                                            width: width / 4.5,
                                            height: 47,
                                            child: ElevatedButton(
                                              onPressed: () {
                                                if (_formKey.currentState!
                                                    .validate()) {
                                                  // Form is valid, process the data here.
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    const SnackBar(
                                                      content: Text(
                                                          'Form submitted successfully!'),
                                                    ),
                                                  );
                                                  // Navigator.push(
                                                  //     context,
                                                  //     MaterialPageRoute(
                                                  //         builder: (context) =>
                                                  //             const TestPage()));
                                                }
                                              },
                                              style: ElevatedButton.styleFrom(
                                                //<-- SEE HERE
                                                backgroundColor: orange,
                                              ),
                                              child: Text(
                                                widget.id != null
                                                    ? 'Modify'
                                                    : "Add",
                                                style: TextStyle(
                                                    fontSize: 24, color: white),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )),
                    ],
                  ),
                ),
                showList
                    ? InkWell(
                        onTap: () {
                          setState(() {
                            showList = false;
                          });
                        },
                        child: Container(
                          width: width,
                          height: height,
                          color: black.withOpacity(0.6),
                          child: Center(
                            child: Container(
                              padding: EdgeInsets.all(10),
                              width: width / 2,
                              height: width / 2,
                              color: white,
                              child: loadList
                                  ? LoadPage()
                                  : Column(
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(top: 10),
                                          width: width,
                                          child: TextField(
                                            controller: searchListController,
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
                                        Expanded(
                                          child: ListView.builder(
                                              itemCount: listLoad.length,
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                if ((searchListController
                                                            .text.isNotEmpty &&
                                                        !listLoad[index]['name'].toLowerCase()
                                                            .contains(
                                                                searchListController
                                                                    .text.toLowerCase())) ||
                                                    detrmineContainId(
                                                        listLoad[index]
                                                            ['id'])) {
                                                  return Container();
                                                } else {
                                                  return ListTile(
                                                      leading: InkWell(
                                                        onTap: () {
                                                          setState(() {
                                                            listSeach.add(
                                                                listLoad[
                                                                    index]);
                                                          });
                                                        },
                                                        child: Icon(Icons.add),
                                                      ),
                                                      trailing: Text(
                                                        '${listLoad[index]['price']} ' +
                                                            company['currency']
                                                                ['symbol'],
                                                        style: TextStyle(
                                                            color: Colors.green,
                                                            fontSize: 15),
                                                      ),
                                                      title: Text(
                                                          listLoad[index]
                                                              ['name']));
                                                }
                                              }),
                                        )
                                      ],
                                    ),
                            ),
                          ),
                        ),
                      )
                    : Container()
              ],
            ));
  }
}
