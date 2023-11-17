// ignore_for_file: must_be_immutable, prefer_const_constructors, prefer_interpolation_to_compose_strings, sized_box_for_whitespace

import 'dart:io';

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

class DetailLocation extends StatefulWidget {
  String? id;
  Function back;
  Function setParent;
  DetailLocation(
      {super.key, this.id, required this.back, required this.setParent});

  @override
  State<DetailLocation> createState() => _DetailLocationState();
}

class _DetailLocationState extends State<DetailLocation> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  TextEditingController codeController = TextEditingController(text: "Nothing");
  TextEditingController searchController = TextEditingController();
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
    debugPrint(qteList.toString());
    debugPrint(qte.toString());
  }

  detrmineContainId(int id) {
    for (var i = 0; i < productsList.length; i++) {
      if (productsList[i]['id'] == id) {
        return true;
      }
    }

    return false;
  }

  @override
  void initState() {
    productsList = [];
    productsAll = [];

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

    var result = await getLocation();

    if (result == true) {
      nameController.text = location_single['name'] ?? "";
      locationController.text = location_single['location'] ?? "";
      quantityController.text = location_single['quantity'].toString();
      // productsList = ['productsList'];

      for (var i = 0; i < location_single['products'].length; i++) {
        qteList.add(location_single['products'][i]['quantity'].toDouble());
        productsList.add(location_single['products'][i]['product']);
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
                    : "New Location",
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
                                          Row(
                                            children: [
                                              label(
                                                  ' Products (${productsList.length})'),
                                              widget.id != null
                                                  ? Container()
                                                  : InkWell(
                                                      onTap: () async {
                                                        debugPrint("load");
                                                        setState(() {
                                                          showList = true;
                                                          loadList = true;
                                                        });

                                                        var result =
                                                            await getProducts(
                                                                0);
                                                        if (result) {
                                                          loadList = false;
                                                          setState(() {});
                                                        } else {
                                                          showList = false;
                                                          setState(() {});
                                                        }
                                                        debugPrint(productsAll
                                                            .toString());
                                                      },
                                                      child: Container(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                vertical: 5,
                                                                horizontal: 20),
                                                        margin: EdgeInsets.only(
                                                            left: 10),
                                                        decoration: BoxDecoration(
                                                            color: primaryColor,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            10))),
                                                        child: Text(
                                                          "ADD",
                                                          style: TextStyle(
                                                              color: white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
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
                                          Expanded(
                                            child: Container(
                                              margin: EdgeInsets.only(top: 10),
                                              width: width,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: white,
                                                      width: 0.5)),
                                              child: ListView.builder(
                                                  itemCount:
                                                      productsList.length,
                                                  itemBuilder:
                                                      (BuildContext context,
                                                          int index) {
                                                    if (searchController
                                                            .text.isNotEmpty &&
                                                        !productsList[index]
                                                                ['name']
                                                            .toLowerCase()
                                                            .contains(
                                                                searchController
                                                                    .text
                                                                    .toLowerCase())) {
                                                      return Container();
                                                    } else {
                                                      return Column(
                                                        children: [
                                                          ListTile(
                                                              leading: widget
                                                                          .id !=
                                                                      null
                                                                  ? Container()
                                                                  : InkWell(
                                                                      onTap:
                                                                          () {
                                                                        setState(
                                                                            () {
                                                                          qteList
                                                                              .removeAt(index);
                                                                          productsList
                                                                              .removeAt(index);

                                                                          updateQte();
                                                                        });
                                                                      },
                                                                      child:
                                                                          Icon(
                                                                        Icons
                                                                            .remove,
                                                                        color:
                                                                            primaryColor,
                                                                      ),
                                                                    ),
                                                              trailing: Text(
                                                                '${productsList[index]['reference'] ?? ""} ',
                                                                style: TextStyle(
                                                                    color:
                                                                        backgroundColor,
                                                                    fontSize:
                                                                        15),
                                                              ),
                                                              title: Text(
                                                                  productsList[
                                                                          index]
                                                                      [
                                                                      'name'])),
                                                          SizedBox(
                                                            height: 3,
                                                          ),
                                                          Container(
                                                            width: width / 4.5,
                                                            // height: 37,
                                                            margin:
                                                                EdgeInsets.only(
                                                                    right: 10),
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5),
                                                              color: gray,
                                                            ),
                                                            child: Center(
                                                              child:
                                                                  TextFormField(
                                                                maxLines: 1,
                                                                cursorColor:
                                                                    black,
                                                                controller: TextEditingController(
                                                                    text: qteList[
                                                                            index]
                                                                        .toString()),
                                                                keyboardType:
                                                                    TextInputType
                                                                        .number,
                                                                inputFormatters: [
                                                                  FilteringTextInputFormatter
                                                                      .allow(RegExp(
                                                                          '[0-9.]'))
                                                                ],
                                                                onChanged:
                                                                    (value) {
                                                                  if (value
                                                                      .isNotEmpty) {
                                                                    qteList[index] =
                                                                        double.parse(
                                                                            value);
                                                                  } else {
                                                                    qteList[
                                                                        index] = 0;
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
                                                            color: gray,
                                                          )
                                                        ],
                                                      );
                                                    }
                                                  }),
                                            ),
                                          ),
                                          const SizedBox(height: 20),
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
                                                      label('Name'),
                                                      inputContain(
                                                          width,
                                                          'location name',
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
                                                      label('Location'),
                                                      inputContain(
                                                          width,
                                                          'location name',
                                                          locationController,
                                                          (String value) {
                                                        setState(() {
                                                          // locationController
                                                          //     .text = value;
                                                          // user_name =
                                                          //     nameController
                                                          //         .text;
                                                        });
                                                      }, false, false),
                                                      const SizedBox(
                                                          height: 20),
                                                      // label(' Quantity'),
                                                      // inputContain(
                                                      //     width,
                                                      //     'location quantity',
                                                      //     quantityController,
                                                      //     (String value) {
                                                      //   quantityController
                                                      //       .text = value;
                                                      //   user_password =
                                                      //       quantityController
                                                      //           .text;
                                                      // }, false, true,
                                                      //     textInputType:
                                                      //         TextInputType
                                                      //             .number,
                                                      //     isnumber: true),
                                                      // const SizedBox(
                                                      //     height: 20),
                                                      // label(' Code'),
                                                      // inputContain(
                                                      //   width,
                                                      //   'unit quantity',
                                                      //   codeController,
                                                      //   (String value) {
                                                      //     codeController.text =
                                                      //         value;
                                                      //     user_password =
                                                      //         quantityController
                                                      //             .text;
                                                      //   },
                                                      //   false,
                                                      //   false,
                                                      // ),
                                                      const SizedBox(
                                                          height: 20),
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
                                      locationController.text.isNotEmpty)
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
                                                  i < productsList.length;
                                                  i++) {
                                                ProductLovation.add({
                                                  " \"id\"": productsList[i]
                                                      ['id'],
                                                  "\"qte\"": qteList[i]
                                                });
                                              }

                                              Map<String, String> location = {
                                                'name': nameController.text,
                                                'location':
                                                    locationController.text,
                                                // "code": codeController.text,
                                                "products": "$ProductLovation",
                                                "location_id":
                                                    id_location.toString()
                                              };

                                              debugPrint(location.toString());
                                              var result = widget.id == null
                                                  ? await createLocation(
                                                      location,
                                                      imageFile,
                                                      context)
                                                  : await updateLocation(
                                                      location,
                                                      imageFile,
                                                      context);

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
                                                  itemCount: productsAll.length,
                                                  itemBuilder:
                                                      (BuildContext context,
                                                          int index) {
                                                    if ((searchListController
                                                                .text
                                                                .isNotEmpty &&
                                                            !productsAll[index]
                                                                    ['name']
                                                                .toLowerCase()
                                                                .contains(
                                                                    searchListController
                                                                        .text
                                                                        .toLowerCase())) ||
                                                        detrmineContainId(
                                                            productsAll[index]
                                                                ['id'])) {
                                                      return Container();
                                                    } else {
                                                      return ListTile(
                                                          leading: InkWell(
                                                            onTap: () {
                                                              setState(() {
                                                                qteList.add(0);
                                                                productsList.add(
                                                                    productsAll[
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
                                                            '${productsAll[index]['reference']} ',
                                                            style: TextStyle(
                                                                color:
                                                                    backgroundColor,
                                                                fontSize: 15),
                                                          ),
                                                          title: Text(
                                                              productsAll[index]
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
