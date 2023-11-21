// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:stock_manager/config/constant.dart';
import 'package:stock_manager/config/parameter.dart';
import 'package:stock_manager/config/style.dart';
import 'package:stock_manager/create_store.dart';
import 'package:stock_manager/functions/auth_function.dart';
import 'package:stock_manager/functions/function.dart';
import 'package:stock_manager/login.dart';
import 'package:stock_manager/main.dart';
import 'package:stock_manager/pages/no_internet.dart';
import 'package:stock_manager/widgets/circular_button.dart';
import 'package:stock_manager/widgets/two_column.dart';

class Signin extends StatefulWidget {
  const Signin({super.key});

  @override
  State<Signin> createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  bool loading = true;

  dynamic imageFile;
  dynamic error;

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
    countryCode();
    super.initState();
  }

  countryCode() async {
    await getCountryCode();
    if (mounted) {
      setState(() {
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    dynamic media = MediaQuery.of(context).size;
    return countries.isEmpty
        ? Scaffold(
            backgroundColor: backgroundColor,
            body: NoInternet(onTap: () {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => MyApp()),
                  (route) => false);
            }),
          )
        : TwoColumnPage(
            loading: loading,
            block: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      'Create your account',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFFFFFFF)),
                    ),
                  ),
                  const SizedBox(height: 20),
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
                            width: media.width / 10,
                            height: media.width / 10,
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
                                  height: media.width / 10,
                                  width: media.width / 10,

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
                                          height: media.width / 20,
                                          width: media.width / 20,
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
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12)),
                                image: DecorationImage(
                                    image: FileImage(File(imageFile)),
                                    fit: BoxFit.cover))),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: 250,
                    height: 47,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 4,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: TextField(
                      controller: nameController,
                      cursorColor: black,
                      onChanged: (value) {
                        setState(() {});
                      },
                      decoration: InputDecoration(
                        labelStyle: TextStyle(color: black),
                        labelText: 'Name',
                        border: InputBorder.none,
                        prefixIcon: Icon(Icons.person),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  // const SizedBox(height: 20),
                  // Container(
                  //   width: 250,
                  //   height: 47,
                  //   decoration: BoxDecoration(
                  //     borderRadius: BorderRadius.circular(5),
                  //     color: Colors.white,
                  //     boxShadow: [
                  //       BoxShadow(
                  //         color: Colors.grey.withOpacity(0.2),
                  //         spreadRadius: 2,
                  //         blurRadius: 4,
                  //         offset: Offset(0, 2),
                  //       ),
                  //     ],
                  //   ),
                  //   child: TextField(
                  //     controller: phoneController,
                  //     cursorColor: black,
                  //     keyboardType: TextInputType.phone,
                  //     onChanged: (value) {
                  //       setState(() {});
                  //     },
                  //     decoration: InputDecoration(
                  //       labelStyle: TextStyle(color: black),
                  //       labelText: 'Phone',
                  //       border: InputBorder.none,
                  //       prefixIcon: Icon(Icons.phone),
                  //     ),
                  //   ),
                  // ),

                  Container(
                    width: 250,
                    height: 47,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.white,
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
                        InkWell(
                          onTap: () async {
                            if (countries.isNotEmpty) {
                              //dialod box for select country for dial code
                              await showDialog(
                                  context: context,
                                  builder: (context) {
                                    var searchVal = '';
                                    return AlertDialog(
                                      insetPadding: const EdgeInsets.all(10),
                                      content: StatefulBuilder(
                                          builder: (context, setState) {
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
                                                          const EdgeInsets.only(
                                                              left: 20),
                                                      height: 40,
                                                      width: media.width * 0.7,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(20),
                                                          border: Border.all(
                                                              color:
                                                                  Colors.grey,
                                                              width: 1.5)),
                                                      child: TextField(
                                                        decoration: InputDecoration(
                                                            border: InputBorder
                                                                .none,
                                                            hintText: "Search",
                                                            hintStyle: TextStyle(
                                                                fontSize: media
                                                                        .width /
                                                                    70)),
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
                                                      child: CirularButton(
                                                          onClick: () {
                                                        Navigator.pop(context);
                                                      }),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              const SizedBox(height: 20),
                                              Expanded(
                                                child: SingleChildScrollView(
                                                  child: Column(
                                                    children: countries
                                                        .asMap()
                                                        .map((i, value) {
                                                          return MapEntry(
                                                              i,
                                                              SizedBox(
                                                                width: media
                                                                        .width *
                                                                    0.9,
                                                                child: (searchVal ==
                                                                            '' &&
                                                                        countries[i]['flag'] !=
                                                                            null)
                                                                    ? InkWell(
                                                                        onTap:
                                                                            () {
                                                                          setState(
                                                                              () {
                                                                            phcode =
                                                                                i;
                                                                            country_id =
                                                                                countries[i]['id'];
                                                                          });
                                                                          Navigator.pop(
                                                                              context);
                                                                        },
                                                                        child:
                                                                            Container(
                                                                          padding: const EdgeInsets.only(
                                                                              top: 10,
                                                                              bottom: 10),
                                                                          color:
                                                                              Colors.white,
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
                                                                    : (countries[i]['flag'] !=
                                                                                null &&
                                                                            countries[i]['name'].toLowerCase().contains(searchVal
                                                                                .toLowerCase()))
                                                                        ? InkWell(
                                                                            onTap:
                                                                                () {
                                                                              setState(() {
                                                                                phcode = i;
                                                                                country_id = countries[i]['id'];
                                                                              });
                                                                              Navigator.pop(context);
                                                                            },
                                                                            child:
                                                                                Container(
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
                          //input field
                          child: Container(
                            height: 50,
                            alignment: Alignment.center,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  countries[phcode]['dial_code'].toString(),
                                  style: TextStyle(color: textColor),
                                ),
                                const SizedBox(
                                  width: 2,
                                ),
                                const Icon(Icons.keyboard_arrow_down)
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 4),
                        Container(
                          width: 1,
                          height: media.width * 0.0693,
                          color: buttonColor,
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Container(
                            height: 50,
                            alignment: Alignment.center,
                            width: media.width * 0.5,
                            child: TextField(
                              controller: phoneController,
                              cursorColor: black,
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp('[0-9]')),
                              ],
                              maxLength: countries[phcode]['dial_max_length'],
                              keyboardType: TextInputType.phone,
                              onChanged: (value) {
                                setState(() {});
                              },
                              decoration: InputDecoration(
                                labelStyle: TextStyle(color: black),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  const SizedBox(height: 20),
                  Container(
                    width: 250,
                    height: 47,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 4,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: TextField(
                      controller: emailController,
                      cursorColor: black,
                      keyboardType: TextInputType.emailAddress,
                      onChanged: (value) {
                        setState(() {});
                      },
                      decoration: InputDecoration(
                        labelStyle: TextStyle(color: black),
                        labelText: 'Email',
                        border: InputBorder.none,
                        prefixIcon: Icon(Icons.email),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    width: 250,
                    height: 47,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 4,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: TextField(
                      controller: passwordController,
                      cursorColor: black,
                      onChanged: (value) {
                        setState(() {});
                      },
                      obscureText: true,
                      decoration: InputDecoration(
                        labelStyle: TextStyle(color: black),
                        labelText: 'Password',
                        border: InputBorder.none,
                        prefixIcon: Icon(Icons.key),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    width: 250,
                    height: 47,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 4,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: TextField(
                      controller: confirmPasswordController,
                      cursorColor: black,
                      obscureText: true,
                      onChanged: (value) {
                        setState(() {});
                      },
                      decoration: InputDecoration(
                        labelStyle: TextStyle(color: black),
                        labelText: 'Confirm Password',
                        border: InputBorder.none,
                        prefixIcon: Icon(Icons.key),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Wrap(
                      children: [
                        Text(
                          "You don’t have an account ? ",
                          style: TextStyle(fontSize: 12, color: white),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const LogIn()));
                          },
                          child: Text(
                            "LogIn",
                            style: TextStyle(fontSize: 12, color: primaryColor),
                          ),
                        ),
                      ],
                    ),
                  ),
                  (nameController.text.isNotEmpty &&
                          emailController.text.isNotEmpty &&
                          passwordController.text.isNotEmpty &&
                          phoneController.text.isNotEmpty &&
                          imageFile != null &&
                          (passwordController.text ==
                              confirmPasswordController.text) &&
                          confirmPasswordController.text.isNotEmpty)
                      ? Padding(
                          padding: EdgeInsets.all(16.0),
                          child: SizedBox(
                            width: 250,
                            height: 47,
                            child: ElevatedButton(
                              onPressed: () async {
                                error = null;
                                setState(() {
                                  loading = true;
                                });
                                var result = await registerUser(
                                    nameController.text,
                                    emailController.text,
                                    passwordController.text,
                                    phoneController.text,
                                    imageFile,
                                    context);

                                if (result == true) {
                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => MyApp()),
                                      (route) => false);
                                } else if (result == false) {
                                  error = "echec";
                                } else {
                                  setState(() {
                                    error = result;
                                  });
                                }
                                setState(() {
                                  loading = false;
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                //<-- SEE HERE
                                backgroundColor: backgroundColor,
                              ),
                              child: Text('SignIn',
                                  style: TextStyle(fontSize: 24,color: white)),
                            ),
                          ),
                        )
                      : Container(),
                ],
              ),
            ),
          );
  }
}
