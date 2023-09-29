// ignore_for_file: must_be_immutable, prefer_const_constructors, prefer_interpolation_to_compose_strings, sized_box_for_whitespace

import 'dart:async';
import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stock_manager/constant.dart';
import 'package:stock_manager/load_page.dart';
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
  TextEditingController quantityController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController searchController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController searchListController = TextEditingController();
  ImagePicker picker = ImagePicker();
  bool load = true;
  bool showList = false;
  bool loadList = false;
  bool _pickImage = false;
  String _permission = '';
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

  List<Map<String, dynamic>> listSeach = [];

  List<Map<String, dynamic>> listLoad = [
    // {"id": 128, "name": "Patrick", "price": 2000},
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
    if (widget.id != null) {
      nameController.text = product_single['name'] ?? "";
      refController.text = product_single['reference'] ?? "";
      quantityController.text = product_single['quantity'] ?? "";
      priceController.text = product_single['price'] ?? "";
      locationController.text = product_single['location'] ?? "";
      descriptionController.text = product_single['description'] ?? "";
      listSeach = [
        {"id": 12, "name": "Patrick", "price": 2000},
        {"id": 12, "name": "Patrick", "price": 2000},
        {"id": 12, "name": "Patrick", "price": 2000},
        {"id": 12, "name": "Patrick", "price": 2000},
        {"id": 12, "name": "Patrick", "price": 2000},
        {"id": 12, "name": "Patrick", "price": 2000},
        {"id": 12, "name": "Patrick", "price": 2000},
        {"id": 12, "name": "Patrick", "price": 2000},
      ];
    }
    Timer(
        Duration(seconds: timedalay),
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
            // backgroundColor: gray,
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
                widget.id != null
                    ? product_single['name'] ?? ""
                    : "New PRODUCT",
                style: TextStyle(color: black),
              ),
            ),
            body: SafeArea(
              child: Stack(
                children: [
                  Padding(
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
                                                  vertical: media.height / 40),
                                              width: media.width / 5,
                                              height: media.width / 5,
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.all(
                                                      Radius.circular(12)),
                                                  image: DecorationImage(
                                                      image: NetworkImage(
                                                        product_single['image'],
                                                      ),
                                                      fit: BoxFit.cover)))
                                          : (imageFile == null)
                                              ? Container(
                                                  margin: EdgeInsets.symmetric(
                                                      vertical:
                                                          media.height / 40),
                                                  width: media.width / 5,
                                                  height: media.width / 5,
                                                  child: DottedBorder(
                                                    borderType:
                                                        BorderType.RRect,
                                                    color: black,
                                                    borderPadding:
                                                        EdgeInsets.all(6),
                                                    dashPattern: [8, 8],
                                                    radius: Radius.circular(12),
                                                    padding: EdgeInsets.all(6),
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  12)),
                                                      child: SizedBox(
                                                        height: media.width / 5,
                                                        width: media.width / 5,

                                                        child: Center(
                                                          child: DottedBorder(
                                                            borderType:
                                                                BorderType
                                                                    .RRect,
                                                            radius:
                                                                Radius.circular(
                                                                    12),
                                                            padding:
                                                                EdgeInsets.all(
                                                                    6),
                                                            dashPattern: [8, 8],
                                                            color: gray,
                                                            child: ClipRRect(
                                                              borderRadius: BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          12)),
                                                              child: SizedBox(
                                                                height: media
                                                                        .width /
                                                                    8,
                                                                width: media
                                                                        .width /
                                                                    8,
                                                                child: Center(
                                                                  child: Icon(
                                                                    Icons.add,
                                                                    color:
                                                                        orange,
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
                                                          media.height / 40),
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
                                                    'product name',
                                                    nameController,
                                                    (String value) {
                                                  setState(() {
                                                    nameController.text = value;
                                                    user_name =
                                                        nameController.text;
                                                  });
                                                }, false, false),
                                                const SizedBox(height: 20),
                                                label('Reference'),
                                                inputContain(
                                                    width,
                                                    'product reference',
                                                    refController,
                                                    (String value) {
                                                  setState(() {
                                                    refController.text = value;
                                                    user_email =
                                                        refController.text;
                                                  });
                                                }, false, false),
                                                const SizedBox(height: 20),
                                                label(' Quantity'),
                                                inputContain(
                                                    width,
                                                    'product quantity',
                                                    quantityController,
                                                    (String value) {
                                                  quantityController.text =
                                                      value;
                                                  user_password =
                                                      quantityController.text;
                                                }, false, false,
                                                    textInputType:
                                                        TextInputType.number),
                                                const SizedBox(height: 20),
                                                label(' Unit price'),
                                                inputContain(
                                                    width,
                                                    'unit price',
                                                    priceController,
                                                    (String value) {
                                                  setState(() {
                                                    priceController.text =
                                                        value;
                                                    user_phone =
                                                        priceController.text;
                                                  });
                                                }, false, false,
                                                    textInputType:
                                                        TextInputType.number),
                                                const SizedBox(height: 20),
                                                label(' Location'),
                                                inputContain(
                                                    width,
                                                    'product location',
                                                    locationController,
                                                    (String value) {
                                                  setState(() {
                                                    locationController.text =
                                                        value;
                                                    user_rule =
                                                        locationController.text;
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
                                                            Duration(
                                                                seconds: 5),
                                                            () => setState(() {
                                                                  loadList =
                                                                      false;
                                                                }));
                                                      },
                                                      child: Container(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                vertical: 5,
                                                                horizontal: 20),
                                                        margin: EdgeInsets.only(
                                                            left: 10),
                                                        decoration: BoxDecoration(
                                                            color: orange,
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
                                                Container(
                                                  margin:
                                                      EdgeInsets.only(top: 10),
                                                  width: width,
                                                  height: width / 10,
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: white,
                                                          width: 0.5)),
                                                  child: ListView.builder(
                                                      itemCount:
                                                          listSeach.length,
                                                      itemBuilder:
                                                          (BuildContext context,
                                                              int index) {
                                                        if (searchController
                                                                .text
                                                                .isNotEmpty &&
                                                            !listSeach[index]
                                                                    ['name']
                                                                .toLowerCase()
                                                                .contains(
                                                                    searchController
                                                                        .text
                                                                        .toLowerCase())) {
                                                          return Container();
                                                        } else {
                                                          return ListTile(
                                                              leading: InkWell(
                                                                onTap: () {
                                                                  setState(() {
                                                                    listSeach
                                                                        .removeAt(
                                                                            index);
                                                                  });
                                                                },
                                                                child: Icon(
                                                                  Icons.remove,
                                                                  color: orange,
                                                                ),
                                                              ),
                                                              trailing: Text(
                                                                '${listSeach[index]['price']} ' +
                                                                    company['currency']
                                                                        [
                                                                        'symbol'],
                                                                style: TextStyle(
                                                                    color:
                                                                        backgroundColor,
                                                                    fontSize:
                                                                        15),
                                                              ),
                                                              title: Text(
                                                                  listSeach[
                                                                          index]
                                                                      [
                                                                      'name']));
                                                        }
                                                      }),
                                                ),
                                                const SizedBox(height: 20),
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
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: SizedBox(
                            width: width / 3,
                            height: 47,
                            child: ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  // Form is valid, process the data here.
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content:
                                          Text('Form submitted successfully!'),
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
                                widget.id != null ? 'Modify' : "Add",
                                style: TextStyle(fontSize: 24, color: white),
                              ),
                            ),
                          ),
                        ),
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
                                                  itemCount: listLoad.length,
                                                  itemBuilder:
                                                      (BuildContext context,
                                                          int index) {
                                                    if ((searchListController
                                                                .text
                                                                .isNotEmpty &&
                                                            !listLoad[index]
                                                                    ['name']
                                                                .toLowerCase()
                                                                .contains(
                                                                    searchListController
                                                                        .text
                                                                        .toLowerCase())) ||
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
                                                            child: Icon(
                                                                Icons.add,
                                                                color: orange),
                                                          ),
                                                          trailing: Text(
                                                            '${listLoad[index]['price']} ' +
                                                                company['currency']
                                                                    ['symbol'],
                                                            style: TextStyle(
                                                                color:
                                                                    backgroundColor,
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
                            ],
                          ),
                        )
                      : Container(),

                  //pick image bar
                  // (_pickImage == true)
                  //     ? Positioned(
                  //         bottom: 0,
                  //         child: InkWell(
                  //           onTap: () {
                  //             setState(() {
                  //               _pickImage = false;
                  //             });
                  //           },
                  //           child: Container(
                  //             height: media.height * 1,
                  //             width: media.width * 1,
                  //             color: Colors.transparent.withOpacity(0.6),
                  //             child: Column(
                  //               mainAxisAlignment: MainAxisAlignment.end,
                  //               children: [
                  //                 Container(
                  //                   // padding: EdgeInsets.all(media.width * 0.05),
                  //                   width: media.width / 2,
                  //                   decoration: BoxDecoration(
                  //                       borderRadius: const BorderRadius.only(
                  //                           topLeft: Radius.circular(25),
                  //                           topRight: Radius.circular(25)),
                  //                       border: Border.all(
                  //                         color: orange,
                  //                         width: 1.2,
                  //                       ),
                  //                       color: white),
                  //                   child: Column(
                  //                     children: [
                  //                       Container(
                  //                         height: media.width * 0.02,
                  //                         width: media.width * 0.15,
                  //                         decoration: BoxDecoration(
                  //                           borderRadius: BorderRadius.circular(
                  //                               media.width * 0.01),
                  //                           color: Colors.grey,
                  //                         ),
                  //                       ),
                  //                       SizedBox(
                  //                         height: media.width * 0.05,
                  //                       ),
                  //                       Row(
                  //                         mainAxisAlignment:
                  //                             MainAxisAlignment.spaceEvenly,
                  //                         children: [
                  //                           Column(
                  //                             children: [
                  //                               InkWell(
                  //                                 onTap: () {
                  //                                   pickImageFromCamera();
                  //                                 },
                  //                                 child: Container(
                  //                                     height:
                  //                                         media.width * 0.171,
                  //                                     width:
                  //                                         media.width * 0.171,
                  //                                     decoration: BoxDecoration(
                  //                                         border: Border.all(
                  //                                             color: orange,
                  //                                             width: 1.2),
                  //                                         borderRadius:
                  //                                             BorderRadius
                  //                                                 .circular(
                  //                                                     12)),
                  //                                     child: Icon(
                  //                                       Icons
                  //                                           .camera_alt_outlined,
                  //                                       size:
                  //                                           media.width * 0.064,
                  //                                     )),
                  //                               ),
                  //                               SizedBox(
                  //                                 height: media.width * 0.01,
                  //                               ),
                  //                               Text(
                  //                                 "Camera",
                  //                                 style:
                  //                                     TextStyle(color: black),
                  //                               )
                  //                             ],
                  //                           ),
                  //                           Column(
                  //                             children: [
                  //                               InkWell(
                  //                                 onTap: () {
                  //                                   pickImageFromGallery();
                  //                                 },
                  //                                 child: Container(
                  //                                     height:
                  //                                         media.width * 0.171,
                  //                                     width:
                  //                                         media.width * 0.171,
                  //                                     decoration: BoxDecoration(
                  //                                         border: Border.all(
                  //                                             color: orange,
                  //                                             width: 1.2),
                  //                                         borderRadius:
                  //                                             BorderRadius
                  //                                                 .circular(
                  //                                                     12)),
                  //                                     child: Icon(
                  //                                       Icons.image_outlined,
                  //                                       size:
                  //                                           media.width * 0.064,
                  //                                     )),
                  //                               ),
                  //                               SizedBox(
                  //                                 height: media.width * 0.01,
                  //                               ),
                  //                               Text(
                  //                                 "Gallery",
                  //                                 style:
                  //                                     TextStyle(color: black),
                  //                               )
                  //                             ],
                  //                           ),
                  //                         ],
                  //                       ),
                  //                     ],
                  //                   ),
                  //                 ),
                  //               ],
                  //             ),
                  //           ),
                  //         ))
                  //     : Container(),
                ],
              ),
            ));
  }
}
