// ignore_for_file: must_be_immutable, prefer_const_constructors, prefer_interpolation_to_compose_strings, sized_box_for_whitespace

import 'dart:async';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stock_manager/config/constant.dart';
import 'package:stock_manager/config/parameter.dart';
import 'package:stock_manager/config/style.dart';
import 'package:stock_manager/functions/function.dart';
import 'package:stock_manager/functions/supplier_function.dart';
import 'package:stock_manager/load_page.dart';
import 'package:stock_manager/widgets/circular_button.dart';
import 'package:stock_manager/widgets/account/account.dart';
import 'package:permission_handler/permission_handler.dart';

class DetailSupplier extends StatefulWidget {
  String? id;
  Function back;

  Function setParent;
  DetailSupplier(
      {super.key, this.id, required this.back, required this.setParent});

  @override
  State<DetailSupplier> createState() => _DetailSupplierState();
}

class _DetailSupplierState extends State<DetailSupplier> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController refController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController searchController = TextEditingController();
  TextEditingController searchListController = TextEditingController();
  TextEditingController sigleController = TextEditingController();
  TextEditingController countryController =
      TextEditingController(text: countries[phcode]['name']);
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

  List<Map<String, dynamic>> listLoad = [];

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
    nameController.text = supplier_single['name'] ?? "";
    refController.text = supplier_single['reference'] ?? "";
    locationController.text = supplier_single['location'] ?? "";
    descriptionController.text = supplier_single['description'] ?? "";
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
                  color: primaryColor,
                ),
              ),
              title: Text(
                widget.id != null
                    ? supplier_single['name'] ?? ""
                    : "New Supplier",
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
                                      child: (supplier_single['logo'] != null &&
                                              imageFile == null)
                                          ? Container(
                                              margin: EdgeInsets.symmetric(
                                                  vertical: media.height / 40),
                                              width: media.width / 5,
                                              height: media.width / 5,
                                              child: CachedNetworkImage(
                                                imageUrl:
                                                    supplier_single['logo'],
                                                fit: BoxFit.contain,
                                              ),
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(12)),
                                                // image: DecorationImage(
                                                //     image: NetworkImage(
                                                //       supplier_single[
                                                //           'image'],
                                                //     ),
                                                //     fit: BoxFit.cover)
                                              ))
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
                                        controller: descriptionController,
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
                                                label('supplier name'),
                                                inputContain(
                                                    width,
                                                    ' the supplier name',
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
                                                    ' the supplier reference',
                                                    refController,
                                                    (String value) {
                                                  setState(() {
                                                    refController.text = value;
                                                    user_email =
                                                        refController.text;
                                                  });
                                                }, false, false),
                                                const SizedBox(height: 20),
                                                label(' Sigle'),
                                                inputContain(
                                                    width,
                                                    '  the supplier Sigle',
                                                    sigleController,
                                                    (String value) {
                                                  setState(() {
                                                    sigleController.text =
                                                        value;
                                                    user_rule =
                                                        sigleController.text;
                                                  });
                                                }, false, false),
                                                const SizedBox(
                                                  height: 20,
                                                ),
                                                label('Country'),
                                                InkWell(
                                                  onTap: () async {
                                                    if (countries.isNotEmpty) {
                                                      //dialod box for select country for dial code
                                                      await showDialog(
                                                          context: context,
                                                          builder: (context) {
                                                            var searchVal = '';
                                                            return AlertDialog(
                                                              insetPadding:
                                                                  const EdgeInsets
                                                                      .all(10),
                                                              content: StatefulBuilder(
                                                                  builder: (context,
                                                                      setState) {
                                                                return Container(
                                                                  width: media
                                                                          .width *
                                                                      0.9,
                                                                  color: Colors
                                                                      .white,
                                                                  child: Column(
                                                                    children: [
                                                                      SingleChildScrollView(
                                                                        scrollDirection:
                                                                            Axis.horizontal,
                                                                        child:
                                                                            Row(
                                                                          children: [
                                                                            Container(
                                                                              padding: const EdgeInsets.only(left: 20),
                                                                              height: 40,
                                                                              width: media.width * 0.7,
                                                                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), border: Border.all(color: Colors.grey, width: 1.5)),
                                                                              child: TextField(
                                                                                decoration: InputDecoration(border: InputBorder.none, hintText: "Search", hintStyle: TextStyle(fontSize: media.width / 70)),
                                                                                onChanged: (val) {
                                                                                  setState(() {
                                                                                    searchVal = val;
                                                                                  });
                                                                                },
                                                                              ),
                                                                            ),
                                                                            SizedBox(
                                                                              width: 20,
                                                                            ),
                                                                            Container(
                                                                              child: CirularButton(onClick: () {
                                                                                Navigator.pop(context);
                                                                              }),
                                                                            )
                                                                          ],
                                                                        ),
                                                                      ),
                                                                      const SizedBox(
                                                                          height:
                                                                              20),
                                                                      Expanded(
                                                                        child:
                                                                            SingleChildScrollView(
                                                                          child:
                                                                              Column(
                                                                            children: countries
                                                                                .asMap()
                                                                                .map((i, value) {
                                                                                  return MapEntry(
                                                                                      i,
                                                                                      SizedBox(
                                                                                        width: media.width * 0.9,
                                                                                        child: (searchVal == '' && countries[i]['flag'] != null)
                                                                                            ? InkWell(
                                                                                                onTap: () {
                                                                                                  setState(() {
                                                                                                    phcode = i;
                                                                                                    country_id = countries[i]['id'];

                                                                                                    countryController.text = countries[i]['name'];
                                                                                                  });
                                                                                                  Navigator.pop(context);
                                                                                                },
                                                                                                child: Container(
                                                                                                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                                                                                                  color: Colors.white,
                                                                                                  child: SingleChildScrollView(
                                                                                                      scrollDirection: Axis.horizontal,
                                                                                                      child: Row(
                                                                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                                        children: [
                                                                                                          Row(
                                                                                                            children: [
                                                                                                              SizedBox(width: media.width * 0.4, child: Text(countries[i]['code'], style: TextStyle(fontSize: media.width / 70))),
                                                                                                              SizedBox(
                                                                                                                width: media.width * 0.02,
                                                                                                              ),
                                                                                                              SizedBox(
                                                                                                                  width: media.width * 0.4,
                                                                                                                  child: Text(
                                                                                                                    countries[i]['name'],
                                                                                                                    style: TextStyle(fontSize: media.width / 70),
                                                                                                                  )),
                                                                                                            ],
                                                                                                          ),
                                                                                                          Text(
                                                                                                            countries[i]['dial_code'],
                                                                                                            style: TextStyle(fontSize: media.width / 70),
                                                                                                          )
                                                                                                        ],
                                                                                                      )),
                                                                                                ))
                                                                                            : (countries[i]['flag'] != null && countries[i]['name'].toLowerCase().contains(searchVal.toLowerCase()))
                                                                                                ? InkWell(
                                                                                                    onTap: () {
                                                                                                      setState(() {
                                                                                                        phcode = i;
                                                                                                        country_id = countries[i]['id'];
                                                                                                        countryController.text = countries[i]['name'];
                                                                                                      });
                                                                                                      Navigator.pop(context);
                                                                                                    },
                                                                                                    child: Container(
                                                                                                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                                                                                                      color: Colors.white,
                                                                                                      child: Row(
                                                                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                                        children: [
                                                                                                          Row(
                                                                                                            children: [
                                                                                                              SizedBox(
                                                                                                                  width: media.width * 0.4,
                                                                                                                  child: Text(
                                                                                                                    countries[i]['code'],
                                                                                                                    style: TextStyle(fontSize: media.width / 70),
                                                                                                                  )),
                                                                                                              SizedBox(
                                                                                                                width: media.width * 0.02,
                                                                                                              ),
                                                                                                              SizedBox(
                                                                                                                  width: media.width * 0.4,
                                                                                                                  child: Text(
                                                                                                                    countries[i]['name'],
                                                                                                                    style: TextStyle(fontSize: media.width / 70),
                                                                                                                  )),
                                                                                                            ],
                                                                                                          ),
                                                                                                          Text(
                                                                                                            countries[i]['dial_code'],
                                                                                                            style: TextStyle(fontSize: media.width / 70),
                                                                                                          )
                                                                                                        ],
                                                                                                      ),
                                                                                                    ))
                                                                                                : Container(),
                                                                                      ));
                                                                                })
                                                                                .values
                                                                                .toList(),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                );
                                                              }),
                                                            );
                                                          });
                                                    } else {
                                                      getCountryCode();
                                                    }
                                                    setState(() {});
                                                  },
                                                  child: Container(
                                                    padding: EdgeInsets.only(
                                                        left: 5),
                                                    width: width / 4.5,
                                                    height: 47,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                      color: gray,
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: Colors.grey
                                                              .withOpacity(0.2),
                                                          spreadRadius: 2,
                                                          blurRadius: 4,
                                                          offset: Offset(0, 2),
                                                        ),
                                                      ],
                                                    ),
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          vertical: 15),
                                                      child: Text(
                                                        countryController.text,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(height: 20),
                                                label(' Location'),
                                                inputContain(
                                                    width,
                                                    '  the supplier location',
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

                                                // Row(
                                                //   children: [
                                                //     label(
                                                //         ' products (${listSeach.length})'),
                                                //     InkWell(
                                                //       onTap: () {
                                                //         setState(() {
                                                //           showList = true;
                                                //         });

                                                //         Timer(
                                                //             Duration(
                                                //                 seconds: 5),
                                                //             () => setState(() {
                                                //                   loadList =
                                                //                       false;
                                                //                 }));
                                                //       },
                                                //       child: Container(
                                                //         padding: EdgeInsets
                                                //             .symmetric(
                                                //                 vertical: 5,
                                                //                 horizontal: 20),
                                                //         margin: EdgeInsets.only(
                                                //             left: 10),
                                                //         decoration: BoxDecoration(
                                                //             color: primaryColor,
                                                //             borderRadius:
                                                //                 BorderRadius
                                                //                     .all(Radius
                                                //                         .circular(
                                                //                             10))),
                                                //         child: Text(
                                                //           "ADD",
                                                //           style: TextStyle(
                                                //               color: white,
                                                //               fontWeight:
                                                //                   FontWeight
                                                //                       .bold),
                                                //         ),
                                                //       ),
                                                //     )
                                                //   ],
                                                // ),
                                                // Container(
                                                //   margin:
                                                //       EdgeInsets.only(top: 10),
                                                //   width: width,
                                                //   child: TextField(
                                                //     controller:
                                                //         searchController,
                                                //     decoration: InputDecoration(
                                                //       hintText: "Search",
                                                //       prefixIcon:
                                                //           Icon(Icons.search),
                                                //       border:
                                                //           OutlineInputBorder(),
                                                //     ),
                                                //     onChanged: (value) {
                                                //       setState(() {
                                                //         // searchsupplier Controller.text = value;
                                                //       });
                                                //     },
                                                //   ),
                                                // ),
                                                // Container(
                                                //   margin:
                                                //       EdgeInsets.only(top: 10),
                                                //   width: width,
                                                //   height: width / 5,
                                                //   decoration: BoxDecoration(
                                                //       border: Border.all(
                                                //           color: white,
                                                //           width: 0.5)),
                                                //   child: ListView.builder(
                                                //       itemCount:
                                                //           listSeach.length,
                                                //       itemBuilder:
                                                //           (BuildContext context,
                                                //               int index) {
                                                //         if (searchController
                                                //                 .text
                                                //                 .isNotEmpty &&
                                                //             !listSeach[index]
                                                //                     ['name']
                                                //                 .toLowerCase()
                                                //                 .contains(
                                                //                     searchController
                                                //                         .text
                                                //                         .toLowerCase())) {
                                                //           return Container();
                                                //         } else {
                                                //           return ListTile(
                                                //               leading: InkWell(
                                                //                 onTap: () {
                                                //                   setState(() {
                                                //                     listSeach
                                                //                         .removeAt(
                                                //                             index);
                                                //                   });
                                                //                 },
                                                //                 child: Icon(
                                                //                   Icons.remove,
                                                //                   color:
                                                //                       primaryColor,
                                                //                 ),
                                                //               ),
                                                //               trailing: Text(
                                                //                 '${listSeach[index]['price']} ' +
                                                //                     company['currency']
                                                //                         [
                                                //                         'symbol'],
                                                //                 style: TextStyle(
                                                //                     color:
                                                //                         backgroundColor,
                                                //                     fontSize:
                                                //                         15),
                                                //               ),
                                                //               title: Text(
                                                //                   listSeach[
                                                //                           index]
                                                //                       [
                                                //                       'name']));
                                                //         }
                                                //       }),
                                                // ),
                                                // const SizedBox(height: 20),
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
                                (imageFile != null ||
                                    supplier_single['logo'] != null) &&
                                refController.text.isNotEmpty &&
                                sigleController.text.isNotEmpty &&
                                locationController.text.isNotEmpty &&
                                countryController.text.isNotEmpty &&
                                currency_id != null)
                            ? Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 4),
                                child: SizedBox(
                                  width: width / 3,
                                  height: 47,
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      if (_formKey.currentState!.validate()) {
                                        setState(() {
                                          load = true;
                                        });

                                        Map<String, String> supplier = {
                                          'name': nameController.text,
                                          'reference': refController.text,
                                          'sigle': sigleController.text,
                                          "description":
                                              descriptionController.text,
                                          "location": locationController.text,
                                          "product_id": id_supplier.toString(),
                                          "currency_id": currency_id.toString(),
                                          "country_id": country_id.toString()
                                        };

                                        debugPrint(widget.id.toString());
                                        var result = widget.id == null
                                            ? await createSupplier(
                                                supplier, imageFile, context)
                                            : await updateSupplier(
                                                supplier, imageFile, context);

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
                                      widget.id != null ? 'Modify' : "Add",
                                      style:
                                          TextStyle(fontSize: 24, color: white),
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
                                                    // searchsupplier Controller.text = value;
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
                                                                color:
                                                                    primaryColor),
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
                  //                         color: primaryColor,
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
                  //                                             color: primaryColor,
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
                  //                                             color: primaryColor,
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
