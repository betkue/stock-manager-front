// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:stock_manager/constant.dart';

Widget purchase(String imagePath, String productName, String price, int state,
    int paiement_state, BuildContext context,String id, Function setParent) {
  if (searchPurchasesController.text.isNotEmpty &&
      !productName
          .toLowerCase()
          .contains(searchPurchasesController.text.toLowerCase())) {
    return Container();
  }
  return Container(
    // color: gray,
    decoration: BoxDecoration(color: white, boxShadow: [
      BoxShadow(
          color: gray,
          spreadRadius: 2,
          blurRadius: 5,
          offset: const Offset(0, 3)),
    ]),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Stack(
          children: [
            Image.network(
              height: 160,
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
            Expanded(
              child: InkWell(
                onTap: () {
                  id_purshase = id;
                setParent();
                },
                child: Icon(Icons.edit_document)),
            ),
            // SizedBox(width: 10),
          ],
        ),
        Wrap(
          children: [
            Text("Paiement State : "),
            Text(
              state == 0
                  ? "Pending"
                  : state == 1
                      ? "Incomplete"
                      : "Complete",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: orange,
              ),
            )
          ],
        ),
        SizedBox(width: 10),
      ],
    ),
  );
}
