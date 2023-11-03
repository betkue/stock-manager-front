// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:stock_manager/config/constant.dart';
import 'package:stock_manager/config/style.dart';
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
                                  label('Store location'),
                                  inputContain(width, 'Country'),
                                  const SizedBox(height: 20),
                                  inputContain(width, 'Town'),
                                  const SizedBox(height: 20),
                                  label(' Trade register number'),
                                  inputContain(width, ' Trade register number'),
                                  const SizedBox(height: 20),
                                  label(' Taxpayer identification number'),
                                  inputContain(
                                      width, ' Taxpayer identification number'),
                                  const SizedBox(height: 20),
                                  label(' Fax'),
                                  inputContain(width, ' Fax'),
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
