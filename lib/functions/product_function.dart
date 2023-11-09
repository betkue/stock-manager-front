import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:stock_manager/config/constant.dart';
import 'package:stock_manager/config/parameter.dart';
import 'package:stock_manager/config/style.dart';
import 'package:stock_manager/functions/function.dart';

getProducts(int state) async {
  dynamic result;
  productsAll = [];
  productsAvailable = [];
  productsUnavalaible = [];

  try {
    var response = await http.get(
      Uri.parse('${api}product?state=${state - 1}'),
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
          productsAll =
              List<Map<String, dynamic>>.from(jsonDecode(response.body));
          break;
        case 1:
          productsUnavalaible =
              List<Map<String, dynamic>>.from(jsonDecode(response.body));
          break;
        case 2:
          productsAvailable =
              List<Map<String, dynamic>>.from(jsonDecode(response.body));
          break;
        default:
          productsAll =
              List<Map<String, dynamic>>.from(jsonDecode(response.body));
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

getLocations() async {
  dynamic result;
  try {
    var response = await http.get(
      Uri.parse('${api}location'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${token}'
      },
    );
    if (response.statusCode == 200) {
      locationsLoad =
          List<Map<String, dynamic>>.from(jsonDecode(response.body));
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

createProduct(
    Map<String, String> product, imageFile, BuildContext context) async {
  dynamic result;

  try {
    // debugPrint(product.toString());
    // List<int> imageBytes = imageFile.readAsBytesSync();
    // String base64Image = base64Encode(imageBytes);

    final response = http.MultipartRequest('POST', Uri.parse('${api}product'));
    response.headers.addAll({
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${token}'
    });
    if (imageFile != null) {
      response.files.add(await http.MultipartFile.fromPath('image', imageFile));
    }
    response.fields.addAll(product);

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

updateProduct(
    Map<String, String> product, imageFile, BuildContext context) async {
  dynamic result;

  try {
    // debugPrint(product.toString());
    // List<int> imageBytes = imageFile.readAsBytesSync();
    // String base64Image = base64Encode(imageBytes);
    // debugPrint(product.toString());

    final response =
        http.MultipartRequest('POST', Uri.parse('${api}product/update'));
    response.headers.addAll({
      // 'Content-Type': 'application/json',
      'Content-Type': 'application/x-www-form-urlencoded',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${token}'
    });
    if (imageFile != null) {
      response.files.add(await http.MultipartFile.fromPath('image', imageFile));
    }
    response.fields.addAll(product);

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

getProduct() async {
  dynamic result;
  try {
    var response = await http.get(
      Uri.parse('${api}product/single?product_id=${id_product}'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${token}'
      },
    );
    if (response.statusCode == 200) {
      await clearCache();

      product_single = Map<String, dynamic>.from(jsonDecode(response.body));

      debugPrint(product_single.toString());
      result = true;
    } else {
      product_single = {};

      debugPrint(response.body);

      result = false;
    }
  } catch (e) {
    product_single = {};

    result = false;
    if (e is SocketException) {
      internet = false;
    }
  }
  return result;
}

deleteProduct() async {
  dynamic result;
  try {
    var response = await http.delete(
      Uri.parse('${api}product?product_id=${id_product}'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${token}'
      },
    );
    if (response.statusCode == 200) {
      await clearCache();

      // product_single = Map<String, dynamic>.from(jsonDecode(response.body));

      debugPrint(product_single.toString());
      result = true;
      product_single = {};
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
