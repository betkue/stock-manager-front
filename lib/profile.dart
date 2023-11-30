// ignore_for_file: prefer_const_constructors

import 'dart:async';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:stock_manager/config/constant.dart';
import 'package:stock_manager/config/parameter.dart';
import 'package:stock_manager/config/style.dart';
import 'package:stock_manager/functions/auth_function.dart';
import 'package:stock_manager/functions/function.dart';
import 'package:stock_manager/load_page.dart';
import 'package:stock_manager/widgets/account/account.dart';
import 'package:stock_manager/test.dart';
import 'package:stock_manager/widgets/circular_button.dart';
import 'package:stock_manager/widgets/help_button.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  final _formKey = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController statuController = TextEditingController();
  bool load = true;
  ImagePicker picker = ImagePicker();

  bool _pickImage = false;
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

  @override
  void initState() {
    Timer(
        Duration(seconds: timedalay),
        () => setState(() {
              load = false;
            }));
    country_id = user['country']['id'];
    for (var i = 0; i < countries.length; i++) {
      var element = countries[i];

      if (element['id'] == country_id) {
        phcode = i;
      }
    }
    nameController.text = user['name'];
    emailController.text = user['email'];
    // passwordController.text = user['password'];
    phoneController.text = user['phone'];
    statuController.text = user['rule'] == 0 ? "Admin" : "Manager";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    dynamic media = MediaQuery.of(context).size;

    return load
        ? LoadPage()
        : Scaffold(
            // backgroundColor: gray
            appBar: AppBar(
              backgroundColor: white,
              toolbarHeight: 80,
              elevation: 0,
              automaticallyImplyLeading: false,
              actions: const [
                HelpButton(),
                SizedBox(
                  width: 20,
                )
              ],
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 40,
                      width: 50,
                      child: Container(),
                    ),
                  ),
                  const SizedBox(width: 18),
                  ElevatedButton(
                    onPressed: () {
                      logout(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: red,
                      shadowColor: primaryColor,
                      surfaceTintColor: primaryColor,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10), // Set the button's padding
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.logout,
                          color: white,
                        ),
                        Text(
                          "Log Out",
                          style: TextStyle(
                              fontSize: 16,
                              color: white,
                              fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            body: SafeArea(
                child: Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Row(
                children: [
                  // Expanded(
                  //     flex: 7,
                  //     child: Column(
                  //       children: [
                  //         for (var i = 0; i < users.length; i++)
                  //           Padding(
                  //             padding: const EdgeInsets.symmetric(
                  //                 horizontal: 10, vertical: 10),
                  //             child: SingleChildScrollView(
                  //               scrollDirection: Axis.horizontal,
                  //               child: Row(
                  //                 children: [
                  //                   Container(
                  //                     margin: const EdgeInsets.symmetric(
                  //                         vertical: 10),
                  //                     width: 50,
                  //                     height: 50,
                  //                     decoration: BoxDecoration(
                  //                         color: primaryColor,
                  //                         borderRadius: BorderRadius.all(
                  //                           Radius.circular(MediaQuery.of(context)
                  //                               .size
                  //                               .height),
                  //                         ),
                  //                         image: DecorationImage(
                  //                             image:
                  //                                 NetworkImage(users[i]['image']))
                  //                         // color: gray,
                  //                         ),
                  //                     // child: Image.network(
                  //                     //   user['image'],
                  //                     //   fit: BoxFit.cover,
                  //                     // ),
                  //                   ),
                  //                   const SizedBox(
                  //                     width: 30,
                  //                   ),
                  //                   /*Expanded(child: Text("Marceline Paule II $i"),
                  //                           ),*/
                  //                   Column(
                  //                     mainAxisAlignment: MainAxisAlignment.start,
                  //                     crossAxisAlignment:
                  //                         CrossAxisAlignment.start,
                  //                     children: [
                  //                       Wrap(
                  //                         crossAxisAlignment:
                  //                             WrapCrossAlignment.center,
                  //                         children: [
                  //                           Icon(
                  //                             Icons.circle,
                  //                             size: 10,
                  //                             color: users[i]['active']
                  //                                 ? backgroundColor
                  //                                 : gray,
                  //                           ),
                  //                           SizedBox(
                  //                             width: 5,
                  //                           ),
                  //                           Text(
                  //                             users[i]['name'],
                  //                             overflow: TextOverflow.ellipsis,
                  //                           ),
                  //                         ],
                  //                       ),
                  //                       Text(users[i]['email']),
                  //                     ],
                  //                   ),
                  //                 ],
                  //               ),
                  //             ),
                  //           ),
                  //         const SizedBox(
                  //           height: 30,
                  //         ),
                  //       ],
                  //     )),
                  // Expanded(
                  //     flex: 5,
                  //     child: SingleChildScrollView(
                  //       child: Column(
                  //         children: [
                  //           const Align(
                  //             alignment: Alignment.center,
                  //             child: InkWell(
                  //               child: Text("Store Account"),
                  //             ),
                  //           ),
                  //           Container(
                  //             width: 150,
                  //             height: 150,
                  //             decoration: BoxDecoration(
                  //               image: DecorationImage(
                  //                   image: NetworkImage(company['logo'])),
                  //               borderRadius: BorderRadius.all(
                  //                 Radius.circular(
                  //                     MediaQuery.of(context).size.height),
                  //               ),
                  //               // color: widget.color ?? orange,
                  //             ),
                  //             // child: Image.asset(
                  //             //   "assets/images/avatar.png",
                  //             //   fit: BoxFit.cover,
                  //             // )
                  //           ),
                  //           Form(
                  //             key: _formKey2,
                  //             child: Padding(
                  //               padding: const EdgeInsets.all(4),
                  //               child: Center(
                  //                 child: SizedBox(
                  //                   width: width / 4,
                  //                   child: Column(
                  //                     crossAxisAlignment:
                  //                         CrossAxisAlignment.start,
                  //                     children: [
                  //                       label('Name'),
                  //                       inputContain(
                  //                           width, 'Name', nameController,
                  //                           (String value) {
                  //                         setState(() {
                  //                           nameController.text = value;
                  //                           user_name = nameController.text;
                  //                         });
                  //                       }, false, false),
                  //                       const SizedBox(height: 20),
                  //                       label('Email'),
                  //                       inputContain(
                  //                           width, 'Email', emailController,
                  //                           (String value) {
                  //                         setState(() {
                  //                           emailController.text = value;
                  //                           user_email = emailController.text;
                  //                         });
                  //                       }, false, false),
                  //                       const SizedBox(height: 20),
                  //                       label(' Password'),
                  //                       inputContain(width, ' Password',
                  //                           passwordController, (String value) {
                  //                         passwordController.text = value;
                  //                         user_password =
                  //                             passwordController.text;
                  //                       }, true, false),
                  //                       const SizedBox(height: 20),
                  //                       label(' Phone'),
                  //                       inputContain(
                  //                           width, ' Phone', phoneController,
                  //                           (String value) {
                  //                         setState(() {
                  //                           phoneController.text = value;
                  //                           user_phone = phoneController.text;
                  //                         });
                  //                       }, false, false),
                  //                       const SizedBox(height: 20),
                  //                       label(' Status'),
                  //                       inputContain(
                  //                           width, ' Status', statuController,
                  //                           (String value) {
                  //                         setState(() {
                  //                           statuController.text = value;
                  //                           user_rule = statuController.text;
                  //                         });
                  //                       }, false, true),
                  //                       const SizedBox(height: 20),
                  //                       Padding(
                  //                         padding: const EdgeInsets.symmetric(
                  //                             vertical: 4),
                  //                         child: SizedBox(
                  //                           width: width / 4.5,
                  //                           height: 47,
                  //                           child: ElevatedButton(
                  //                             onPressed: () {
                  //                               if (_formKey.currentState!
                  //                                   .validate()) {
                  //                                 // Form is valid, process the data here.
                  //                                 ScaffoldMessenger.of(context)
                  //                                     .showSnackBar(
                  //                                   const SnackBar(
                  //                                     content: Text(
                  //                                         'Form submitted successfully!'),
                  //                                   ),
                  //                                 );
                  //                                 Navigator.push(
                  //                                     context,
                  //                                     MaterialPageRoute(
                  //                                         builder: (context) =>
                  //                                             const TestPage()));
                  //                               }
                  //                             },
                  //                             style: ElevatedButton.styleFrom(
                  //                               //<-- SEE HERE
                  //                               backgroundColor: primaryColor,
                  //                             ),
                  //                             child: const Text(
                  //                               'Modify',
                  //                               style: TextStyle(
                  //                                   fontSize: 24, color: white),
                  //                             ),
                  //                           ),
                  //                         ),
                  //                       ),
                  //                     ],
                  //                   ),
                  //                 ),
                  //               ),
                  //             ),
                  //           ),
                  //         ],
                  //       ),
                  //     )),

                  Expanded(
                      flex: 5,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            const Align(
                              alignment: Alignment.center,
                              child: InkWell(
                                child: Text("User Account"),
                              ),
                            ),
                            Container(
                              width: 150,
                              height: 150,
                              decoration: BoxDecoration(
                                // image: DecorationImage(
                                //     image: NetworkImage(user['image'])),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(
                                      MediaQuery.of(context).size.height),
                                ),

                                // color: widget.color ?? orange,
                              ),
                              child: Center(
                                  child: InkWell(
                                onTap: () {
                                  setState(() {
                                    pickImageFromGallery();
                                  });
                                },
                                child: (user['image'] != null &&
                                        imageFile == null)
                                    ? Container(
                                        margin: EdgeInsets.symmetric(
                                            vertical: media.height / 40),
                                        width: media.width / 5,
                                        height: media.width / 5,
                                        child: CachedNetworkImage(
                                          imageUrl: user['image'],
                                          placeholder: (context, url) =>
                                              CircularProgressIndicator(),
                                          errorWidget: (context, url, error) =>
                                              Icon(Icons.error),
                                          fit: BoxFit.contain,
                                        ),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(12)),
                                          // image: DecorationImage(
                                          //     image: NetworkImage(
                                          //       product_single[
                                          //           'image'],
                                          //     ),
                                          //     fit: BoxFit.cover)
                                        ))
                                    : (imageFile == null)
                                        ? Container(
                                            margin: EdgeInsets.symmetric(
                                                vertical: media.height / 40),
                                            width: media.width / 5,
                                            height: media.width / 5,
                                            child: DottedBorder(
                                              borderType: BorderType.RRect,
                                              color: black,
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
                                                      borderType:
                                                          BorderType.RRect,
                                                      radius:
                                                          Radius.circular(12),
                                                      padding:
                                                          EdgeInsets.all(6),
                                                      dashPattern: [8, 8],
                                                      color: gray,
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    12)),
                                                        child: SizedBox(
                                                          height:
                                                              media.width / 8,
                                                          width:
                                                              media.width / 8,
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
                                                vertical: media.height / 40),
                                            width: media.width / 5,
                                            height: media.width / 5,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(12)),
                                                image: DecorationImage(
                                                    image: FileImage(
                                                        File(imageFile)),
                                                    fit: BoxFit.cover))),
                              )),

                              // child: Image.asset(
                              //   "assets/images/avatar.png",
                              //   fit: BoxFit.cover,
                              // )
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
                                        label('Name'),
                                        inputContain(
                                            width, 'Name', nameController,
                                            (String value) {
                                          setState(() {
                                            nameController.text = value;
                                            user_name = nameController.text;
                                          });
                                        }, false, false),
                                        const SizedBox(height: 20),
                                        label('Email'),
                                        inputContain(
                                            width, 'Email', emailController,
                                            (String value) {
                                          setState(() {
                                            emailController.text = value;
                                            user_email = emailController.text;
                                          });
                                        }, false, false),
                                        const SizedBox(height: 20),
                                        label(' Phone'),
                                        Container(
                                          width: width / 4.5,
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10),
                                          height: 47,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
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
                                                                            padding:
                                                                                const EdgeInsets.only(left: 20),
                                                                            height:
                                                                                40,
                                                                            width:
                                                                                media.width * 0.7,
                                                                            decoration:
                                                                                BoxDecoration(borderRadius: BorderRadius.circular(20), border: Border.all(color: Colors.grey, width: 1.5)),
                                                                            child:
                                                                                TextField(
                                                                              decoration: InputDecoration(border: InputBorder.none, hintText: "Search", hintStyle: TextStyle(fontSize: media.width / 70)),
                                                                              onChanged: (val) {
                                                                                setState(() {
                                                                                  searchVal = val;
                                                                                });
                                                                              },
                                                                            ),
                                                                          ),
                                                                          SizedBox(
                                                                            width:
                                                                                20,
                                                                          ),
                                                                          Container(
                                                                            child:
                                                                                CirularButton(onClick: () {
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
                                                //input field
                                                child: Container(
                                                  height: 50,
                                                  color: gray,
                                                  alignment: Alignment.center,
                                                  child: Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        countries[phcode]
                                                                ['dial_code']
                                                            .toString(),
                                                        style: TextStyle(
                                                            color: textColor),
                                                      ),
                                                      const SizedBox(
                                                        width: 2,
                                                      ),
                                                      const Icon(Icons
                                                          .keyboard_arrow_down)
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                width: 1,
                                                height: media.width * 0.0693,
                                                color: gray,
                                              ),
                                              // const SizedBox(height: ,),
                                              const SizedBox(width: 10),
                                              Expanded(
                                                child: Container(
                                                  height: 50,
                                                  color: gray,
                                                  alignment: Alignment.center,
                                                  width: media.width,
                                                  child: TextField(
                                                    controller: phoneController,
                                                    cursorColor: black,
                                                    inputFormatters: [
                                                      FilteringTextInputFormatter
                                                          .allow(
                                                              RegExp('[0-9]')),
                                                    ],
                                                    maxLength: countries[phcode]
                                                        ['dial_max_length'],
                                                    keyboardType:
                                                        TextInputType.phone,
                                                    onChanged: (value) {
                                                      setState(() {});
                                                    },
                                                    decoration: InputDecoration(
                                                      labelStyle: TextStyle(
                                                          color: black),
                                                      border: InputBorder.none,
                                                    ),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        const SizedBox(height: 20),
                                        label(' Password (optional)'),
                                        inputContain(width, ' Password',
                                            passwordController, (String value) {
                                          passwordController.text = value;
                                          user_password =
                                              passwordController.text;
                                        }, true, false),
                                        const SizedBox(height: 20),
                                        label(' Confirm Password (optional)'),
                                        inputContain(width, ' Confirm Password',
                                            confirmPasswordController,
                                            (String value) {
                                          confirmPasswordController.text =
                                              value;
                                        }, true, false),
                                        const SizedBox(height: 20),
                                        // inputContain(
                                        //     width, ' Phone', phoneController,
                                        //     (String value) {
                                        //   setState(() {
                                        //     phoneController.text = value;
                                        //     user_phone = phoneController.text;
                                        //   });
                                        // }, false, false),
                                        // const SizedBox(height: 20),
                                        label(' Status'),
                                        inputContain(
                                            width, ' Status', statuController,
                                            (String value) {
                                          setState(() {
                                            statuController.text = value;
                                            user_rule = statuController.text;
                                          });
                                        }, false, true),
                                        const SizedBox(height: 20),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 4),
                                          child: SizedBox(
                                            width: width / 4.5,
                                            height: 47,
                                            child: ElevatedButton(
                                              onPressed: () async {
                                                // if (_formKey.currentState!
                                                //     .validate()) {
                                                // Form is valid, process the data here.
                                                if (passwordController.text ==
                                                    confirmPasswordController
                                                        .text) {
                                                  setState(() {
                                                    load = true;
                                                  });
                                                  var result = await UpdateUser(
                                                      nameController.text,
                                                      emailController.text,
                                                      passwordController.text,
                                                      phoneController.text,
                                                      imageFile,
                                                      context);

                                                  if (result == true) {
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(
                                                      const SnackBar(
                                                        content: Text(
                                                            'Form submitted successfully!'),
                                                      ),
                                                    );
                                                  }
                                                  setState(() {
                                                    load = false;
                                                  });
                                                } else {
                                                  showToast(
                                                      "Put the same password or nothing",
                                                      red,
                                                      context);
                                                }
                                                // Navigator.push(
                                                //     context,
                                                //     MaterialPageRoute(
                                                //         builder: (context) =>
                                                //             const TestPage()));
                                              }
                                              // }
                                              ,
                                              style: ElevatedButton.styleFrom(
                                                //<-- SEE HERE
                                                backgroundColor: primaryColor,
                                              ),
                                              child: const Text(
                                                'Modify',
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
                      ))
                ],
              ),
            )),
          );
  }
}
