import 'package:flutter/material.dart';
import 'package:stock_management/constant.dart';

Widget supplier(String id, String name, String quantity, String location,
    String image, String ref) {
  if (searchSuppliersController.text.isNotEmpty &&
      !name.contains(searchSuppliersController.text)) {
    return Container();
  }
  return Container(
    color: white,
    child: Container(
      margin: const EdgeInsets.all(8.0),
      padding: const EdgeInsets.all(8.0),
      decoration: const BoxDecoration(
        color: white,
        boxShadow: [
          BoxShadow(
            color: gray,
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
              decoration: const BoxDecoration(
                  // borderRadius: BorderRadius.circular(
                  //   MediaQuery.of(context).size.height,
                  // ),
                  ),
              child: Image.network(
                height: 160,
                width: double.infinity,
                image,
                fit: BoxFit.cover,
              )),
          const SizedBox(width: 30),
          Expanded(child: Text(name)),
          Expanded(child: Text("Ref: $ref")),
          Expanded(child: Text("Num_Products $quantity")),
          Expanded(child: Text("Location $location")),
          Expanded(
            child: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.edit_outlined,
                color: orange,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
