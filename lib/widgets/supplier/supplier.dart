import 'package:flutter/material.dart';
import 'package:stock_management/constant.dart';

Widget supplier(String id, String name, String quantity, String location,
    String image, String ref,BuildContext context) {
  if (searchSuppliersController.text.isNotEmpty &&
      !name.toLowerCase().contains(searchSuppliersController.text.toLowerCase())) {
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
          Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
              image: DecorationImage(image: NetworkImage(image)),
              color: orange,
              borderRadius:
                  BorderRadius.circular(MediaQuery.of(context).size.height),
              // color: widget.color ?? orange,
            ),
            // child: Image.network(
            //  ,
            //   // fit: BoxFit.cover,
            // )
          ),
          const SizedBox(width: 30),
          Expanded(child: Text(name)),
          Expanded(child: Text(ref)),
          Expanded(child: Text("Quantity : $quantity")),
          Expanded(child: Text("Location : $location")),
          Expanded(
            child: IconButton(
              onPressed: () {},
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
