// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:stock_management/constant.dart';

Padding label(String label) => Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 20,
          color: Color(0xFFFFFFFF),
        ),
      ),
    );

Container inputContain(double width, String hintText) => Container(
      width: width / 4.5,
      // height: 37,
      margin: EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        // color: backgroundColor,
      ),
      child: TextFormField(
        maxLines: 1,
        cursorColor: black,

        // maxLength: 30,
        decoration: inputDecoration(hintText),
        validator: (value) {
          if (value!.isEmpty) {
            return 'Please enter the $hintText.';
          }
          return null;
        },
      ),
    );
