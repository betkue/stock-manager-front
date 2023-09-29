// ignore_for_file: must_be_immutable, prefer_const_constructors, prefer_interpolation_to_compose_strings, sized_box_for_whitespace, unused_field

import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:stock_manager/constant.dart';
import 'package:stock_manager/functions/function.dart';
import 'package:stock_manager/load_page.dart';
import 'package:stock_manager/widgets/circular_button.dart';

class DetailPurshase extends StatefulWidget {
  String? id;
  Function back;
  Function setParent;
  DetailPurshase(
      {super.key, this.id, required this.back, required this.setParent});

  @override
  State<DetailPurshase> createState() => _DetailPurshaseState();
}

class _DetailPurshaseState extends State<DetailPurshase> {
  final _formKey = GlobalKey<FormState>();
  bool load = true;
  bool showSelectAction = false;
  bool showAction = false;
  dynamic imageFile;
  ImagePicker picker = ImagePicker();
  bool _pickImage = false;
  String _permission = '';
  bool is_return = false;
  TextEditingController searchProductController = TextEditingController();
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
                    ? purshase_single['reference'] ?? ""
                    : "New Customer",
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
                                  flex: 2,
                                  child: Container(
                                    padding: EdgeInsets.only(right: 10),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                setState(() {
                                                  pickImageFromGallery();
                                                });
                                              },
                                              child: (purshase_single['supplier']
                                                              ['image'] !=
                                                          null &&
                                                      imageFile == null)
                                                  ? Container(
                                                      margin: EdgeInsets.symmetric(
                                                          vertical: media.height /
                                                              40),
                                                      width: 60,
                                                      height: 60,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius.circular(
                                                                      100)),
                                                          color: orange,
                                                          image:
                                                              DecorationImage(
                                                                  image:
                                                                      NetworkImage(
                                                                    purshase_single[
                                                                            'supplier']
                                                                        [
                                                                        'image'],
                                                                  ),
                                                                  fit: BoxFit
                                                                      .cover)))
                                                  : (imageFile == null)
                                                      ? Container(
                                                          margin: EdgeInsets
                                                              .symmetric(
                                                                  vertical:
                                                                      media.height /
                                                                          40),
                                                          width:
                                                              media.width / 5,
                                                          height:
                                                              media.width / 5,
                                                          child: SizedBox(
                                                            height:
                                                                media.width / 5,
                                                            width:
                                                                media.width / 5,

                                                            child: Center(
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
                                                            // color: Colors.amber,
                                                          ),
                                                        )
                                                      : Container(
                                                          margin: EdgeInsets.symmetric(
                                                              vertical:
                                                                  media.height / 40),
                                                          width: media.width / 5,
                                                          height: media.width / 5,
                                                          decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(12)), image: DecorationImage(image: FileImage(File(imageFile)), fit: BoxFit.cover))),
                                            ),
                                            Text(
                                              purshase_single['supplier']
                                                  ['name'],
                                              textScaleFactor: 1.5,
                                            ),
                                          ],
                                        ),
                                        generateRowTable(
                                            titleTable("Product"),
                                            titleTable("reference"),
                                            titleTable(
                                                "price ${company['currency']['symbol']}"),
                                            titleTable("quantity"),
                                            titleTable(
                                                "total ${company['currency']['symbol']}"),
                                            titleTable("action")),
                                        // Table(
                                        //   children: [
                                        //     TableRow()
                                        //   ],
                                        // ),
                                        Expanded(
                                            child: ListView.builder(
                                                itemCount:
                                                    purshase_single['products']
                                                        .length,
                                                itemBuilder:
                                                    (BuildContext context,
                                                        int index) {
                                                  var product = purshase_single[
                                                      'products'][index];
                                                  return generateRowTable(
                                                      containTable(
                                                          product['name']),
                                                      containTable(
                                                          product['reference']),
                                                      containTable(
                                                          "${product['price']}"),
                                                      containTable(
                                                          "${product['quantity']}"),
                                                      containTable(
                                                          "${product['quantity'] * product['price']}  "),
                                                      containTable("action"));
                                                }))
                                      ],
                                    ),
                                  )),
                              Expanded(
                                  child: Container(
                                padding: EdgeInsets.only(left: 10),
                                decoration: BoxDecoration(
                                    border: Border(
                                        left: BorderSide(
                                            color: backgroundColor,
                                            style: BorderStyle.solid))),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 16,
                                    ),
                                    Text(
                                      widget.id != null
                                          ? "Movements"
                                          : "Products",
                                      textScaleFactor: 1.5,
                                    ),
                                    SizedBox(
                                      height: media.width * 0.02,
                                    ),
                                    widget.id != null
                                        ? Container()
                                        : Container(
                                            margin: EdgeInsets.only(
                                              bottom: media.width * 0.02,
                                            ),
                                            width: width,
                                            child: TextField(
                                              controller:
                                                  searchProductController,
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
                                        child: widget.id != null
                                            ? ListView.builder(
                                                itemCount:
                                                    purshase_single['movements']
                                                        .length,
                                                itemBuilder:
                                                    (BuildContext context,
                                                        int index) {
                                                  return genrateMovement(
                                                      purshase_single[
                                                          'movements'][index],
                                                      media);
                                                })
                                            : ListView.builder(
                                                itemCount:
                                                    supplier_single['products']
                                                        .length,
                                                itemBuilder:
                                                    (BuildContext context,
                                                        int index) {
                                                  return genrateProduct(
                                                      supplier_single[
                                                          'products'][index],
                                                      media);
                                                })),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 4),
                                      child: SizedBox(
                                        width: width / 3,
                                        height: 47,
                                        child: ElevatedButton(
                                          onPressed: () {
                                            setState(() {
                                              showSelectAction = true;
                                            });
                                          },
                                          style: ElevatedButton.styleFrom(
                                            //<-- SEE HERE
                                            backgroundColor: orange,
                                          ),
                                          child: Text(
                                            widget.id != null
                                                ? "Add Movment"
                                                : "Add Product",
                                            style: TextStyle(
                                                fontSize: 24, color: white),
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
                                widget.id != null ? 'Print' : "Create",
                                style: TextStyle(fontSize: 24, color: white),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  showSelectAction
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
                                        showSelectAction = false;
                                      });
                                    },
                                  )),
                              Center(
                                child: Container(
                                  padding: EdgeInsets.all(10),
                                  width: width / 4,
                                  height: width / 4,
                                  decoration: BoxDecoration(
                                      color: white,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(15))),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          is_return = false;
                                          showAction = true;
                                        },
                                        child: action(" Add delivery ",
                                            backgroundColor, media),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            is_return = true;
                                            showAction = true;
                                          });
                                        },
                                        child:
                                            action(" Add return ", red, media),
                                      ),
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

  Widget action(String title, Color color, dynamic media) {
    return Container(
      width: media.width / 5,
      padding: EdgeInsets.all(15),
      margin: EdgeInsets.all(5),
      decoration: BoxDecoration(
          color: color, borderRadius: BorderRadius.all(Radius.circular(15))),
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: TextStyle(color: white, fontWeight: FontWeight.bold),
      ),
    );
  }

  generateRowTable(Widget product, Widget reference, Widget price,
      Widget quantity, Widget total, Widget action) {
    Widget celule(Widget contain) => Expanded(
            child: Container(
          padding: EdgeInsets.all(14),
          decoration: BoxDecoration(
              border: Border.all(
            style: BorderStyle.solid,
          )),
          child: Center(child: contain),
        ));
    return Center(
      child: Container(
        child: Row(
          children: [
            celule(product),
            celule(reference),
            celule(price),
            celule(quantity),
            celule(total),
            // celule(action),
          ],
        ),
      ),
    );
  }

  titleTable(String title) {
    return Text(
      title,
      style: TextStyle(
          fontWeight: FontWeight.bold, overflow: TextOverflow.ellipsis),
    );
  }

  containTable(String title) {
    return Text(
      title,
      style: TextStyle(
          fontWeight: FontWeight.w400, overflow: TextOverflow.ellipsis),
    );
  }

  Widget genrateProduct(Map<String, dynamic> product, dynamic media) {
    return InkWell(
      onTap: () {},
      child: Container(
        margin: EdgeInsets.only(bottom: media.width * 0.012),
        // width: media.width * 0.9,
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          border: Border.all(color: backgroundColor, width: 1.2),
          borderRadius: BorderRadius.circular(12),
        ),
        child: SingleChildScrollView(
            child: Row(children: [
          Container(
            height: media.width * 0.03,
            width: media.width * 0.03,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                image: DecorationImage(image: NetworkImage(product['image'])),
                color: backgroundColor),
          ),
          SizedBox(
            width: media.width * 0.0125,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${product['name']}",
                style: TextStyle(
                    // fontSize: media.width * 0.8,
                    color: dark,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: media.width * 0.01,
              ),
              Text(
                "${product['reference']}",
                style: TextStyle(
                  // fontSize: media.width * 0.3,
                  color: gray,
                ),
              )
            ],
          ),
        ])),
      ),
    );
  }

  Widget genrateMovement(Map<String, dynamic> movement, dynamic media) {
    return InkWell(
      onTap: () {},
      child: Container(
        margin: EdgeInsets.only(bottom: media.width * 0.012),
        // width: media.width * 0.9,
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          border: Border.all(color: backgroundColor, width: 1.2),
          borderRadius: BorderRadius.circular(12),
        ),
        child: SingleChildScrollView(
          child: Row(
            children: [
              Container(
                height: media.width * 0.03,
                width: media.width * 0.03,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: (movement['return']) ? red : backgroundColor),
                alignment: Alignment.center,
                child: (movement['return'])
                    ? Icon(
                        Icons.reset_tv_rounded,
                        color: white,
                      )
                    : Icon(
                        Icons.delivery_dining_sharp,
                        color: white,
                      ),
                // Text(
                //   (movement['return']) ? '-' : '+',
                //   textScaleFactor: 1.3,
                //   style: TextStyle(color: white),
                // ),
              ),
              SizedBox(
                width: media.width * 0.0125,
              ),
              Text(
                "${movement['products'].length} Products",
                style: TextStyle(
                  // fontSize: media.width * 0.6,
                  color: black,
                ),
              ),
              SizedBox(
                width: media.width * 0.0125,
              ),
              Column(
                children: [
                  Text(
                    " By ${movement['user']['name']}",
                    style: TextStyle(
                        // fontSize: media.width * 0.8,
                        color: dark,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: media.width * 0.01,
                  ),
                  Text(
                    convertDate(movement['created_at']),
                    style: TextStyle(
                      // fontSize: media.width * 0.3,
                      color: gray,
                    ),
                  )
                ],
              ),
              Expanded(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "${company['currency']['symbol']}" +
                        ' ' +
                        movement['total'].toString(),
                    style: TextStyle(
                      // fontSize: media.width * 0.6,
                      color: dark,
                    ),
                  )
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
}
