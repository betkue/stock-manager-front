// ignore_for_file: must_be_immutable, prefer_const_constructors

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:stock_management/constant.dart';

class DetailProduct extends StatefulWidget {
  String? id;
  DetailProduct({super.key, this.id});

  @override
  State<DetailProduct> createState() => _DetailProductState();
}

class _DetailProductState extends State<DetailProduct> {
  @override
  Widget build(BuildContext context) {
    dynamic media = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: gray,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: [
            Expanded(
                child: Center(
              child: ListView(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: media.height / 40),
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
                          borderRadius: BorderRadius.all(Radius.circular(12)),
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
                                      BorderRadius.all(Radius.circular(12)),
                                  child: SizedBox(
                                    height: media.width / 8,
                                    width: media.width / 8,
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
                    ),
                  ),
                  Container(
                    width: media.width,
                    child: Text(
                      "Description",
                      textAlign: TextAlign.left,
                      textScaleFactor: 1.4,
                      style: TextStyle(
                        color: white,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(
                        vertical: media.height / 40, horizontal: 10),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(color: white),
                    width: media.width / 3,
                    height: media.width / 3,
                    child: TextField(
                      maxLines: null, // Set this
                      expands: true, // and this
                      keyboardType: TextInputType.multiline,
                    ),
                  )
                ],
              ),
            )),
            Expanded(
                child: Container(
              color: orange,
            )),
          ],
        ),
      ),
    );
  }
}
