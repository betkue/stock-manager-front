import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:stock_manager/config/constant.dart';
import 'package:stock_manager/config/parameter.dart';
import 'package:stock_manager/config/style.dart';

Widget supplier(String id, String name, String sigle, String location,
    String image, String ref, BuildContext context, Function setParent) {
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
          ClipRRect(
            borderRadius:
                BorderRadius.circular(MediaQuery.of(context).size.height / 30),
            child: Container(
              height: 100,
              width: 100,
              child: CachedNetworkImage(
                imageUrl: image,
                fit: BoxFit.cover,
                placeholder: (context, url) => CircularProgressIndicator(),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),

              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
                // color: widget.color ?? orange,
              ),
              // child: Image.network(
              //  ,
              //   // fit: BoxFit.cover,
              // )
            ),
          ),
          const SizedBox(width: 30),
          Expanded(child: Text(name)),
          Expanded(child: Text(ref)),
          Expanded(child: Text("$sigle")),
          Expanded(child: Text("Location : $location")),
          Expanded(
            child: IconButton(
              onPressed: () {
                id_supplier = id;
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
