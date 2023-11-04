// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:stock_manager/config/constant.dart';
import 'package:stock_manager/config/style.dart';

Padding label(String label, {bool required = false}) => Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Wrap(
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 20,
              color: Color(0xFFFFFFFF),
            ),
          ),
          Text(
            required ? ' *' : "",
            style: TextStyle(
              fontSize: 20,
              color: red,
            ),
          ),
        ],
      ),
    );

Container inputContain(
        double width, String hintText, TextEditingController controller,
        {bool required = false}) =>
    Container(
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
        controller: controller,

        // maxLength: 30,
        decoration: inputDecoration(hintText),
        validator: (value) {
          if (value!.isEmpty && required) {
            return 'Please enter the $hintText.';
          }
          return null;
        },
      ),
    );
