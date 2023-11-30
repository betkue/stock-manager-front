import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:stock_manager/config/constant.dart';
import 'package:stock_manager/config/parameter.dart';
import 'package:stock_manager/config/style.dart';
import 'package:stock_manager/functions/product_function.dart';

Widget movement(
    String id,
    String name,
    String ref,
    String new_qte,
    bool is_entry,
    String last_qte,
    String date,
    String location,
    String image,
    String? coment,
    BuildContext context,
    Function setParent,
    bool deletable) {
  if (searchMovementController.text.isNotEmpty &&
      (!ref
              .toLowerCase()
              .contains(searchMovementController.text.toLowerCase()) &&
          !name
              .toLowerCase()
              .contains(searchMovementController.text.toLowerCase()))) {
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
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Text(
                  date,
                  textAlign: TextAlign.start,
                  style: TextStyle(color: gray, fontStyle: FontStyle.italic),
                ),
                SizedBox(
                  width: 20,
                ),
                Container(
                  padding: EdgeInsets.all(8),
                  width: 100,
                  decoration: BoxDecoration(
                      color: is_entry ? green : red,
                      borderRadius: BorderRadius.circular(12)),
                  child: Center(
                    child: Text(
                      is_entry ? "Entry" : "Exit",
                      style: TextStyle(color: white),
                    ),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Text(
                  coment == null ? "" : " : $coment",
                  textAlign: TextAlign.start,
                  maxLines: 1,
                  style: TextStyle(color: gray, fontStyle: FontStyle.italic),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(
                    MediaQuery.of(context).size.height / 30),
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
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name),
                    Text(
                      ref,
                      style: TextStyle(color: gray),
                    )
                  ],
                ),
              ),
              Expanded(child: Text("${is_entry ? "Entry" : "Exit"}")),
              Expanded(
                  child: Text(
                      "${is_entry ? (double.parse(new_qte) - double.parse(last_qte)) : double.parse(last_qte) - double.parse(new_qte)}")),
              Expanded(child: Text("Last Qte : $last_qte")),
              Expanded(child: Text("New Qte : $new_qte")),
              Expanded(child: Text("Location : $location")),
              deletable
                  ? Expanded(
                      child: IconButton(
                        onPressed: () async {
                          setParent();
                          id_movement = id;
                          await deleteMovement();
                          setParent();
                        },
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.orange,
                        ),
                      ),
                    )
                  : Container(),
            ],
          ),
        ],
      ),
    ),
  );
}
