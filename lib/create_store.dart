// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:stock_manager/config/parameter.dart';
import 'package:stock_manager/config/style.dart';
import 'package:stock_manager/functions/function.dart';
import 'package:stock_manager/widgets/circular_button.dart';
import 'package:stock_manager/widgets/input_form.dart';
import 'package:dotted_border/dotted_border.dart';
import 'info_page.dart';

class CreateStore extends StatefulWidget {
  CreateStore({super.key});

  @override
  State<CreateStore> createState() => _CreateStoreState();
}

class _CreateStoreState extends State<CreateStore> {
  final _formKey = GlobalKey<FormState>();
  dynamic imageFile;
  dynamic error;
  TextEditingController currencyController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController urlController = TextEditingController();
  List<TextEditingController> emails = [TextEditingController()];
  List<TextEditingController> contacts = [TextEditingController()];
  List<TextEditingController> faxs = [TextEditingController()];
  TextEditingController townController = TextEditingController();
  TextEditingController nrcController = TextEditingController();
  TextEditingController nCOntController = TextEditingController();
  TextEditingController tvaController = TextEditingController();
  TextEditingController zipController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  ImagePicker picker = ImagePicker();

  getGalleryPermission() async {
    var status = await Permission.photos.status;
    if (status != PermissionStatus.granted) {
      status = await Permission.photos.request();
    }
    return status;
  }

  //pick image from gallery
  pickImageFromGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        imageFile = pickedFile.path;
      }
    });
  }

  @override
  void initState() {
    countryController.text = countries[phcode]['name'];
    currencyController.text = currencies[curcode]['symbol'];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    dynamic media = MediaQuery.of(context).size;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: backgroundColor,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              //the page heading
              child: Container(
                padding: const EdgeInsets.all(20),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.shopping_cart,
                      color: primaryColor,
                      size: 50,
                    ),
                    Text(
                      ' Create your online store',
                      style: TextStyle(
                        fontSize: 38,
                        color: white,
                        fontWeight: FontWeight.bold,
                        shadows: <Shadow>[
                          Shadow(
                            offset: Offset(10.0, 10.0),
                            blurRadius: 5.0,
                            color: Color.fromARGB(166, 0, 0, 0),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              //Devide the page in to two column
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // First column (logo and description)
                  Expanded(
                    child: Center(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // Store logo
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 4),
                              child: Text(
                                'Store logo',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: white,
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  pickImageFromGallery();
                                });
                              },
                              child: (imageFile == null)
                                  ? Container(
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
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(12)),
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
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(12)),
                                                  child: SizedBox(
                                                    height: media.width / 10,
                                                    width: media.width / 10,
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
                                    )
                                  : Container(
                                      margin: EdgeInsets.symmetric(
                                          vertical: media.height / 40),
                                      width: media.width / 10,
                                      height: media.width / 10,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(12)),
                                          image: DecorationImage(
                                              image: FileImage(File(imageFile)),
                                              fit: BoxFit.cover))),
                            ),
                            /*Container(
                              width: width / 6.5,
                              height: 200,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                  color: white,
                                  width: 2,
                                  style: BorderStyle.solid,
                                ),
                              ),
                              child: Center(
                                child: InkWell(
                                  onTap: () {
                                    // Handle image input logic here
                                  },
                                  child: Container(
                                    width: 170,
                                    height: 170,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: white,
                                        width: 2,
                                      ),
                                    ),
                                    child: Icon(
                                      Icons.add,
                                      color: white,
                                    ),
                                  ),
                                ),
                              ),
                            ),*/
                            // description
                            const SizedBox(height: 100),
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 4),
                              child: Text(
                                'Description',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: white,
                                ),
                              ),
                            ),
                            Container(
                              width: width / 4,
                              height: 250,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.2),
                                    spreadRadius: 2,
                                    blurRadius: 2,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: TextField(
                                maxLines: null,
                                keyboardType: TextInputType.multiline,
                                decoration: InputDecoration(
                                  hintText: 'Enter your message',
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ]),
                    ),
                  ),
                  // second column
                  Expanded(
                    child: SingleChildScrollView(
                      child: Form(
                        key: _formKey,
                        child: Padding(
                          padding: EdgeInsets.all(4),
                          child: Center(
                            child: SizedBox(
                              width: width / 4,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  label('Store name'),
                                  inputContain(width, 'Store name'),
                                  const SizedBox(height: 20),
                                  label('Store URL'),
                                  inputContain(width, 'Store URL'),
                                  const SizedBox(height: 20),
                                  label('Contacts informations'),
                                  const SizedBox(height: 20),
                                  label(' Fax'),
                                  Wrap(
                                    crossAxisAlignment:
                                        WrapCrossAlignment.center,
                                    children: [
                                      inputContain(width, 'Fax'),
                                      InkWell(
                                          child: Icon(
                                        Icons.add_circle_rounded,
                                        size: 30,
                                        color: primaryColor,
                                      ))
                                    ],
                                  ),
                                  const SizedBox(height: 20),
                                  Wrap(
                                    crossAxisAlignment:
                                        WrapCrossAlignment.center,
                                    children: [
                                      inputContain(width, 'Email'),
                                      InkWell(
                                          child: Icon(
                                        Icons.add_circle_rounded,
                                        size: 30,
                                        color: primaryColor,
                                      ))
                                    ],
                                  ),
                                  const SizedBox(height: 20),
                                  Wrap(
                                    crossAxisAlignment:
                                        WrapCrossAlignment.center,
                                    children: [
                                      inputContain(width, 'Contact'),
                                      InkWell(
                                          child: Icon(
                                        Icons.add_circle_rounded,
                                        size: 30,
                                        color: primaryColor,
                                      ))
                                    ],
                                  ),
                                  const SizedBox(height: 20),
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
                                                    const EdgeInsets.all(10),
                                                content: StatefulBuilder(
                                                    builder:
                                                        (context, setState) {
                                                  return Container(
                                                    width: media.width * 0.9,
                                                    color: Colors.white,
                                                    child: Column(
                                                      children: [
                                                        SingleChildScrollView(
                                                          scrollDirection:
                                                              Axis.horizontal,
                                                          child: Row(
                                                            children: [
                                                              Container(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        left:
                                                                            20),
                                                                height: 40,
                                                                width: media
                                                                        .width *
                                                                    0.7,
                                                                decoration: BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            20),
                                                                    border: Border.all(
                                                                        color: Colors
                                                                            .grey,
                                                                        width:
                                                                            1.5)),
                                                                child:
                                                                    TextField(
                                                                  decoration: InputDecoration(
                                                                      border: InputBorder
                                                                          .none,
                                                                      hintText:
                                                                          "Search",
                                                                      hintStyle:
                                                                          TextStyle(
                                                                              fontSize: media.width / 70)),
                                                                  onChanged:
                                                                      (val) {
                                                                    setState(
                                                                        () {
                                                                      searchVal =
                                                                          val;
                                                                    });
                                                                  },
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                width: 20,
                                                              ),
                                                              Container(
                                                                child:
                                                                    CirularButton(
                                                                        onClick:
                                                                            () {
                                                                  Navigator.pop(
                                                                      context);
                                                                }),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                            height: 20),
                                                        Expanded(
                                                          child:
                                                              SingleChildScrollView(
                                                            child: Column(
                                                              children:
                                                                  countries
                                                                      .asMap()
                                                                      .map((i,
                                                                          value) {
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
                                      padding: EdgeInsets.only(left: 5),
                                      width: width / 4.5,
                                      height: 47,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: gray,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.2),
                                            spreadRadius: 2,
                                            blurRadius: 4,
                                            offset: Offset(0, 2),
                                          ),
                                        ],
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 15),
                                        child: Text(
                                          countryController.text,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  label('Town'),
                                  inputContain(width, 'Town'),
                                  const SizedBox(height: 20),
                                  label('Currency'),
                                  Container(
                                    width: width / 4.5,
                                    height: 37,
                                    margin: EdgeInsets.only(right: 10),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: gray,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.2),
                                          spreadRadius: 2,
                                          blurRadius: 4,
                                          offset: Offset(0, 2),
                                        ),
                                      ],
                                    ),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Container(
                                            height: 50,
                                            alignment: Alignment.center,
                                            width: media.width * 0.5,
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 5, vertical: 4),
                                              child: Text(
                                                "Currency",
                                                style: TextStyle(
                                                    // fontSize: 20,
                                                    ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width: 1,
                                          height: media.width * 0.0693,
                                          color: black,
                                        ),
                                        const SizedBox(width: 10),
                                        InkWell(
                                          onTap: () async {
                                            if (currencies.isNotEmpty) {
                                              // dialod box for select country for dial code
                                              await showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    var searchVal = '';
                                                    return AlertDialog(
                                                      insetPadding:
                                                          const EdgeInsets.all(
                                                              10),
                                                      content: StatefulBuilder(
                                                          builder: (context,
                                                              setState) {
                                                        return Container(
                                                          width:
                                                              media.width * 0.9,
                                                          color: Colors.white,
                                                          child: Column(
                                                            children: [
                                                              SingleChildScrollView(
                                                                scrollDirection:
                                                                    Axis.horizontal,
                                                                child: Row(
                                                                  children: [
                                                                    Container(
                                                                      padding: const EdgeInsets
                                                                              .only(
                                                                          left:
                                                                              20),
                                                                      height:
                                                                          40,
                                                                      width: media
                                                                              .width *
                                                                          0.7,
                                                                      decoration: BoxDecoration(
                                                                          borderRadius: BorderRadius.circular(
                                                                              20),
                                                                          border: Border.all(
                                                                              color: Colors.grey,
                                                                              width: 1.5)),
                                                                      child:
                                                                          TextField(
                                                                        decoration: InputDecoration(
                                                                            border: InputBorder
                                                                                .none,
                                                                            hintText:
                                                                                "Search",
                                                                            hintStyle:
                                                                                TextStyle(fontSize: media.width / 70)),
                                                                        onChanged:
                                                                            (val) {
                                                                          setState(
                                                                              () {
                                                                            searchVal =
                                                                                val;
                                                                          });
                                                                        },
                                                                      ),
                                                                    ),
                                                                    SizedBox(
                                                                      width: 20,
                                                                    ),
                                                                    Container(
                                                                      child: CirularButton(
                                                                          onClick:
                                                                              () {
                                                                        Navigator.pop(
                                                                            context);
                                                                      }),
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                  height: 20),
                                                              Expanded(
                                                                child:
                                                                    SingleChildScrollView(
                                                                  child: Column(
                                                                    children: currencies
                                                                        .asMap()
                                                                        .map((i, value) {
                                                                          return MapEntry(
                                                                              i,
                                                                              SizedBox(
                                                                                width: media.width * 0.9,
                                                                                child: (searchVal == '' && currencies[i]['symbol'] != null)
                                                                                    ? InkWell(
                                                                                        onTap: () {
                                                                                          setState(() {
                                                                                            curcode = i;
                                                                                            currency_id = currencies[i]['id'];
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
                                                                                                      SizedBox(width: media.width * 0.4, child: Text(currencies[i]['code'], style: TextStyle(fontSize: media.width / 70))),
                                                                                                      SizedBox(
                                                                                                        width: media.width * 0.02,
                                                                                                      ),
                                                                                                      SizedBox(
                                                                                                          width: media.width * 0.4,
                                                                                                          child: Text(
                                                                                                            currencies[i]['symbol'],
                                                                                                            style: TextStyle(fontSize: media.width / 70),
                                                                                                          )),
                                                                                                    ],
                                                                                                  ),
                                                                                                  // Text(
                                                                                                  //   currencies[i]['dial_code'],
                                                                                                  //   style: TextStyle(fontSize: media.width / 70),
                                                                                                  // )
                                                                                                ],
                                                                                              )),
                                                                                        ))
                                                                                    : (currencies[i]['code'] != null && currencies[i]['symbol'].toLowerCase().contains(searchVal.toLowerCase()))
                                                                                        ? InkWell(
                                                                                            onTap: () {
                                                                                              setState(() {
                                                                                                phcode = i;
                                                                                                currency_id = currencies[i]['id'];
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
                                                                                                            currencies[i]['code'],
                                                                                                            style: TextStyle(fontSize: media.width / 70),
                                                                                                          )),
                                                                                                      SizedBox(
                                                                                                        width: media.width * 0.02,
                                                                                                      ),
                                                                                                      SizedBox(
                                                                                                          width: media.width * 0.4,
                                                                                                          child: Text(
                                                                                                            currencies[i]['symbol'],
                                                                                                            style: TextStyle(fontSize: media.width / 70),
                                                                                                          )),
                                                                                                    ],
                                                                                                  ),
                                                                                                  // Text(
                                                                                                  //   currencies[i]['dial_code'],
                                                                                                  //   style: TextStyle(fontSize: media.width / 70),
                                                                                                  // )
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
                                              getCurrencyCode();
                                            }
                                            setState(() {});
                                          },
                                          //input field
                                          child: Container(
                                            height: 50,
                                            alignment: Alignment.center,
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  currencies[curcode]['symbol']
                                                      .toString(),
                                                  style: TextStyle(
                                                      color: textColor),
                                                ),
                                                const SizedBox(
                                                  width: 2,
                                                ),
                                                const Icon(
                                                    Icons.keyboard_arrow_down)
                                              ],
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 4),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  label(' N RC'),
                                  inputContain(width, ' NRC'),
                                  const SizedBox(height: 20),
                                  label(' N Cont'),
                                  inputContain(width, ' Ncont'),
                                  const SizedBox(height: 20),
                                  label(' TVA'),
                                  inputContain(width, ' 0.99'),
                                  const SizedBox(height: 20),
                                  label(' Zip code'),
                                  inputContain(width, ' Zip code'),
                                  /*
                                  const Padding(
                                    padding: EdgeInsets.symmetric(vertical: 4),
                                    child: Text(
                                      'Contacts informations',
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: white,
                                      ),
                                    ),
                                  ),
                                  Wrap(
                                    crossAxisAlignment:
                                        WrapCrossAlignment.center,
                                    children: [
                                      Container(
                                        width: width / 4.5,
                                        height: 37,
                                        margin: EdgeInsets.only(right: 5),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          color: white,
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.2),
                                              spreadRadius: 2,
                                              blurRadius: 2,
                                              offset: const Offset(0, 2),
                                            ),
                                          ],
                                        ),
                                        child: TextFormField(
                                          decoration: const InputDecoration(
                                            border: OutlineInputBorder(),
                                            hintText: 'Enter your Email',
                                          ),
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return 'Please enter your Email.';
                                            }
                                            return null;
                                          },
                                        ),
                                      ),
                                      Icon(
                                        Icons.add_circle_rounded,
                                        color: primaryColor,
                                        size: 30,
                                      )
                                    ],
                                  ),
                                  const SizedBox(height: 20),
                                  Wrap(
                                    crossAxisAlignment:
                                        WrapCrossAlignment.center,
                                    children: [
                                      Container(
                                        width: width / 4.5,
                                        height: 37,
                                        margin: EdgeInsets.only(right: 5),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          color: white,
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.2),
                                              spreadRadius: 2,
                                              blurRadius: 2,
                                              offset: const Offset(0, 2),
                                            ),
                                          ],
                                        ),
                                        child: TextFormField(
                                          decoration: const InputDecoration(
                                            border: OutlineInputBorder(),
                                            hintText: 'Enter your Contact',
                                          ),
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return 'Please enter your Contact.';
                                            }
                                            return null;
                                          },
                                        ),
                                      ),
                                      Icon(
                                        Icons.add_circle_rounded,
                                        color: primaryColor,
                                        size: 30,
                                      )
                                    ],
                                  ),
                                  const SizedBox(height: 20),
                                  const Padding(
                                    padding: EdgeInsets.symmetric(vertical: 4),
                                    child: Text(
                                      'Store location',
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: white,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: width / 4.5,
                                    height: 37,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: white,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.2),
                                          spreadRadius: 2,
                                          blurRadius: 2,
                                          offset: const Offset(0, 2),
                                        ),
                                      ],
                                    ),
                                    child: TextFormField(
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                        hintText: 'Enter your email',
                                      ),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please enter your email.';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  const Padding(
                                    padding: EdgeInsets.symmetric(vertical: 4),
                                    child: Text(
                                      ' Trade register number',
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: white,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: width / 4.5,
                                    height: 37,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: white,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.2),
                                          spreadRadius: 2,
                                          blurRadius: 2,
                                          offset: const Offset(0, 2),
                                        ),
                                      ],
                                    ),
                                    child: TextFormField(
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                        hintText: 'Enter Trade register number',
                                      ),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please enter the Trade register number.';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  const Padding(
                                    padding: EdgeInsets.symmetric(vertical: 4),
                                    child: Text(
                                      'Taxpayer identification number',
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: white,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: width / 4.5,
                                    height: 37,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: white,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.2),
                                          spreadRadius: 2,
                                          blurRadius: 2,
                                          offset: const Offset(0, 2),
                                        ),
                                      ],
                                    ),
                                    child: TextFormField(
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                        hintText:
                                            'Enter the Taxpayer identification number',
                                      ),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please enter the Taxpayer identification number.';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  const Padding(
                                    padding: EdgeInsets.symmetric(vertical: 4),
                                    child: Text(
                                      'Fax',
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: white,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: width / 4.5,
                                    height: 37,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: white,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.2),
                                          spreadRadius: 2,
                                          blurRadius: 2,
                                          offset: const Offset(0, 2),
                                        ),
                                      ],
                                    ),
                                    child: TextFormField(
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                        hintText: 'Enter the Fax',
                                      ),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please enter the Fax.';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  const Padding(
                                    padding: EdgeInsets.symmetric(vertical: 4),
                                    child: Text(
                                      'Zip code',
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: white,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: width / 4.5,
                                    height: 37,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: white,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.2),
                                          spreadRadius: 2,
                                          blurRadius: 2,
                                          offset: const Offset(0, 2),
                                        ),
                                      ],
                                    ),
                                    child: TextFormField(
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                        hintText: 'Enter the Zip code',
                                      ),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please enter the Zip code.';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),*/
                                  const SizedBox(height: 20),
                                  Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 4),
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
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        InfoPage()));
                                          }
                                        },
                                        style: ElevatedButton.styleFrom(
                                          //<-- SEE HERE
                                          backgroundColor: primaryColor,
                                        ),
                                        child: const Text(
                                          'Submit',
                                          style: TextStyle(fontSize: 24),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 120),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
