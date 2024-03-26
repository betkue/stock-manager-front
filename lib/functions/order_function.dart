import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:stock_manager/config/constant.dart';
import 'package:http/http.dart' as http;
import 'package:stock_manager/config/parameter.dart';
import 'package:stock_manager/config/style.dart';
import 'package:stock_manager/functions/function.dart';

getOrders(int state) async {
  dynamic result;
  salesAll = [];
  salesPending = [];
  salesDelivered = [];

  try {
    var response = await http.get(
      Uri.parse('${api}order?state=${state - 1}'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${token}'
      },
    );
    if (response.statusCode == 200) {
      await clearCache();
      debugPrint(state.toString());
      switch (state) {
        case 0:
          salesAll = List<Map<String, dynamic>>.from(jsonDecode(response.body));
          break;
        case 1:
          salesPending =
              List<Map<String, dynamic>>.from(jsonDecode(response.body));
          break;
        case 2:
          salesDelivered =
              List<Map<String, dynamic>>.from(jsonDecode(response.body));
          break;
        default:
          salesAll = List<Map<String, dynamic>>.from(jsonDecode(response.body));
      }
      result = true;
    } else {
      debugPrint(response.body);

      result = false;
    }
  } catch (e) {
    result = false;
    if (e is SocketException) {
      internet = false;
    }
  }
  return result;
}

createOrder(Map<String, Object> data, BuildContext context) async {
  dynamic result;

  try {
    // debugPrint(product.toString());
    // List<int> imageBytes = imageFile.readAsBytesSync();
    // String base64Image = base64Encode(imageBytes);

    String jsonData = jsonEncode(data);

    final response = http.MultipartRequest('POST', Uri.parse('${api}order'));
    response.headers.addAll({
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${token}'
    });
    // if (imageFile != null) {
    //   response.files.add(await http.MultipartFile.fromPath('image', imageFile));
    // }
    response.fields.addAll({
      "data": jsonData,
    });

    var request = await response.send();
    var respon = await http.Response.fromStream(request);
    // var jsonVal = jsonDecode(respon.body);
    // debugPrint(respon.body);

    switch (respon.statusCode) {
      case 200:
        await clearCache();

        result = true;
        break;
      default:
        // debugPrint(response.body);
        showToast("Server Error", red, context);

        result = false;
    }
  } catch (e) {
    result = false;
    if (e is SocketException) {
      internet = false;
    }

    debugPrint(e.toString());
  }

  return result;
}

getOrder() async {
  dynamic result;
  try {
    var response = await http.get(
      Uri.parse('${api}order/single?order_id=${id_salle}'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${token}'
      },
    );
    if (response.statusCode == 200) {
      await clearCache();

      salle_single = Map<String, dynamic>.from(jsonDecode(response.body));

      debugPrint(salle_single.toString());
      result = true;
    } else {
      salle_single = {};

      debugPrint(response.body);

      result = false;
    }
  } catch (e) {
    salle_single = {};

    result = false;
    if (e is SocketException) {
      internet = false;
    }
  }
  return result;
}
