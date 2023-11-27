// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:stock_manager/config/constant.dart';
import 'package:stock_manager/config/parameter.dart';
import 'package:stock_manager/config/style.dart';

 products(
    String imagePath,
    String productName,
    String productFeature,
    String productRef,
    String? clothing,
    String? weight,
    String price,
    int state,
    BuildContext context,
    String id,
    String qte,
    Function setParent) {
  if (searchProductsController.text.isNotEmpty &&
      (!productRef
              .toLowerCase()
              .contains(searchProductsController.text.toLowerCase()) &&
          !productName
              .toLowerCase()
              .contains(searchProductsController.text.toLowerCase()))) {
    return 404;
  }

 

  return Container(
    key: Key(id),
    // color: gray,
    decoration: BoxDecoration(color: white, boxShadow: [
      BoxShadow(
          color: gray,
          spreadRadius: 2,
          blurRadius: 5,
          offset: const Offset(0, 3))
    ]),
    child: InkWell(
      onTap: () {
        id_product = id;
        setParent();
      },
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Image.network(
            //   height: 160,
            //   width: double.infinity,
            //   imagePath,
            //   fit: BoxFit.contain,
            // ),
            CachedNetworkImage(
              height: 100,
              width: double.infinity,
              imageUrl: imagePath,
              fit: BoxFit.contain,
              placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
            Text(
              productName,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 5,
            ),

            Text(
              productFeature,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              productRef,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              textScaleFactor: 0.9,
              style: TextStyle(color: gray),
            ),
            SizedBox(
              height: 5,
            ),
            clothing == null || clothing == "No Clothing" || clothing == ""
                ? Container()
                : Text(
                    "$clothing",
                    maxLines: 2,
                    textAlign: TextAlign.center,
                  ),
            SizedBox(
              height: 5,
            ),
            weight == null || weight == "Nothing" || weight == ""
                ? Container()
                : Text(
                    "$weight Kg",
                    maxLines: 2,
                    textAlign: TextAlign.center,
                  ),

            state != 1
                ? Container()
                : Text(
                    "$qte",
                    maxLines: 2,
                    textAlign: TextAlign.center,
                  ),
            SizedBox(
              height: 5,
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
                        color: state == 1 ? black : primaryColor),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              width: MediaQuery.of(context).size.width / 8,
              // padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                // color: state == 1 ? orange : gray
              ),
              child: Text(
                state == 1 ? "Available" : "Unavailable",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: state == 1
                        ? primaryColor
                        : black), //color: state == 1 ? white : black),
              ),
            ),
            const SizedBox(height: 5),
          ],
        ),
      ),
    ),
  );
}
