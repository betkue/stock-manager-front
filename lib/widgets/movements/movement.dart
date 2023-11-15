import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:stock_manager/config/constant.dart';
import 'package:stock_manager/config/parameter.dart';
import 'package:stock_manager/config/style.dart';

Widget movement(
    String id,
    name,
    String new_qte,
    bool is_entry,
    String last_qte,
    String date,
    String location,
    String image,
    BuildContext context,
    Function setParent) {
  if (searchMovementController.text.isNotEmpty &&
      !name
          .toLowerCase()
          .contains(searchCustomersController.text.toLowerCase())) {
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
          Expanded(child: Text("${is_entry ? "Entry" : "Exit"}")),
          Expanded(child: Text("$last_qte")),
          Expanded(child: Text("Last Qte : $last_qte")),
          Expanded(child: Text("New Qte : $new_qte")),
          Expanded(child: Text("Location : $location")),
          Expanded(
            child: IconButton(
              onPressed: () {
                id_movement = id;
                setParent();
              },
              icon: const Icon(
                Icons.delete,
                color: Colors.orange,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
