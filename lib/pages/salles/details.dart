// ignore_for_file: must_be_immutable, prefer_const_constructors, prefer_interpolation_to_compose_strings, sized_box_for_whitespace, unused_field

import 'dart:async';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:stock_manager/config/constant.dart';
import 'package:stock_manager/config/parameter.dart';
import 'package:stock_manager/config/style.dart';
import 'package:stock_manager/functions/function.dart';
import 'package:stock_manager/load_page.dart';
import 'package:stock_manager/widgets/account/account.dart';
import 'package:stock_manager/widgets/circular_button.dart';

class DetailSales extends StatefulWidget {
  String? id;
  Function back;
  Function setParent;
  DetailSales(
      {super.key, this.id, required this.back, required this.setParent});

  @override
  State<DetailSales> createState() => _DetailSalesState();
}

class _DetailSalesState extends State<DetailSales> {
  final _formKey = GlobalKey<FormState>();
  bool load = true;
  bool showSelectAction = false;
  bool showAction = false;
  bool showMovement = false;
  dynamic imageFile;
  ImagePicker picker = ImagePicker();
  bool _pickImage = false;
  String _permission = '';
  bool is_return = false;
  Map<String, dynamic> movementSelected = {};
  List<Map<String, dynamic>> listProducts = [];
  TextEditingController searchProductController = TextEditingController();
  //gallery permission
  getGalleryPermission() async {
    var status = await Permission.photos.status;
    if (status != PermissionStatus.granted) {
      status = await Permission.photos.request();
    }
    return status;
  }

  detrmineContainRef(String ref) {
    for (var i = 0;
        i <
            (widget.id != null
                ? salle_single['products'].length
                : listProducts.length);
        i++) {
      if ((widget.id != null ? salle_single['products'] : listProducts)[i]
              ['reference'] ==
          ref) {
        return true;
      }
    }

    return false;
  }

  calculateTotalQuantity() {
    List<Map<String, dynamic>> products = showMovement
        ? movementSelected['products']
        : widget.id != null
            ? salle_single['products']
            : listProducts;
    dynamic qte = 0;
    for (var i = 0; i < products.length; i++) {
      if (widget.id != null) {
        qte += products[i]['quantity'];
      } else {
        qte += double.parse(products[i]['quantity'].text);
      }
    }
    return "$qte";
  }

  calculateTotalPrice() {
    List<Map<String, dynamic>> products =
        widget.id != null ? salle_single['products'] : listProducts;
    dynamic qte = 0;

    for (var i = 0; i < products.length; i++) {
      if (widget.id != null) {
        qte += (products[i]['quantity'] * products[i]['price']);
      } else {
        qte += (double.parse(products[i]['quantity'].text) *
            double.parse(products[i]['price'].text));
      }
    }
    return "$qte";
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
                  color: primaryColor,
                ),
              ),
              title: Text(
                widget.id != null
                    ? salle_single['reference'] ?? ""
                    : "New Sale",
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
                                              child: (salle_single['customer']
                                                              ['image'] !=
                                                          null &&
                                                      imageFile == null)
                                                  ? Container(
                                                      margin: EdgeInsets.symmetric(
                                                          vertical: media.height /
                                                              40),
                                                      width: 60,
                                                      height: 60,
                                                      child: CachedNetworkImage(
                                                        imageUrl: salle_single[
                                                                'image'] ??
                                                            "",
                                                        fit: BoxFit.contain,
                                                        placeholder: (context,
                                                                url) =>
                                                            CircularProgressIndicator(),
                                                        errorWidget: (context,
                                                                url, error) =>
                                                            Icon(Icons.error),
                                                      ),
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    100)),
                                                        color: primaryColor,
                                                        // image:
                                                        //     DecorationImage(
                                                        //         image:
                                                        //             NetworkImage(
                                                        //           salle_single[
                                                        //                   'customer']
                                                        //               [
                                                        //               'image'],
                                                        //         ),
                                                        //         fit: BoxFit
                                                        //             .cover)
                                                        //             )
                                                      ))
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
                                                                        primaryColor,
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
                                                              vertical: media.height /
                                                                  40),
                                                          width:
                                                              media.width / 5,
                                                          height:
                                                              media.width / 5,
                                                          decoration: BoxDecoration(
                                                              borderRadius: BorderRadius.all(
                                                                  Radius.circular(
                                                                      12)),
                                                              image: DecorationImage(
                                                                  image: FileImage(File(imageFile)),
                                                                  fit: BoxFit.cover))),
                                            ),
                                            Text(
                                              salle_single['customer']['name'],
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
                                            child: widget.id != null
                                                ? ListView.builder(
                                                    itemCount: showMovement
                                                        ? movementSelected[
                                                                'products']
                                                            .length
                                                        : salle_single[
                                                                'products']
                                                            .length,
                                                    itemBuilder:
                                                        (BuildContext context,
                                                            int index) {
                                                      var product = showMovement
                                                          ? movementSelected[
                                                              'products'][index]
                                                          : salle_single[
                                                                  'products']
                                                              [index];
                                                      return generateRowTable(
                                                          containTable(
                                                              product['name']),
                                                          containTable(product[
                                                              'reference']),
                                                          containTable(
                                                              "${product['price']}"),
                                                          containTable(
                                                              "${product['quantity']}"),
                                                          containTable(
                                                              "${product['quantity'] * product['price']}  "),
                                                          containTable(
                                                              "action"));
                                                    })
                                                : ListView.builder(
                                                    itemCount:
                                                        listProducts.length,
                                                    itemBuilder:
                                                        (BuildContext context,
                                                            int index) {
                                                      var product =
                                                          listProducts[index];
                                                      return generateRowTable(
                                                          containTable(
                                                              product['name']),
                                                          containTable(product[
                                                              'reference']),
                                                          TextField(
                                                            controller: product[
                                                                'price'],
                                                            decoration:
                                                                InputDecoration(
                                                              hintText: "price",
                                                              border:
                                                                  OutlineInputBorder(),
                                                            ),
                                                            onChanged: (value) {
                                                              setState(() {
                                                                value.isEmpty
                                                                    ? product[
                                                                            'price']
                                                                        .text = "0"
                                                                    : null;
                                                                // searchProductsController.text = value;
                                                              });
                                                            },
                                                          )
                                                          // inputContain(
                                                          //     width,
                                                          //     "price",
                                                          //     product['price'],
                                                          //     () {},
                                                          //     false,
                                                          //     false)

                                                          ,
                                                          TextField(
                                                            controller: product[
                                                                'quantity'],
                                                            decoration:
                                                                InputDecoration(
                                                              hintText:
                                                                  "quantity",
                                                              border:
                                                                  OutlineInputBorder(),
                                                            ),
                                                            onChanged: (value) {
                                                              setState(() {
                                                                value.isEmpty
                                                                    ? product[
                                                                            'quantity']
                                                                        .text = "0"
                                                                    : null;
                                                              });
                                                            },
                                                          )

                                                          // inputContain(
                                                          //     width,
                                                          //     "quantity",
                                                          //     product[
                                                          //         'quantity'],
                                                          //     () {},
                                                          //     false,
                                                          //     false)

                                                          ,
                                                          containTable(
                                                              "${double.parse("${product['quantity'].text ?? "0"}") * double.parse("${product['price'].text ?? "0"}")}"),
                                                          containTable(
                                                              "action"));
                                                    })),

                                        generateRowTable(
                                            titleTable("Total"),
                                            titleTable(""),
                                            titleTable(""),
                                            titleTable(
                                                "${calculateTotalQuantity()}"),
                                            titleTable(
                                                "${calculateTotalPrice()}"),
                                            titleTable("action")),
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
                                                    salle_single['movements']
                                                        .length,
                                                itemBuilder:
                                                    (BuildContext context,
                                                        int index) {
                                                  return genrateMovement(
                                                      salle_single['movements']
                                                          [index],
                                                      media);
                                                })
                                            : ListView.builder(
                                                itemCount:
                                                    salle_single['products'] ??
                                                        [].length,
                                                itemBuilder:
                                                    (BuildContext context,
                                                        int index) {
                                                  if ((searchProductController
                                                              .text
                                                              .isNotEmpty &&
                                                          !salle_single[
                                                                      'products']
                                                                  [
                                                                  index]['name']
                                                              .toLowerCase()
                                                              .contains(
                                                                  searchProductController
                                                                      .text
                                                                      .toLowerCase())) ||
                                                      detrmineContainRef(
                                                          salle_single[
                                                                      'products']
                                                                  [index]
                                                              ['reference'])) {
                                                    return Container();
                                                  } else {
                                                    return
                                                        // Text(
                                                        //     "${detrmineContainRef(salle_single['products'][index]['reference'])}");
                                                        genrateProduct(
                                                            salle_single[
                                                                    'products']
                                                                [index],
                                                            media);
                                                  }
                                                })),
                                    showMovement
                                        ? Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 4),
                                            child: SizedBox(
                                              width: width / 3,
                                              height: 47,
                                              child: ElevatedButton(
                                                onPressed: () {
                                                  setState(() {
                                                    showMovement = false;
                                                  });
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  //<-- SEE HERE
                                                  backgroundColor: primaryColor,
                                                ),
                                                child: Text(
                                                  "Show salle",
                                                  style: TextStyle(
                                                      fontSize: 24,
                                                      color: white),
                                                ),
                                              ),
                                            ),
                                          )
                                        : Padding(
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
                                                  backgroundColor: primaryColor,
                                                ),
                                                child: Text(
                                                  widget.id != null
                                                      ? "Add Movment"
                                                      : "Add Product",
                                                  style: TextStyle(
                                                      fontSize: 24,
                                                      color: white),
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
                                backgroundColor: primaryColor,
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
          height: 70,
          padding: EdgeInsets.all(14),
          decoration: BoxDecoration(
              // color: red,
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
      onTap: () {
        Map<String, dynamic> newProdut = {
          "name": product['name'],
          "reference": product['reference'],
          "quantity": TextEditingController(text: "${product['quantity']}"),
          "price": TextEditingController(text: "${product['price']}"),
        };

        setState(() {
          listProducts.add(newProdut);
        });
      },
      child: Container(
        margin: EdgeInsets.only(bottom: media.width * 0.012),
        // width: media.width * 0.9,
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          border: Border.all(color: backgroundColor, width: 0.5),
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
          Expanded(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                "${company['currency']['symbol']}" +
                    ' ' +
                    product['price'].toString(),
                style: TextStyle(
                  // fontSize: media.width * 0.6,
                  color: dark,
                ),
              )
            ],
          ))
        ])),
      ),
    );
  }

  Widget genrateMovement(Map<String, dynamic> movement, dynamic media) {
    return InkWell(
      onTap: () {
        setState(() {
          movementSelected = movement;
          showMovement = true;
        });
      },
      child: Container(
        margin: EdgeInsets.only(bottom: media.width * 0.012),
        // width: media.width * 0.9,
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          border: Border.all(color: backgroundColor, width: 0.5),
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


// // ignore_for_file: must_be_immutable, prefer_const_constructors, prefer_interpolation_to_compose_strings, sized_box_for_whitespace

// import 'dart:async';
// import 'dart:io';

// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:dotted_border/dotted_border.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:stock_manager/config/constant.dart';
// import 'package:stock_manager/config/parameter.dart';
// import 'package:stock_manager/config/style.dart';
// import 'package:stock_manager/load_page.dart';
// import 'package:stock_manager/widgets/circular_button.dart';
// import 'package:stock_manager/widgets/account/account.dart';
// import 'package:permission_handler/permission_handler.dart';

// class DetailSalle extends StatefulWidget {
//   String? id;
//   Function back;
//   Function setParent;
//   DetailSalle(
//       {super.key, this.id, required this.back, required this.setParent});

//   @override
//   State<DetailSalle> createState() => _DetailSalleState();
// }

// class _DetailSalleState extends State<DetailSalle> {
//   final _formKey = GlobalKey<FormState>();
//   TextEditingController nameController = TextEditingController();
//   TextEditingController refController = TextEditingController();
//   TextEditingController locationController = TextEditingController();
//   TextEditingController searchController = TextEditingController();
//   TextEditingController searchListController = TextEditingController();
//   ImagePicker picker = ImagePicker();
//   bool load = true;
//   bool showList = false;
//   bool loadList = false;
//   bool _pickImage = false;
//   String _permission = '';
//   dynamic imageFile;
//   //gallery permission
//   getGalleryPermission() async {
//     var status = await Permission.photos.status;
//     if (status != PermissionStatus.granted) {
//       status = await Permission.photos.request();
//     }
//     return status;
//   }

// //camera permission
//   getCameraPermission() async {
//     var status = await Permission.camera.status;
//     if (status != PermissionStatus.granted) {
//       status = await Permission.camera.request();
//     }
//     return status;
//   }

// //pick image from gallery
//   pickImageFromGallery() async {
//     final pickedFile = await picker.pickImage(source: ImageSource.gallery);
//     setState(() {
//       if (pickedFile != null) {
//         imageFile = pickedFile.path;
//         _pickImage = false;
//       }

//       _pickImage = false;
//     });
//     // var permission;
//     // if (Platform.isMacOS) {
//     //   permission = PermissionStatus.granted;
//     // } else {
//     //   permission = await getCameraPermission();
//     // }
//     // if (permission == PermissionStatus.granted) {
//     //   final pickedFile = await picker.pickImage(source: ImageSource.gallery);
//     //   setState(() {
//     //     imageFile = pickedFile?.path;
//     //     _pickImage = false;
//     //   });
//     // } else {
//     //   setState(() {
//     //     _permission = 'noPhotos';
//     //   });
//     // }
//   }

// //pick image from camera
//   pickImageFromCamera() async {
//     var permission;
//     if (Platform.isMacOS) {
//       permission = PermissionStatus.granted;
//     } else {
//       permission = await getCameraPermission();
//     }
//     if (permission == PermissionStatus.granted) {
//       final pickedFile = await picker.pickImage(source: ImageSource.camera);
//       setState(() {
//         imageFile = pickedFile?.path;
//         _pickImage = false;
//       });
//     } else {
//       setState(() {
//         _permission = 'noCamera';
//       });
//     }
//   }

//   List<Map<String, dynamic>> listSeach = [
//     {"id": 12, "name": "Patrick", "price": 2000},
//     {"id": 12, "name": "Patrick", "price": 2000},
//     {"id": 12, "name": "Patrick", "price": 2000},
//     {"id": 12, "name": "Patrick", "price": 2000},
//     {"id": 12, "name": "Patrick", "price": 2000},
//     {"id": 12, "name": "Patrick", "price": 2000},
//     {"id": 12, "name": "Patrick", "price": 2000},
//     {"id": 12, "name": "Patrick", "price": 2000},
//   ];

//   List<Map<String, dynamic>> listLoad = [
//     {"id": 12, "name": "Patrick", "price": 2000},
//     {"id": 12, "name": "Patrick", "price": 2000},
//     {"id": 12, "name": "Patrick", "price": 2000},
//     {"id": 12, "name": "Patrick", "price": 2000},
//     {"id": 125, "name": "Patrick", "price": 2000},
//     {"id": 123, "name": "Patrick", "price": 2000},
//     {"id": 126, "name": "Patrick", "price": 2000},
//     {"id": 128, "name": "Patrick", "price": 2000},
//   ];

//   detrmineContainId(int id) {
//     for (var i = 0; i < listSeach.length; i++) {
//       if (listSeach[i]['id'] == id) {
//         return true;
//       }
//     }

//     return false;
//   }

//   @override
//   void initState() {
//     Timer(
//         Duration(seconds: timedalay),
//         () => setState(() {
//               load = false;
//             }));
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     dynamic media = MediaQuery.of(context).size;
//     double width = media.width;
//     double height = media.height;

//     return load
//         ? LoadPage()
//         : Scaffold(
//             // backgroundColor: gray,
//             appBar: AppBar(
//               backgroundColor: white,
//               elevation: 0,
//               leading: InkWell(
//                 onTap: () {
//                   widget.back();
//                 },
//                 child: Icon(
//                   Icons.arrow_back,
//                   color: primaryColor,
//                 ),
//               ),
//               title: Text(
//                 widget.id != null
//                     ? customer_single['name'] ?? ""
//                     : "New Customer",
//                 style: TextStyle(color: black),
//               ),
//             ),
//             body: SafeArea(
//               child: Stack(
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 10),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Expanded(
//                           child: Row(
//                             children: [
//                               Expanded(
//                                   child: Center(
//                                 child: ListView(
//                                   // mainAxisAlignment: MainAxisAlignment.center,
//                                   children: [
//                                     Center(
//                                         child: InkWell(
//                                       onTap: () {
//                                         setState(() {
//                                           pickImageFromGallery();
//                                         });
//                                       },
//                                       child: (customer_single['logo'] != null &&
//                                               imageFile == null)
//                                           ? Container(
//                                               margin: EdgeInsets.symmetric(
//                                                   vertical: media.height / 40),
//                                               width: media.width / 5,
//                                               height: media.width / 5,
//                                               child: CachedNetworkImage(
//                                                 imageUrl: salle_single['image'],
//                                                 fit: BoxFit.contain,
//                                               ),
//                                               decoration: BoxDecoration(
//                                                 borderRadius: BorderRadius.all(
//                                                     Radius.circular(12)),
//                                                 // image: DecorationImage(
//                                                 //     image: NetworkImage(
//                                                 //       customer_single[
//                                                 //           'image'],
//                                                 //     ),
//                                                 //     fit: BoxFit.cover)
//                                               ))
//                                           : (imageFile == null)
//                                               ? Container(
//                                                   margin: EdgeInsets.symmetric(
//                                                       vertical:
//                                                           media.height / 40),
//                                                   width: media.width / 5,
//                                                   height: media.width / 5,
//                                                   child: DottedBorder(
//                                                     borderType:
//                                                         BorderType.RRect,
//                                                     color: black,
//                                                     borderPadding:
//                                                         EdgeInsets.all(6),
//                                                     dashPattern: [8, 8],
//                                                     radius: Radius.circular(12),
//                                                     padding: EdgeInsets.all(6),
//                                                     child: ClipRRect(
//                                                       borderRadius:
//                                                           BorderRadius.all(
//                                                               Radius.circular(
//                                                                   12)),
//                                                       child: SizedBox(
//                                                         height: media.width / 5,
//                                                         width: media.width / 5,

//                                                         child: Center(
//                                                           child: DottedBorder(
//                                                             borderType:
//                                                                 BorderType
//                                                                     .RRect,
//                                                             radius:
//                                                                 Radius.circular(
//                                                                     12),
//                                                             padding:
//                                                                 EdgeInsets.all(
//                                                                     6),
//                                                             dashPattern: [8, 8],
//                                                             color: gray,
//                                                             child: ClipRRect(
//                                                               borderRadius: BorderRadius
//                                                                   .all(Radius
//                                                                       .circular(
//                                                                           12)),
//                                                               child: SizedBox(
//                                                                 height: media
//                                                                         .width /
//                                                                     8,
//                                                                 width: media
//                                                                         .width /
//                                                                     8,
//                                                                 child: Center(
//                                                                   child: Icon(
//                                                                     Icons.add,
//                                                                     color:
//                                                                         primaryColor,
//                                                                   ),
//                                                                 ),
//                                                                 // color: Colors.amber,
//                                                               ),
//                                                             ),
//                                                           ),
//                                                         ),
//                                                         // color: Colors.amber,
//                                                       ),
//                                                     ),
//                                                   ),
//                                                 )
//                                               : Container(
//                                                   margin: EdgeInsets.symmetric(
//                                                       vertical:
//                                                           media.height / 40),
//                                                   width: media.width / 5,
//                                                   height: media.width / 5,
//                                                   decoration: BoxDecoration(
//                                                       borderRadius:
//                                                           BorderRadius.all(
//                                                               Radius.circular(
//                                                                   12)),
//                                                       image: DecorationImage(
//                                                           image: FileImage(
//                                                               File(imageFile)),
//                                                           fit: BoxFit.cover))),
//                                     )),
//                                     Container(
//                                       width: media.width,
//                                       child: Text(
//                                         "Description",
//                                         textAlign: TextAlign.left,
//                                         textScaleFactor: 1.4,
//                                         style: TextStyle(
//                                           color: gray,
//                                         ),
//                                       ),
//                                     ),
//                                     Container(
//                                       margin: EdgeInsets.symmetric(
//                                           vertical: media.height / 40,
//                                           horizontal: 10),
//                                       padding: EdgeInsets.all(10),
//                                       decoration: BoxDecoration(
//                                           color: gray.withOpacity(0.5)),
//                                       width: media.width / 3,
//                                       height: media.width / 4,
//                                       child: TextField(
//                                         maxLines: null, // Set this
//                                         expands: true, // and this
//                                         keyboardType: TextInputType.multiline,
//                                       ),
//                                     )
//                                   ],
//                                 ),
//                               )),
//                               Expanded(
//                                   child: Center(
//                                 child: ListView(
//                                   children: [
//                                     SizedBox(
//                                       height: 10,
//                                     ),
//                                     Form(
//                                       key: _formKey,
//                                       child: Padding(
//                                         padding: const EdgeInsets.all(4),
//                                         child: Center(
//                                           child: SizedBox(
//                                             width: width / 4,
//                                             child: Column(
//                                               crossAxisAlignment:
//                                                   CrossAxisAlignment.start,
//                                               children: [
//                                                 label('Product name'),
//                                                 inputContain(
//                                                     width,
//                                                     'Enter the product name',
//                                                     nameController,
//                                                     (String value) {
//                                                   setState(() {
//                                                     nameController.text = value;
//                                                     user_name =
//                                                         nameController.text;
//                                                   });
//                                                 }, false, false),
//                                                 const SizedBox(height: 20),
//                                                 label('Reference'),
//                                                 inputContain(
//                                                     width,
//                                                     'Enter the product reference',
//                                                     refController,
//                                                     (String value) {
//                                                   setState(() {
//                                                     refController.text = value;
//                                                     user_email =
//                                                         refController.text;
//                                                   });
//                                                 }, false, false),
//                                                 const SizedBox(height: 20),
//                                                 label(' Location'),
//                                                 inputContain(
//                                                     width,
//                                                     ' Enter the product location',
//                                                     locationController,
//                                                     (String value) {
//                                                   setState(() {
//                                                     locationController.text =
//                                                         value;
//                                                     user_rule =
//                                                         locationController.text;
//                                                   });
//                                                 }, false, false),
//                                                 const SizedBox(height: 20),
//                                                 Row(
//                                                   children: [
//                                                     label(
//                                                         ' Products (${listSeach.length})'),
//                                                     InkWell(
//                                                       onTap: () {
//                                                         setState(() {
//                                                           showList = true;
//                                                         });

//                                                         Timer(
//                                                             Duration(
//                                                                 seconds: 5),
//                                                             () => setState(() {
//                                                                   loadList =
//                                                                       false;
//                                                                 }));
//                                                       },
//                                                       child: Container(
//                                                         padding: EdgeInsets
//                                                             .symmetric(
//                                                                 vertical: 5,
//                                                                 horizontal: 20),
//                                                         margin: EdgeInsets.only(
//                                                             left: 10),
//                                                         decoration: BoxDecoration(
//                                                             color: primaryColor,
//                                                             borderRadius:
//                                                                 BorderRadius
//                                                                     .all(Radius
//                                                                         .circular(
//                                                                             10))),
//                                                         child: Text(
//                                                           "ADD",
//                                                           style: TextStyle(
//                                                               color: white,
//                                                               fontWeight:
//                                                                   FontWeight
//                                                                       .bold),
//                                                         ),
//                                                       ),
//                                                     )
//                                                   ],
//                                                 ),
//                                                 Container(
//                                                   margin:
//                                                       EdgeInsets.only(top: 10),
//                                                   width: width,
//                                                   child: TextField(
//                                                     controller:
//                                                         searchController,
//                                                     decoration: InputDecoration(
//                                                       hintText: "Search",
//                                                       prefixIcon:
//                                                           Icon(Icons.search),
//                                                       border:
//                                                           OutlineInputBorder(),
//                                                     ),
//                                                     onChanged: (value) {
//                                                       setState(() {
//                                                         // searchProductsController.text = value;
//                                                       });
//                                                     },
//                                                   ),
//                                                 ),
//                                                 Container(
//                                                   margin:
//                                                       EdgeInsets.only(top: 10),
//                                                   width: width,
//                                                   height: width / 5,
//                                                   decoration: BoxDecoration(
//                                                       border: Border.all(
//                                                           color: white,
//                                                           width: 0.5)),
//                                                   child: ListView.builder(
//                                                       itemCount:
//                                                           listSeach.length,
//                                                       itemBuilder:
//                                                           (BuildContext context,
//                                                               int index) {
//                                                         if (searchController
//                                                                 .text
//                                                                 .isNotEmpty &&
//                                                             !listSeach[index]
//                                                                     ['name']
//                                                                 .toLowerCase()
//                                                                 .contains(
//                                                                     searchController
//                                                                         .text
//                                                                         .toLowerCase())) {
//                                                           return Container();
//                                                         } else {
//                                                           return ListTile(
//                                                               leading: InkWell(
//                                                                 onTap: () {
//                                                                   setState(() {
//                                                                     listSeach
//                                                                         .removeAt(
//                                                                             index);
//                                                                   });
//                                                                 },
//                                                                 child: Icon(
//                                                                   Icons.remove,
//                                                                   color:
//                                                                       primaryColor,
//                                                                 ),
//                                                               ),
//                                                               trailing: Text(
//                                                                 '${listSeach[index]['price']} ' +
//                                                                     company['currency']
//                                                                         [
//                                                                         'symbol'],
//                                                                 style: TextStyle(
//                                                                     color:
//                                                                         backgroundColor,
//                                                                     fontSize:
//                                                                         15),
//                                                               ),
//                                                               title: Text(
//                                                                   listSeach[
//                                                                           index]
//                                                                       [
//                                                                       'name']));
//                                                         }
//                                                       }),
//                                                 ),
//                                                 const SizedBox(height: 20),
//                                               ],
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               )),
//                             ],
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.symmetric(vertical: 4),
//                           child: SizedBox(
//                             width: width / 3,
//                             height: 47,
//                             child: ElevatedButton(
//                               onPressed: () {
//                                 if (_formKey.currentState!.validate()) {
//                                   // Form is valid, process the data here.
//                                   ScaffoldMessenger.of(context).showSnackBar(
//                                     const SnackBar(
//                                       content:
//                                           Text('Form submitted successfully!'),
//                                     ),
//                                   );
//                                   // Navigator.push(
//                                   //     context,
//                                   //     MaterialPageRoute(
//                                   //         builder: (context) =>
//                                   //             const TestPage()));
//                                 }
//                               },
//                               style: ElevatedButton.styleFrom(
//                                 //<-- SEE HERE
//                                 backgroundColor: primaryColor,
//                               ),
//                               child: Text(
//                                 widget.id != null ? 'Modify' : "Add",
//                                 style: TextStyle(fontSize: 24, color: white),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),

//                   showList
//                       ? Container(
//                           width: width,
//                           height: height,
//                           color: black.withOpacity(0.6),
//                           child: Stack(
//                             children: [
//                               Positioned(
//                                   right: 30,
//                                   top: 10,
//                                   child: CirularButton(
//                                     onClick: () {
//                                       setState(() {
//                                         showList = false;
//                                       });
//                                     },
//                                   )),
//                               Center(
//                                 child: Container(
//                                   padding: EdgeInsets.all(10),
//                                   width: width / 2,
//                                   height: width / 2,
//                                   color: white,
//                                   child: loadList
//                                       ? LoadPage()
//                                       : Column(
//                                           children: [
//                                             Container(
//                                               margin: EdgeInsets.only(top: 10),
//                                               width: width,
//                                               child: TextField(
//                                                 controller:
//                                                     searchListController,
//                                                 decoration: InputDecoration(
//                                                   hintText: "Search",
//                                                   prefixIcon:
//                                                       Icon(Icons.search),
//                                                   border: OutlineInputBorder(),
//                                                 ),
//                                                 onChanged: (value) {
//                                                   setState(() {
//                                                     // searchProductsController.text = value;
//                                                   });
//                                                 },
//                                               ),
//                                             ),
//                                             Expanded(
//                                               child: ListView.builder(
//                                                   itemCount: listLoad.length,
//                                                   itemBuilder:
//                                                       (BuildContext context,
//                                                           int index) {
//                                                     if ((searchListController
//                                                                 .text
//                                                                 .isNotEmpty &&
//                                                             !listLoad[index]
//                                                                     ['name']
//                                                                 .toLowerCase()
//                                                                 .contains(
//                                                                     searchListController
//                                                                         .text
//                                                                         .toLowerCase())) ||
//                                                         detrmineContainId(
//                                                             listLoad[index]
//                                                                 ['id'])) {
//                                                       return Container();
//                                                     } else {
//                                                       return ListTile(
//                                                           leading: InkWell(
//                                                             onTap: () {
//                                                               setState(() {
//                                                                 listSeach.add(
//                                                                     listLoad[
//                                                                         index]);
//                                                               });
//                                                             },
//                                                             child: Icon(
//                                                                 Icons.add,
//                                                                 color:
//                                                                     primaryColor),
//                                                           ),
//                                                           trailing: Text(
//                                                             '${listLoad[index]['price']} ' +
//                                                                 company['currency']
//                                                                     ['symbol'],
//                                                             style: TextStyle(
//                                                                 color:
//                                                                     backgroundColor,
//                                                                 fontSize: 15),
//                                                           ),
//                                                           title: Text(
//                                                               listLoad[index]
//                                                                   ['name']));
//                                                     }
//                                                   }),
//                                             )
//                                           ],
//                                         ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         )
//                       : Container(),

//                   //pick image bar
//                   // (_pickImage == true)
//                   //     ? Positioned(
//                   //         bottom: 0,
//                   //         child: InkWell(
//                   //           onTap: () {
//                   //             setState(() {
//                   //               _pickImage = false;
//                   //             });
//                   //           },
//                   //           child: Container(
//                   //             height: media.height * 1,
//                   //             width: media.width * 1,
//                   //             color: Colors.transparent.withOpacity(0.6),
//                   //             child: Column(
//                   //               mainAxisAlignment: MainAxisAlignment.end,
//                   //               children: [
//                   //                 Container(
//                   //                   // padding: EdgeInsets.all(media.width * 0.05),
//                   //                   width: media.width / 2,
//                   //                   decoration: BoxDecoration(
//                   //                       borderRadius: const BorderRadius.only(
//                   //                           topLeft: Radius.circular(25),
//                   //                           topRight: Radius.circular(25)),
//                   //                       border: Border.all(
//                   //                         color: primaryColor,
//                   //                         width: 1.2,
//                   //                       ),
//                   //                       color: white),
//                   //                   child: Column(
//                   //                     children: [
//                   //                       Container(
//                   //                         height: media.width * 0.02,
//                   //                         width: media.width * 0.15,
//                   //                         decoration: BoxDecoration(
//                   //                           borderRadius: BorderRadius.circular(
//                   //                               media.width * 0.01),
//                   //                           color: Colors.grey,
//                   //                         ),
//                   //                       ),
//                   //                       SizedBox(
//                   //                         height: media.width * 0.05,
//                   //                       ),
//                   //                       Row(
//                   //                         mainAxisAlignment:
//                   //                             MainAxisAlignment.spaceEvenly,
//                   //                         children: [
//                   //                           Column(
//                   //                             children: [
//                   //                               InkWell(
//                   //                                 onTap: () {
//                   //                                   pickImageFromCamera();
//                   //                                 },
//                   //                                 child: Container(
//                   //                                     height:
//                   //                                         media.width * 0.171,
//                   //                                     width:
//                   //                                         media.width * 0.171,
//                   //                                     decoration: BoxDecoration(
//                   //                                         border: Border.all(
//                   //                                             color: primaryColor,
//                   //                                             width: 1.2),
//                   //                                         borderRadius:
//                   //                                             BorderRadius
//                   //                                                 .circular(
//                   //                                                     12)),
//                   //                                     child: Icon(
//                   //                                       Icons
//                   //                                           .camera_alt_outlined,
//                   //                                       size:
//                   //                                           media.width * 0.064,
//                   //                                     )),
//                   //                               ),
//                   //                               SizedBox(
//                   //                                 height: media.width * 0.01,
//                   //                               ),
//                   //                               Text(
//                   //                                 "Camera",
//                   //                                 style:
//                   //                                     TextStyle(color: black),
//                   //                               )
//                   //                             ],
//                   //                           ),
//                   //                           Column(
//                   //                             children: [
//                   //                               InkWell(
//                   //                                 onTap: () {
//                   //                                   pickImageFromGallery();
//                   //                                 },
//                   //                                 child: Container(
//                   //                                     height:
//                   //                                         media.width * 0.171,
//                   //                                     width:
//                   //                                         media.width * 0.171,
//                   //                                     decoration: BoxDecoration(
//                   //                                         border: Border.all(
//                   //                                             color: primaryColor,
//                   //                                             width: 1.2),
//                   //                                         borderRadius:
//                   //                                             BorderRadius
//                   //                                                 .circular(
//                   //                                                     12)),
//                   //                                     child: Icon(
//                   //                                       Icons.image_outlined,
//                   //                                       size:
//                   //                                           media.width * 0.064,
//                   //                                     )),
//                   //                               ),
//                   //                               SizedBox(
//                   //                                 height: media.width * 0.01,
//                   //                               ),
//                   //                               Text(
//                   //                                 "Gallery",
//                   //                                 style:
//                   //                                     TextStyle(color: black),
//                   //                               )
//                   //                             ],
//                   //                           ),
//                   //                         ],
//                   //                       ),
//                   //                     ],
//                   //                   ),
//                   //                 ),
//                   //               ],
//                   //             ),
//                   //           ),
//                   //         ))
//                   //     : Container(),
//                 ],
//               ),
//             ));
//   }
// }
