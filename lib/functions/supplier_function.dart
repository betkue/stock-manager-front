import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:stock_manager/config/constant.dart';
import 'package:stock_manager/config/parameter.dart';
import 'package:stock_manager/config/style.dart';
import 'package:stock_manager/functions/function.dart';

getSuppliers() async {
  dynamic result;
  suppliers = [];
  try {
    var response = await http.get(
      Uri.parse('${api}supplier'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${token}'
      },
    );
    if (response.statusCode == 200) {
      await clearCache();
      suppliers = List<Map<String, dynamic>>.from(jsonDecode(response.body));

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

createSupplier(
    Map<String, String> supplier, imageFile, BuildContext context) async {
  dynamic result;

  try {
    // debugPrint(supplier.toString());
    // List<int> imageBytes = imageFile.readAsBytesSync();
    // String base64Image = base64Encode(imageBytes);

    final response = http.MultipartRequest('POST', Uri.parse('${api}supplier'));
    response.headers.addAll({
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${token}'
    });
    if (imageFile != null) {
      response.files.add(await http.MultipartFile.fromPath('logo', imageFile));
    }
    response.fields.addAll(supplier);

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

updateSupplier(
    Map<String, String> supplier, imageFile, BuildContext context) async {
  dynamic result;

  try {
    // debugPrint(supplier.toString());
    // List<int> imageBytes = imageFile.readAsBytesSync();
    // String base64Image = base64Encode(imageBytes);
    // debugPrint(supplier.toString());

    final response =
        http.MultipartRequest('POST', Uri.parse('${api}supplier/update'));
    response.headers.addAll({
      // 'Content-Type': 'application/json',
      'Content-Type': 'application/x-www-form-urlencoded',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${token}'
    });
    if (imageFile != null) {
      response.files.add(await http.MultipartFile.fromPath('logo', imageFile));
    }
    response.fields.addAll(supplier);

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

getSupplier() async {
  dynamic result;
  try {
    var response = await http.get(
      Uri.parse('${api}supplier/single?supplier_id=${id_supplier}'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${token}'
      },
    );
    if (response.statusCode == 200) {
      await clearCache();

      supplier_single = Map<String, dynamic>.from(jsonDecode(response.body));

      debugPrint(supplier_single.toString());
      result = true;
    } else {
      supplier_single = {};

      debugPrint(response.body);

      result = false;
    }
  } catch (e) {
    supplier_single = {};

    result = false;
    if (e is SocketException) {
      internet = false;
    }
  }
  return result;
}

deleteSupplier() async {
  dynamic result;
  try {
    var response = await http.delete(
      Uri.parse('${api}supplier?supplier_id=${id_supplier}'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${token}'
      },
    );
    if (response.statusCode == 200) {
      await clearCache();

      // supplier_single = Map<String, dynamic>.from(jsonDecode(response.body));

      debugPrint(supplier_single.toString());
      result = true;
      supplier_single = {};
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
