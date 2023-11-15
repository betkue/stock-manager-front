// ignore_for_file: must_be_immutable, prefer_const_constructors, prefer_interpolation_to_compose_strings, sized_box_for_whitespace

import 'dart:async';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stock_manager/config/constant.dart';
import 'package:stock_manager/config/parameter.dart';
import 'package:stock_manager/config/style.dart';
import 'package:stock_manager/functions/product_function.dart';
import 'package:stock_manager/load_page.dart';
import 'package:stock_manager/pages/no_data.dart';
import 'package:stock_manager/widgets/circular_button.dart';
import 'package:stock_manager/widgets/account/account.dart';
import 'package:permission_handler/permission_handler.dart';

class DetailProduct extends StatefulWidget {
  String? id;
  Function back;
  Function setParent;
  DetailProduct(
      {super.key, this.id, required this.back, required this.setParent});

  @override
  State<DetailProduct> createState() => _DetailProductState();
}

class _DetailProductState extends State<DetailProduct> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController refController = TextEditingController();
  TextEditingController clothingController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  TextEditingController unitController = TextEditingController(text: "Nothing");
  TextEditingController priceController = TextEditingController();
  TextEditingController price2Controller = TextEditingController();
  TextEditingController searchController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController searchListController = TextEditingController();
  ImagePicker picker = ImagePicker();
  bool load = true;
  bool showList = false;
  bool loadList = false;
  bool _pickImage = false;
  String _permission = '';
  List<double> qteList = [];
  List<TextEditingController> qteListController = [];
  dynamic imageFile;
  //gallery permission
  getGalleryPermission() async {
    var status = await Permission.photos.status;
    if (status != PermissionStatus.granted) {
      status = await Permission.photos.request();
    }
    return status;
  }

//camera permission
  getCameraPermission() async {
    var status = await Permission.camera.status;
    if (status != PermissionStatus.granted) {
      status = await Permission.camera.request();
    }
    return status;
  }

//pick image from gallery
  pickImageFromGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        imageFile = pickedFile.path;
        _pickImage = false;
      }

      _pickImage = false;
    });
    // var permission;
    // if (Platform.isMacOS) {
    //   permission = PermissionStatus.granted;
    // } else {
    //   permission = await getCameraPermission();
    // }
    // if (permission == PermissionStatus.granted) {
    //   final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    //   setState(() {
    //     imageFile = pickedFile?.path;
    //     _pickImage = false;
    //   });
    // } else {
    //   setState(() {
    //     _permission = 'noPhotos';
    //   });
    // }
  }

//pick image from camera
  pickImageFromCamera() async {
    var permission;
    if (Platform.isMacOS) {
      permission = PermissionStatus.granted;
    } else {
      permission = await getCameraPermission();
    }
    if (permission == PermissionStatus.granted) {
      final pickedFile = await picker.pickImage(source: ImageSource.camera);
      setState(() {
        imageFile = pickedFile?.path;
        _pickImage = false;
      });
    } else {
      setState(() {
        _permission = 'noCamera';
      });
    }
  }

  updateQte() {
    double qte = 0;

    for (var i = 0; i < qteList.length; i++) {
      qte = qte + qteList[i];
    }

    quantityController.text = qte.toString();
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
    locations = [];
    locationsLoad = [];

    if (widget.id != null) {
      getData();
    } else {
      setState(() {
        load = false;
      });
    }

    super.initState();
  }

  getData() async {
    setState(() {
      load = true;
    });

    var result = await getProduct();

    if (result == true) {
      nameController.text = product_single['name'] ?? "";
      refController.text = product_single['reference'] ?? "";
      quantityController.text = product_single['quantity'].toString();
      unitController.text = product_single['unit'] ?? "";
      priceController.text = product_single['price'].toString();
      price2Controller.text = product_single['purchase_price'].toString();
      descriptionController.text = product_single['description'] ?? "";
      clothingController.text = product_single['clothing'] ?? "No Clothing";
      // locations = ['locations'];

      for (var i = 0; i < product_single['locations'].length; i++) {
        qteList.add(product_single['locations'][i]['quantity'].toDouble());
        locations.add(product_single['locations'][i]['location']);
      }
    }

    setState(() {
      updateQte();
      load = false;
    });
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

                            var result = await deleteProduct();
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
                    ? product_single['name'] ?? ""
                    : "New PRODUCT",
                style: TextStyle(color: black),
              ),
            ),
            body: SafeArea(
              child: Stack(
                children: [
                  widget.id != null && product_single.isEmpty
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
                                      child: ListView(
                                        // mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Center(
                                              child: InkWell(
                                            onTap: () {
                                              setState(() {
                                                pickImageFromGallery();
                                              });
                                            },
                                            child: (product_single['image'] != null &&
                                                    imageFile == null)
                                                ? Container(
                                                    margin: EdgeInsets.symmetric(
                                                        vertical:
                                                            media.height / 40),
                                                    width: media.width / 5,
                                                    height: media.width / 5,
                                                    child: CachedNetworkImage(
                                                      imageUrl: product_single[
                                                          'image'],
                                                      placeholder: (context,
                                                              url) =>
                                                          CircularProgressIndicator(),
                                                      errorWidget: (context,
                                                              url, error) =>
                                                          Icon(Icons.error),
                                                      fit: BoxFit.contain,
                                                    ),
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  12)),
                                                      // image: DecorationImage(
                                                      //     image: NetworkImage(
                                                      //       product_single[
                                                      //           'image'],
                                                      //     ),
                                                      //     fit: BoxFit.cover)
                                                    ))
                                                : (imageFile == null)
                                                    ? Container(
                                                        margin: EdgeInsets
                                                            .symmetric(
                                                                vertical: media
                                                                        .height /
                                                                    40),
                                                        width: media.width / 5,
                                                        height: media.width / 5,
                                                        child: DottedBorder(
                                                          borderType:
                                                              BorderType.RRect,
                                                          color: black,
                                                          borderPadding:
                                                              EdgeInsets.all(6),
                                                          dashPattern: [8, 8],
                                                          radius:
                                                              Radius.circular(
                                                                  12),
                                                          padding:
                                                              EdgeInsets.all(6),
                                                          child: ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            12)),
                                                            child: SizedBox(
                                                              height:
                                                                  media.width /
                                                                      5,
                                                              width:
                                                                  media.width /
                                                                      5,

                                                              child: Center(
                                                                child:
                                                                    DottedBorder(
                                                                  borderType:
                                                                      BorderType
                                                                          .RRect,
                                                                  radius: Radius
                                                                      .circular(
                                                                          12),
                                                                  padding:
                                                                      EdgeInsets
                                                                          .all(
                                                                              6),
                                                                  dashPattern: [
                                                                    8,
                                                                    8
                                                                  ],
                                                                  color: gray,
                                                                  child:
                                                                      ClipRRect(
                                                                    borderRadius:
                                                                        BorderRadius.all(
                                                                            Radius.circular(12)),
                                                                    child:
                                                                        SizedBox(
                                                                      height:
                                                                          media.width /
                                                                              8,
                                                                      width:
                                                                          media.width /
                                                                              8,
                                                                      child:
                                                                          Center(
                                                                        child:
                                                                            Icon(
                                                                          Icons
                                                                              .add,
                                                                          color:
                                                                              primaryColor,
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
                                                      )
                                                    : Container(
                                                        margin: EdgeInsets.symmetric(
                                                            vertical:
                                                                media.height /
                                                                    40),
                                                        width: media.width / 5,
                                                        height: media.width / 5,
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius.all(
                                                                    Radius.circular(
                                                                        12)),
                                                            image: DecorationImage(
                                                                image: FileImage(
                                                                    File(imageFile)),
                                                                fit: BoxFit.cover))),
                                          )),
                                          Container(
                                            width: media.width,
                                            child: Text(
                                              "Description",
                                              textAlign: TextAlign.left,
                                              textScaleFactor: 1.4,
                                              style: TextStyle(
                                                color: gray,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.symmetric(
                                                vertical: media.height / 40,
                                                horizontal: 10),
                                            padding: EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                                color: gray.withOpacity(0.5)),
                                            width: media.width / 3,
                                            height: media.width / 4,
                                            child: TextField(
                                              maxLines: null, // Set this
                                              expands: true, // and this
                                              controller: descriptionController,
                                              keyboardType:
                                                  TextInputType.multiline,
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
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      label('Product name'),
                                                      inputContain(
                                                          width,
                                                          'product name',
                                                          nameController,
                                                          (String value) {
                                                        setState(() {
                                                          // nameController.text =
                                                          //     value;
                                                          // user_name =
                                                          //     nameController
                                                          //         .text;
                                                        });
                                                      }, false, false),
                                                      const SizedBox(
                                                          height: 20),
                                                      label('Clothing'),
                                                      inputContain(
                                                          width,
                                                          'product clothing',
                                                          clothingController,
                                                          (String value) {
                                                        setState(() {
                                                          // refController.text =
                                                          //     value;
                                                          // user_email =
                                                          //     refController
                                                          //         .text;
                                                        });
                                                      }, false, false),
                                                      const SizedBox(
                                                          height: 20),
                                                      label('Reference'),
                                                      inputContain(
                                                          width,
                                                          'product reference',
                                                          refController,
                                                          (String value) {
                                                        setState(() {
                                                          // refController.text =
                                                          //     value;
                                                          // user_email =
                                                          //     refController
                                                          //         .text;
                                                        });
                                                      }, false, false),
                                                      const SizedBox(
                                                          height: 20),
                                                      label(' Quantity'),
                                                      inputContain(
                                                          width,
                                                          'product quantity',
                                                          quantityController,
                                                          (String value) {
                                                        // quantityController
                                                        //     .text = value;
                                                        // user_password =
                                                        //     quantityController
                                                        //         .text;
                                                      }, false, true,
                                                          textInputType:
                                                              TextInputType
                                                                  .number,
                                                          isnumber: true),
                                                      const SizedBox(
                                                          height: 20),
                                                      label(' Unit'),
                                                      inputContain(
                                                        width,
                                                        'unit quantity',
                                                        unitController,
                                                        (String value) {
                                                          // unitController.text =
                                                          //     value;
                                                          // user_password =
                                                          //     quantityController
                                                          //         .text;
                                                        },
                                                        false,
                                                        false,
                                                      ),
                                                      const SizedBox(
                                                          height: 20),
                                                      label(' Selling price'),
                                                      inputContain(
                                                          width,
                                                          'Selling price',
                                                          priceController,
                                                          (String value) {
                                                        setState(() {
                                                          // priceController.text =
                                                          //     value;
                                                          // user_phone =
                                                          //     priceController
                                                          //         .text;
                                                        });
                                                      }, false, false,
                                                          textInputType:
                                                              TextInputType
                                                                  .number,
                                                          isnumber: true),
                                                      const SizedBox(
                                                          height: 20),
                                                      label(' Purchase price'),
                                                      inputContain(
                                                          width,
                                                          'Purchase price',
                                                          price2Controller,
                                                          (String value) {
                                                        setState(() {
                                                          // price2Controller
                                                          //     .text = value;
                                                        });
                                                      }, false, false,
                                                          textInputType:
                                                              TextInputType
                                                                  .number,
                                                          isnumber: true),
                                                      const SizedBox(
                                                          height: 20),
                                                      Row(
                                                        children: [
                                                          label(
                                                              ' Location (${locations.length})'),
                                                          // InkWell(
                                                          //   onTap: () async {
                                                          //     setState(() {
                                                          //       showList = true;
                                                          //       loadList = true;
                                                          //       ;
                                                          //     });

                                                          //     var result =
                                                          //         await getLocations();
                                                          //     if (result) {
                                                          //       loadList =
                                                          //           false;
                                                          //       setState(() {});
                                                          //     } else {
                                                          //       showList =
                                                          //           false;
                                                          //       setState(() {});
                                                          //     }
                                                          //   },
                                                          //   child: Container(
                                                          //     padding: EdgeInsets
                                                          //         .symmetric(
                                                          //             vertical:
                                                          //                 5,
                                                          //             horizontal:
                                                          //                 20),
                                                          //     margin: EdgeInsets
                                                          //         .only(
                                                          //             left: 10),
                                                          //     decoration: BoxDecoration(
                                                          //         color:
                                                          //             primaryColor,
                                                          //         borderRadius:
                                                          //             BorderRadius.all(
                                                          //                 Radius.circular(
                                                          //                     10))),
                                                          //     child: Text(
                                                          //       "ADD",
                                                          //       style: TextStyle(
                                                          //           color:
                                                          //               white,
                                                          //           fontWeight:
                                                          //               FontWeight
                                                          //                   .bold),
                                                          //     ),
                                                          //   ),
                                                          // )
                                                        ],
                                                      ),
                                                      Container(
                                                        margin: EdgeInsets.only(
                                                            top: 10),
                                                        width: width,
                                                        child: TextField(
                                                          controller:
                                                              searchController,
                                                          decoration:
                                                              InputDecoration(
                                                            hintText: "Search",
                                                            prefixIcon: Icon(
                                                                Icons.search),
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
                                                      Container(
                                                        margin: EdgeInsets.only(
                                                            top: 10),
                                                        width: width,
                                                        height: width / 10,
                                                        decoration: BoxDecoration(
                                                            border: Border.all(
                                                                color: white,
                                                                width: 0.5)),
                                                        child: ListView.builder(
                                                            itemCount: locations
                                                                .length,
                                                            itemBuilder:
                                                                (BuildContext
                                                                        context,
                                                                    int index) {
                                                              if (searchController
                                                                      .text
                                                                      .isNotEmpty &&
                                                                  !locations[index]
                                                                          [
                                                                          'name']
                                                                      .toLowerCase()
                                                                      .contains(searchController
                                                                          .text
                                                                          .toLowerCase())) {
                                                                return Container();
                                                              } else {
                                                                return Column(
                                                                  children: [
                                                                    ListTile(
                                                                        leading:
                                                                            InkWell(
                                                                          onTap:
                                                                              () {
                                                                            // setState(() {
                                                                            //   qteList.removeAt(index);
                                                                            //   locations.removeAt(index);

                                                                            //   updateQte();
                                                                            // });
                                                                          },
                                                                          child:
                                                                              Icon(
                                                                            Icons.remove,
                                                                            color:
                                                                                primaryColor,
                                                                          ),
                                                                        ),
                                                                        trailing:
                                                                            Text(
                                                                          '${locations[index]['location']} ',
                                                                          style: TextStyle(
                                                                              color: backgroundColor,
                                                                              fontSize: 15),
                                                                        ),
                                                                        title: Text(locations[index]
                                                                            [
                                                                            'name'])),
                                                                    SizedBox(
                                                                      height: 3,
                                                                    ),
                                                                    Container(
                                                                      width:
                                                                          width /
                                                                              4.5,
                                                                      // height: 37,
                                                                      margin: EdgeInsets.only(
                                                                          right:
                                                                              10),
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        borderRadius:
                                                                            BorderRadius.circular(5),
                                                                        color:
                                                                            gray,
                                                                      ),
                                                                      child:
                                                                          Center(
                                                                        child:
                                                                            TextFormField(
                                                                          maxLines:
                                                                              1,
                                                                          cursorColor:
                                                                              black,
                                                                          controller:
                                                                              TextEditingController(text: qteList[index].toString()),
                                                                          keyboardType:
                                                                              TextInputType.number,
                                                                          inputFormatters: [
                                                                            FilteringTextInputFormatter.allow(RegExp('[0-9.]'))
                                                                          ],
                                                                          onChanged:
                                                                              (value) {
                                                                            if (value.isNotEmpty) {
                                                                              qteList[index] = double.parse(value);
                                                                            } else {
                                                                              qteList[index] = 0;
                                                                            }

                                                                            updateQte();
                                                                          },
                                                                          // maxLength: 30,
                                                                          decoration:
                                                                              inputDecoration(
                                                                            "Enter Qte",
                                                                          ),
                                                                          validator:
                                                                              (value) {
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
                                                                    SizedBox(
                                                                      height: 3,
                                                                    ),
                                                                    Container(
                                                                      width: double
                                                                          .maxFinite,
                                                                      height: 1,
                                                                      color:
                                                                          gray,
                                                                    )
                                                                  ],
                                                                );
                                                              }
                                                            }),
                                                      ),
                                                      const SizedBox(
                                                          height: 100),
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
                              (nameController.text.isNotEmpty &&
                                      refController.text.isNotEmpty &&
                                      locations.isNotEmpty &
                                          priceController.text.isNotEmpty &&
                                      price2Controller.text.isNotEmpty &&
                                      (imageFile != null ||
                                          product_single['image'] != null))
                                  ? Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 4),
                                      child: SizedBox(
                                        width: width / 3,
                                        height: 47,
                                        child: ElevatedButton(
                                          onPressed: () async {
                                            if (_formKey.currentState!
                                                .validate()) {
                                              setState(() {
                                                load = true;
                                              });

                                              var ProductLovation = [];

                                              for (var i = 0;
                                                  i < locations.length;
                                                  i++) {
                                                ProductLovation.add({
                                                  " \"id\"": locations[i]['id'],
                                                  "\"qte\"": qteList[i]
                                                });
                                              }

                                              Map<String, String> product = {
                                                'name': nameController.text,
                                                'reference': refController.text,
                                                "quantity":
                                                    quantityController.text,
                                                "unit": unitController.text,
                                                "selling_price":
                                                    priceController.text,
                                                "clothing":
                                                    clothingController.text,
                                                "purchase_price":
                                                    price2Controller.text,
                                                "is_available": (double.parse(
                                                            quantityController
                                                                .text) >
                                                        0)
                                                    .toString(),
                                                "description":
                                                    descriptionController.text,
                                                "locations": "$ProductLovation",
                                                "product_id":
                                                    id_product.toString()
                                              };

                                              debugPrint(widget.id.toString());
                                              var result = widget.id == null
                                                  ? await createProduct(product,
                                                      imageFile, context)
                                                  : await updateProduct(product,
                                                      imageFile, context);

                                              if (result) {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  const SnackBar(
                                                    content: Text(
                                                        'Form submitted successfully!'),
                                                  ),
                                                );
                                                widget.back();
                                                setState(() {
                                                  load = false;
                                                });
                                              } else {}
                                              setState(() {
                                                load = false;
                                              });
                                            }
                                          },
                                          style: ElevatedButton.styleFrom(
                                            //<-- SEE HERE
                                            backgroundColor: primaryColor,
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
                                                    searchListController,
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
                                                    if ((searchListController
                                                                .text
                                                                .isNotEmpty &&
                                                            !locationsLoad[
                                                                        index]
                                                                    ['name']
                                                                .toLowerCase()
                                                                .contains(
                                                                    searchListController
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
                                                                qteList.add(0);
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
