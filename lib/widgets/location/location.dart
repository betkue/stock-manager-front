import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:stock_manager/config/constant.dart';
import 'package:stock_manager/config/parameter.dart';
import 'package:stock_manager/config/style.dart';

Widget location(String id, String name, String location, String qte,
 BuildContext context, Function setParent) {
  if (searchSuppliersController.text.isNotEmpty &&
      !name
          .toLowerCase()
          .contains(searchSuppliersController.text.toLowerCase())) {
    return Container();
  }
  return Container(
    color: Colors.white,
    child: Container(
      margin: const EdgeInsets.all(8.0),
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
         const SizedBox(width: 30),
          Expanded(child: Text(name)),
          Expanded(child: Text("Location : $location")),
          Expanded(child: Text("Products : $qte")),
          Expanded(
            child: IconButton(
              onPressed: () {
                id_location = id;
                setParent();
              },
              icon: const Icon(
                Icons.edit_outlined,
                color: Colors.orange,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
