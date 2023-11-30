import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:stock_manager/config/constant.dart';
import 'package:stock_manager/config/parameter.dart';
import 'package:stock_manager/config/style.dart';
import 'package:stock_manager/functions/function.dart';

getCustomers() async {
  dynamic result;
  customers = [];
  try {
    var response = await http.get(
      Uri.parse('${api}customer'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${token}'
      },
    );
    if (response.statusCode == 200) {
      await clearCache();
      customers = List<Map<String, dynamic>>.from(jsonDecode(response.body));

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

createCustomer(
    Map<String, String> customer, imageFile, BuildContext context) async {
  dynamic result;

  try {
    // debugPrint(customer.toString());
    // List<int> imageBytes = imageFile.readAsBytesSync();
    // String base64Image = base64Encode(imageBytes);

    final response = http.MultipartRequest('POST', Uri.parse('${api}customer'));
    response.headers.addAll({
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${token}'
    });
    if (imageFile != null) {
      response.files.add(await http.MultipartFile.fromPath('logo', imageFile));
    }
    response.fields.addAll(customer);

    var request = await response.send();
    var respon = await http.Response.fromStream(request);
    var jsonVal = jsonDecode(respon.body);
    debugPrint(respon.body);

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

    // debugPrint(e.toString());
  }

  return result;
}

updateCustomer(
    Map<String, String> customer, imageFile, BuildContext context) async {
  dynamic result;

  try {
    // debugPrint(customer.toString());
    // List<int> imageBytes = imageFile.readAsBytesSync();
    // String base64Image = base64Encode(imageBytes);
    // debugPrint(customer.toString());

    final response =
        http.MultipartRequest('POST', Uri.parse('${api}customer/update'));
    response.headers.addAll({
      // 'Content-Type': 'application/json',
      'Content-Type': 'application/x-www-form-urlencoded',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${token}'
    });
    if (imageFile != null) {
      response.files.add(await http.MultipartFile.fromPath('logo', imageFile));
    }
    response.fields.addAll(customer);

    var request = await response.send();
    var respon = await http.Response.fromStream(request);
    var jsonVal = jsonDecode(respon.body);
    debugPrint(respon.body);

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

    // debugPrint(e.toString());
  }

  return result;
}

getCustomer() async {
  dynamic result;
  try {
    var response = await http.get(
      Uri.parse('${api}customer/single?customer_id=${id_customer}'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${token}'
      },
    );
    if (response.statusCode == 200) {
      await clearCache();

      customer_single = Map<String, dynamic>.from(jsonDecode(response.body));

      debugPrint(customer_single.toString());
      result = true;
    } else {
      customer_single = {};

      debugPrint(response.body);

      result = false;
    }
  } catch (e) {
    customer_single = {};

    result = false;
    if (e is SocketException) {
      internet = false;
    }
  }
  return result;
}

deleteCustomer() async {
  dynamic result;
  try {
    var response = await http.delete(
      Uri.parse('${api}customer?customer_id=${id_customer}'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${token}'
      },
    );
    if (response.statusCode == 200) {
      await clearCache();

      // customer_single = Map<String, dynamic>.from(jsonDecode(response.body));

      debugPrint(customer_single.toString());
      result = true;
      customer_single = {};
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
