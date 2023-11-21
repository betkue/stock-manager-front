// ignore_for_file: must_be_immutable, prefer_const_constructors, prefer_interpolation_to_compose_strings, sized_box_for_whitespace

import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stock_manager/config/parameter.dart';
import 'package:stock_manager/config/style.dart';
import 'package:stock_manager/functions/product_function.dart';
import 'package:stock_manager/load_page.dart';
import 'package:stock_manager/pages/no_data.dart';
import 'package:stock_manager/widgets/circular_button.dart';
import 'package:stock_manager/widgets/account/account.dart';
import 'package:permission_handler/permission_handler.dart';

class DetailMovement extends StatefulWidget {
  String? id;
  Function back;
  Function setParent;
  DetailMovement(
      {super.key, this.id, required this.back, required this.setParent});

  @override
  State<DetailMovement> createState() => _DetailMovementState();
}

class _DetailMovementState extends State<DetailMovement> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController searchController = TextEditingController();
  TextEditingController searchListController = TextEditingController();
  TextEditingController searchListProductController = TextEditingController();
  TextEditingController searchListLocationController = TextEditingController();
  TextEditingController comentController = TextEditingController();
  List<TextEditingController> listQteCOntrollers = [];
  ImagePicker picker = ImagePicker();
  bool is_enrty = true;
  bool load = true;
  bool showList = false;
  bool loadList = false;
  List<double> qteList = [];
  List<double> qteList2 = [];
  List<TextEditingController> qteListController = [];
  dynamic imageFile;
  bool show_buttom = false;
  double qte = 0;

  removeProduct() {
    setState(() {
      product_single = {};
      locations = [];
      qteList2 = [];
      qteList = [];
      qteListController = [];
      listQteCOntrollers = [];
    });
    updateQte();
  }

  updateQte() {
    bool edit = false;
    qte = 0;

    for (var i = 0; i < locations.length; i++) {
      if (qteList2[i] > 0) {
        edit = true;
      }

      qte = qte + qteList2[i];
    }

    setState(() {
      show_buttom = edit;
    });
  }

  detrmineContainId(int id) {
    for (var i = 0; i < locations.length; i++) {
      if (locations[i]['id'] == id) {
        return true;
      }
    }

    return false;
  }

  @override
  void initState() {
    productsAll = [];
    locationsLoad = [];
    product_single = {};
    locations = [];
    locationsLoad = [];
    getData();

    super.initState();
  }

  getData() async {
    setState(() {
      load = true;
    });

    // var result =
    await getLocations();
    await getProducts(0);
    setState(() {
      updateQte();
      load = false;
    });
  }

  getSingleProduct(product) async {
    id_product = product['id'].toString();
    qteList2 = [];
    qteList = [];

    setState(() {
      load = true;
    });

    var result = await getProduct();

    if (result) {
      // product_single = product;
      for (var i = 0; i < product_single['locations'].length; i++) {
        qteList.add(product_single['locations'][i]['quantity'].toDouble());
        qteList2.add(0);
        qteListController
            .add(TextEditingController(text: qteList[i].toString()));
        listQteCOntrollers
            .add(TextEditingController(text: qteList2[i].toString()));
        locations.add(product_single['locations'][i]['location']);
      }
      comentController.text = product_single['coment'] ?? "";
      debugPrint("qts list" + qteList.toString());
      debugPrint("qte lis 2" + qteList2.toString());

      setState(() {
        load = false;
        id_product = null;
      });
    } else {
      setState(() {
        load = false;
        id_product = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    dynamic media = MediaQuery.of(context).size;
    double width = media.width;
    double height = media.height;

    return load
        ? LoadPage()
        : Scaffold(
            // backgroundColor: gray,
            appBar: AppBar(
              actions: widget.id != null
                  ? [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          onPressed: () async {
                            setState(() {
                              load = true;
                            });

                            var result = await deleteLocation();
                            setState(() {
                              load = false;
                            });
                            if (result) {
                              widget.back();
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: red,
                            shadowColor: primaryColor,
                            surfaceTintColor: primaryColor,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 10), // Set the button's padding
                          ),
                          child: const Text(
                            "Delete",
                            style: TextStyle(
                                fontSize: 16,
                                color: white,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ),
                    ]
                  : [],
              backgroundColor: white,
              elevation: 0,
              leading: InkWell(
                onTap: () {
                  widget.back();
                },
                child: Icon(
                  Icons.arrow_back,
                  color: primaryColor,
                ),
              ),
              title: Text(
                widget.id != null
                    ? location_single['name'] ?? ""
                    : "New Movement",
                style: TextStyle(color: black),
              ),
            ),
            body: SafeArea(
              child: Stack(
                children: [
                  widget.id != null && location_single.isEmpty
                      ? NoData(onTap: () async {
                          await getData();
                        })
                      : Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Row(
                                  children: [
                                    Expanded(
                                        child: Center(
                                      child: Column(
                                        // mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          product_single.isNotEmpty
                                              ? CirularButton(
                                                  onClick: () {
                                                    setState(() {
                                                      removeProduct();
                                                    });
                                                  },
                                                )
                                              : Row(
                                                  children: [
                                                    label(
                                                        ' Products (${productsAll.length})'),
                                                    // InkWell(
                                                    //   onTap: () async {
                                                    //     debugPrint("load");
                                                    //     setState(() {
                                                    //       showList = true;
                                                    //       loadList = true;
                                                    //     });

                                                    //     var result =
                                                    //         await getProducts(0);
                                                    //     if (result) {
                                                    //       loadList = false;
                                                    //       setState(() {});
                                                    //     } else {
                                                    //       showList = false;
                                                    //       setState(() {});
                                                    //     }
                                                    //     debugPrint(
                                                    //         productsAll.toString());
                                                    //   },
                                                    //   child: Container(
                                                    //     padding: EdgeInsets.symmetric(
                                                    //         vertical: 5,
                                                    //         horizontal: 20),
                                                    //     margin:
                                                    //         EdgeInsets.only(left: 10),
                                                    //     decoration: BoxDecoration(
                                                    //         color: primaryColor,
                                                    //         borderRadius:
                                                    //             BorderRadius.all(
                                                    //                 Radius.circular(
                                                    //                     10))),
                                                    //     child: Text(
                                                    //       "ADD",
                                                    //       style: TextStyle(
                                                    //           color: white,
                                                    //           fontWeight:
                                                    //               FontWeight.bold),
                                                    //     ),
                                                    //   ),
                                                    // )
                                                  ],
                                                ),
                                          product_single.isNotEmpty
                                              ? Container()
                                              : Container(
                                                  margin:
                                                      EdgeInsets.only(top: 10),
                                                  width: width,
                                                  child: TextField(
                                                    controller:
                                                        searchController,
                                                    decoration: InputDecoration(
                                                      hintText: "Search",
                                                      prefixIcon:
                                                          Icon(Icons.search),
                                                      border:
                                                          OutlineInputBorder(),
                                                    ),
                                                    onChanged: (value) {
                                                      setState(() {
                                                        // searchProductsController.text = value;
                                                      });
                                                    },
                                                  ),
                                                ),
                                          Expanded(
                                            child: SingleChildScrollView(
                                              child: Container(
                                                margin: EdgeInsets.only(top: 10),
                                                width: width,
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: white,
                                                        width: 0.5)),
                                                child: product_single.isEmpty
                                                    ? ListView.builder(
                                                        itemCount:
                                                            productsAll.length,
                                                        itemBuilder:
                                                            (BuildContext context,
                                                                int index) {
                                                          if (searchController
                                                                  .text
                                                                  .isNotEmpty &&
                                                              !productsAll[index]
                                                                      ['name']
                                                                  .toLowerCase()
                                                                  .contains(
                                                                      searchController
                                                                          .text
                                                                          .toLowerCase())) {
                                                            return Container();
                                                          } else {
                                                            return InkWell(
                                                              onTap: () {
                                                                setState(() {
                                                                  getSingleProduct(
                                                                      productsAll[
                                                                          index]);
                                                                });
                                                              },
                                                              child: Column(
                                                                children: [
                                                                  ListTile(
                                                                      leading:
                                                                          Icon(
                                                                        Icons
                                                                            .remove,
                                                                        color:
                                                                            primaryColor,
                                                                      ),
                                                                      trailing:
                                                                          Text(
                                                                        '${productsAll[index]['reference'] ?? ""} ',
                                                                        style: TextStyle(
                                                                            color:
                                                                                backgroundColor,
                                                                            fontSize:
                                                                                15),
                                                                      ),
                                                                      title: Text(
                                                                          productsAll[index]
                                                                              [
                                                                              'name'])),
                                                                  SizedBox(
                                                                    height: 3,
                                                                  ),
                                                                  SizedBox(
                                                                    height: 3,
                                                                  ),
                                                                  Container(
                                                                    width: double
                                                                        .maxFinite,
                                                                    height: 1,
                                                                    color: gray,
                                                                  )
                                                                ],
                                                              ),
                                                            );
                                                          }
                                                        })
                                                    : ListView(
                                                        children: [
                                                          Container(
                                                              margin: EdgeInsets.symmetric(
                                                                  vertical: media
                                                                          .height /
                                                                      40),
                                                              width: media.width /
                                                                  20,
                                                              height:
                                                                  media.width /
                                                                      20,
                                                              child:
                                                                  CachedNetworkImage(
                                                                imageUrl:
                                                                    product_single[
                                                                        'image'],
                                                                placeholder: (context,
                                                                        url) =>
                                                                    CircularProgressIndicator(),
                                                                errorWidget: (context,
                                                                        url,
                                                                        error) =>
                                                                    Icon(Icons
                                                                        .error),
                                                                fit: BoxFit
                                                                    .contain,
                                                              ),
                                                              decoration:
                                                                  BoxDecoration(
                                                                borderRadius: BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            12)),
                                                                // image: DecorationImage(
                                                                //     image: NetworkImage(
                                                                //       product_single[
                                                                //           'image'],
                                                                //     ),
                                                                //     fit: BoxFit.cover)
                                                              )),
                                                          const SizedBox(
                                                              height: 20),
                                                          label('Product name'),
                                                          inputContain(
                                                              width,
                                                              'product name',
                                                              TextEditingController(
                                                                  text:
                                                                      product_single[
                                                                          'name']),
                                                              (String value) {
                                                            setState(() {
                                                              // nameController.text =
                                                              //     value;
                                                              // user_name =
                                                              //     nameController
                                                              //         .text;
                                                            });
                                                          }, false, true),
                                                          const SizedBox(
                                                              height: 20),
                                                          label(
                                                              'Product reference'),
                                                          inputContain(
                                                              width,
                                                              'product reference',
                                                              TextEditingController(
                                                                  text: product_single[
                                                                      'reference']),
                                                              (String value) {
                                                            setState(() {
                                                              // nameController.text =
                                                              //     value;
                                                              // user_name =
                                                              //     nameController
                                                              //         .text;
                                                            });
                                                          }, false, true),
                                                          const SizedBox(
                                                              height: 20),
                                                          label(
                                                              'Product quantity'),
                                                          inputContain(
                                                              width,
                                                              'product quantity',
                                                              TextEditingController(
                                                                  text: product_single[
                                                                          'quantity']
                                                                      .toString()),
                                                              (String value) {
                                                            setState(() {
                                                              // nameController.text =
                                                              //     value;
                                                              // user_name =
                                                              //     nameController
                                                              //         .text;
                                                            });
                                                          }, false, true),
                                                          const SizedBox(
                                                              height: 20),
                                                          product_single.isEmpty
                                                              ? Container()
                                                              : Column(
                                                                  children: [
                                                                    Row(
                                                                      children: [
                                                                        Column(
                                                                          children: [
                                                                            label(
                                                                                "Entry"),
                                                                            Checkbox(
                                                                              tristate:
                                                                                  true,
                                                                              value:
                                                                                  is_enrty,
                                                                              onChanged:
                                                                                  (bool? value) {
                                                                                setState(() {
                                                                                  is_enrty = value!;
                                                                                });
                                                                              },
                                                                            ),
                                                                          ],
                                                                        ),
                                                                        const SizedBox(
                                                                            width:
                                                                                20),
                                                                        Column(
                                                                          children: [
                                                                            label(
                                                                                "Exit"),
                                                                            Checkbox(
                                                                              isError:
                                                                                  true,
                                                                              tristate:
                                                                                  true,
                                                                              value:
                                                                                  !is_enrty,
                                                                              onChanged:
                                                                                  (bool? value) {
                                                                                setState(() {
                                                                                  is_enrty = !value!;
                                                                                });
                                                                              },
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ],
                                                                    )
                                                                  ],
                                                                ),
                                                          const SizedBox(
                                                              height: 20),
                                                          product_single.isEmpty
                                                              ? Container()
                                                              : Column(
                                                                  children: [
                                                                    Container(
                                                                      width: media
                                                                          .width,
                                                                      child: Text(
                                                                        "Coment",
                                                                        textAlign:
                                                                            TextAlign
                                                                                .left,
                                                                        textScaleFactor:
                                                                            1.4,
                                                                        style:
                                                                            TextStyle(
                                                                          color:
                                                                              gray,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Container(
                                                                      margin: EdgeInsets.symmetric(
                                                                          vertical:
                                                                              media.height /
                                                                                  40,
                                                                          horizontal:
                                                                              10),
                                                                      padding:
                                                                          EdgeInsets.all(
                                                                              10),
                                                                      decoration:
                                                                          BoxDecoration(
                                                                              color:
                                                                                  gray.withOpacity(0.5)),
                                                                      width: media
                                                                              .width /
                                                                          3,
                                                                      height:
                                                                          media.width /
                                                                              4,
                                                                      child:
                                                                          TextField(
                                                                        maxLines:
                                                                            null, // Set this
                                                                        expands:
                                                                            true, // and this
                                                                        controller:
                                                                            comentController,
                                                                        keyboardType:
                                                                            TextInputType
                                                                                .multiline,
                                                                      ),
                                                                    )
                                                                  ],
                                                                ),
                                                        ],
                                                      ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )),
                                    Spacer(),
                                    Expanded(
                                        child: Center(
                                      child: product_single.isEmpty
                                          ? Container()
                                          : Column(
                                              children: [
                                                Row(
                                                  children: [
                                                    label(
                                                        ' Location (${locations.length})'),
                                                    widget.id != null
                                                        ? Container()
                                                        : InkWell(
                                                            onTap: () async {
                                                              setState(() {
                                                                showList = true;
                                                                loadList = true;
                                                                ;
                                                              });

                                                              var result =
                                                                  await getLocations();
                                                              if (result) {
                                                                loadList =
                                                                    false;
                                                                setState(() {});
                                                              } else {
                                                                showList =
                                                                    false;
                                                                setState(() {});
                                                              }
                                                            },
                                                            child: Container(
                                                              padding: EdgeInsets
                                                                  .symmetric(
                                                                      vertical:
                                                                          5,
                                                                      horizontal:
                                                                          20),
                                                              margin: EdgeInsets
                                                                  .only(
                                                                      left: 10),
                                                              decoration: BoxDecoration(
                                                                  color:
                                                                      primaryColor,
                                                                  borderRadius:
                                                                      BorderRadius.all(
                                                                          Radius.circular(
                                                                              10))),
                                                              child: Text(
                                                                "ADD",
                                                                style: TextStyle(
                                                                    color:
                                                                        white,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                            ),
                                                          )
                                                  ],
                                                ),
                                                Container(
                                                  margin:
                                                      EdgeInsets.only(top: 10),
                                                  width: width,
                                                  child: TextField(
                                                    controller:
                                                        searchListLocationController,
                                                    decoration: InputDecoration(
                                                      hintText: "Search",
                                                      prefixIcon:
                                                          Icon(Icons.search),
                                                      border:
                                                          OutlineInputBorder(),
                                                    ),
                                                    onChanged: (value) {
                                                      setState(() {
                                                        // searchProductsController.text = value;
                                                      });
                                                    },
                                                  ),
                                                ),
                                                product_single.isEmpty
                                                    ? Container()
                                                    : Expanded(
                                                        child: Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                                  top: 10),
                                                          width: width,
                                                          decoration: BoxDecoration(
                                                              border:
                                                                  Border.all(
                                                                      color:
                                                                          white,
                                                                      width:
                                                                          0.5)),
                                                          child:
                                                              ListView.builder(
                                                                  itemCount:
                                                                      locations
                                                                          .length,
                                                                  itemBuilder:
                                                                      (BuildContext
                                                                              context,
                                                                          int index) {
                                                                    debugPrint(
                                                                        "qts list" +
                                                                            qteList.toString());
                                                                    debugPrint("qte lis 2" +
                                                                        qteList2
                                                                            .toString());
                                                                    debugPrint(
                                                                        "contain : $index = ${(qteList.length - 1) >= index}");
                                                                    if (searchListLocationController
                                                                            .text
                                                                            .isNotEmpty &&
                                                                        !locations[index]['name']
                                                                            .toLowerCase()
                                                                            .contains(searchListLocationController.text.toLowerCase())) {
                                                                      return Container();
                                                                    } else {
                                                                      return Column(
                                                                        children: [
                                                                          ListTile(
                                                                              leading: ((qteList.length - 1) >= index)
                                                                                  ? null
                                                                                  : InkWell(
                                                                                      onTap: () {
                                                                                        setState(() {
                                                                                          qteList2.removeAt(index);
                                                                                          locations.removeAt(index);

                                                                                          updateQte();
                                                                                        });
                                                                                      },
                                                                                      child: Icon(
                                                                                        Icons.remove,
                                                                                        color: primaryColor,
                                                                                      ),
                                                                                    ),
                                                                              trailing: Text(
                                                                                '${locations[index]['location']} ',
                                                                                style: TextStyle(color: backgroundColor, fontSize: 15),
                                                                              ),
                                                                              title: Text(locations[index]['name'])),
                                                                          SizedBox(
                                                                            height:
                                                                                3,
                                                                          ),
                                                                          Row(
                                                                            children: [
                                                                              !((qteList.length - 1) >= index)
                                                                                  ? Container()
                                                                                  : Expanded(
                                                                                      child: Container(
                                                                                        width: width / 4.5,
                                                                                        // height: 37,
                                                                                        margin: EdgeInsets.only(right: 10),
                                                                                        decoration: BoxDecoration(
                                                                                          borderRadius: BorderRadius.circular(5),
                                                                                          color: gray,
                                                                                        ),
                                                                                        child: Center(
                                                                                          child: TextFormField(
                                                                                            maxLines: 1,
                                                                                            cursorColor: black,
                                                                                            controller: qteListController[index],
                                                                                            keyboardType: TextInputType.number,
                                                                                            enabled: false,
                                                                                            inputFormatters: [
                                                                                              FilteringTextInputFormatter.allow(RegExp('[0-9.]'))
                                                                                            ],
                                                                                            onChanged: (value) {
                                                                                              // if (value.isNotEmpty) {
                                                                                              //   qteList[index] = double.parse(value);
                                                                                              // } else {
                                                                                              //   qteList[index] = 0;
                                                                                              // }

                                                                                              // updateQte();
                                                                                            },
                                                                                            // maxLength: 30,
                                                                                            decoration: inputDecoration(
                                                                                              "Enter Qte",
                                                                                            ),
                                                                                            validator: (value) {
                                                                                              // if (value!
                                                                                              //         .isEmpty &&
                                                                                              //     !obscure) {
                                                                                              //   return 'Please enter the $hintText.';
                                                                                              // }
                                                                                              // return null;
                                                                                            },
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                              !((qteList.length - 1) >= index) ? Container() : Spacer(),
                                                                              Center(
                                                                                child: Text(is_enrty ? "Add" : "Remove"),
                                                                              ),
                                                                              Spacer(),
                                                                              Expanded(
                                                                                child: Container(
                                                                                  width: width / 4.5,
                                                                                  // height: 37,
                                                                                  margin: EdgeInsets.only(right: 10),
                                                                                  decoration: BoxDecoration(
                                                                                    borderRadius: BorderRadius.circular(5),
                                                                                    color: gray,
                                                                                  ),
                                                                                  child: Center(
                                                                                    child: TextFormField(
                                                                                      maxLines: 1,
                                                                                      cursorColor: black,
                                                                                      controller: listQteCOntrollers[index],
                                                                                      keyboardType: TextInputType.number,
                                                                                      inputFormatters: [
                                                                                        FilteringTextInputFormatter.allow(RegExp('[0-9.]'))
                                                                                      ],
                                                                                      onChanged: (value) {
                                                                                        if (value.isNotEmpty) {
                                                                                          if (is_enrty) {
                                                                                            setState(() {
                                                                                              qteList2[index] = double.parse(value);
                                                                                            });
                                                                                          } else if (double.parse(value) > qteList[index]) {
                                                                                            setState(() {
                                                                                              qteList2[index] = 0;
                                                                                              listQteCOntrollers[index].text = "0";
                                                                                            });
                                                                                          } else {
                                                                                            setState(() {
                                                                                              qteList2[index] = double.parse(value);
                                                                                            });
                                                                                          }
                                                                                        } else {
                                                                                          setState(() {
                                                                                            qteList2[index] = 0;
                                                                                          });
                                                                                        }

                                                                                        updateQte();
                                                                                      },
                                                                                      // maxLength: 30,
                                                                                      decoration: inputDecoration(
                                                                                        "Enter Qte",
                                                                                      ),
                                                                                      validator: (value) {
                                                                                        // if (value!
                                                                                        //         .isEmpty &&
                                                                                        //     !obscure) {
                                                                                        //   return 'Please enter the $hintText.';
                                                                                        // }
                                                                                        // return null;
                                                                                      },
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              )
                                                                            ],
                                                                          ),
                                                                          SizedBox(
                                                                            height:
                                                                                3,
                                                                          ),
                                                                          Container(
                                                                            width:
                                                                                double.maxFinite,
                                                                            height:
                                                                                1,
                                                                            color:
                                                                                gray,
                                                                          )
                                                                        ],
                                                                      );
                                                                    }
                                                                  }),
                                                        ),
                                                      ),
                                                const SizedBox(height: 100),
                                              ],
                                            ),
                                    )),
                                  ],
                                ),
                              ),
                              (show_buttom)
                                  ? Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 4),
                                      child: SizedBox(
                                        width: width / 3,
                                        height: 47,
                                        child: ElevatedButton(
                                          onPressed: () async {
                                            setState(() {
                                              load = true;
                                            });

                                            var ProductLovation = [];

                                            for (var i = 0;
                                                i < locations.length;
                                                i++) {
                                              if (qteList2[i] > 0) {
                                                ProductLovation.add({
                                                  " \"id\"": locations[i]['id'],
                                                  "\"qte\"": qteList2[i]
                                                });
                                              }
                                            }

                                            Map<String, String> location = {
                                              // 'name': nameController.text,
                                              // 'location':
                                              //     locationController.text,
                                              // // "code": codeController.text,
                                              "is_entry": "${is_enrty ? 1 : 0}",
                                              "quantity": "$qte",
                                              "coment": comentController.text,
                                              "locations": "$ProductLovation",
                                              "product_id": product_single['id']
                                                  .toString()
                                            };

                                            debugPrint(location.toString());
                                            var result = widget.id == null
                                                ? await createMovement(location,
                                                    imageFile, context)
                                                : await updateMovement(location,
                                                    imageFile, context);

                                            if (result) {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                const SnackBar(
                                                  content: Text(
                                                      'Form submitted successfully!'),
                                                ),
                                              );
                                              removeProduct();

                                              setState(() {
                                                load = false;
                                              });
                                            } else {}
                                            setState(() {
                                              load = false;
                                            });
                                          },
                                          style: ElevatedButton.styleFrom(
                                            //<-- SEE HERE
                                            backgroundColor: primaryColor,
                                          ),
                                          child: Text(
                                            // widget.id != null
                                            //     ? 'Modify'
                                            //     :
                                            "Add",
                                            style: TextStyle(
                                                fontSize: 24, color: white),
                                          ),
                                        ),
                                      ),
                                    )
                                  : Container(),
                            ],
                          ),
                        ),
                  showList
                      ? Container(
                          width: width,
                          height: height,
                          color: black.withOpacity(0.6),
                          child: Stack(
                            children: [
                              Positioned(
                                  right: 30,
                                  top: 10,
                                  child: CirularButton(
                                    onClick: () {
                                      setState(() {
                                        showList = false;
                                      });
                                    },
                                  )),
                              Center(
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
                                                controller:
                                                    searchListProductController,
                                                decoration: InputDecoration(
                                                  hintText: "Search",
                                                  prefixIcon:
                                                      Icon(Icons.search),
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
                                                  itemCount:
                                                      locationsLoad.length,
                                                  itemBuilder:
                                                      (BuildContext context,
                                                          int index) {
                                                    if ((searchListProductController
                                                                .text
                                                                .isNotEmpty &&
                                                            !locationsLoad[
                                                                        index]
                                                                    ['name']
                                                                .toLowerCase()
                                                                .contains(
                                                                    searchListProductController
                                                                        .text
                                                                        .toLowerCase())) ||
                                                        detrmineContainId(
                                                            locationsLoad[index]
                                                                ['id'])) {
                                                      return Container();
                                                    } else {
                                                      return ListTile(
                                                          leading: InkWell(
                                                            onTap: () {
                                                              setState(() {
                                                                qteList2.add(0);

                                                                listQteCOntrollers.add(
                                                                    TextEditingController(
                                                                        text:
                                                                            "0"));
                                                                locations.add(
                                                                    locationsLoad[
                                                                        index]);

                                                                updateQte();
                                                              });
                                                            },
                                                            child: Icon(
                                                                Icons.add,
                                                                color:
                                                                    primaryColor),
                                                          ),
                                                          trailing: Text(
                                                            '${locationsLoad[index]['location']} ',
                                                            style: TextStyle(
                                                                color:
                                                                    backgroundColor,
                                                                fontSize: 15),
                                                          ),
                                                          title: Text(
                                                              locationsLoad[
                                                                      index]
                                                                  ['name']));
                                                    }
                                                  }),
                                            )
                                          ],
                                        ),
                                ),
                              ),
                            ],
                          ),
                        )
                      : Container(),
                ],
              ),
            ));
  }
}
