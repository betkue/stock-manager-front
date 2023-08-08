// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:stock_management/constant.dart';

Widget purchase(String imagePath, String productName, String price, int state,
    BuildContext context) {
  return Container(
    // color: gray,
    decoration: BoxDecoration(color: white, boxShadow: [
      BoxShadow(
          color: gray,
          spreadRadius: 2,
          blurRadius: 5,
          offset: const Offset(0, 3))
    ]),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Stack(
          children: [
            Image.asset(
              height: 200,
              width: double.infinity,
              imagePath,
              fit: BoxFit.cover,
            ),
            Positioned(
              child: Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: orange,
                  // borderRadius: BorderRadius.circular(4.0),
                ),
                child: Text(
                  state == 0
                      ? "Pending"
                      : state == 1
                          ? "Incomplete"
                          : "Complete",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: white,
                  ),
                ),
              ),
            ),
          ],
        ),
        Text(
          productName,
          maxLines: 2,
          textAlign: TextAlign.center,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Text(
                price.toString(),
                textAlign: TextAlign.center,
                maxLines: 1,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: state == 1 ? black : orange),
              ),
            ),
            Icon(Icons.edit_outlined, color: state == 1 ? orange : black),
            SizedBox(width: 10),
          ],
        ),
        Container(
          width: MediaQuery.of(context).size.width / 8,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            // color: state == 1 ? orange : gray
          ),
        ),
        const SizedBox(height: 5),
      ],
    ),
  );
}
