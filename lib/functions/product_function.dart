import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:stock_manager/config/constant.dart';
import 'package:stock_manager/config/parameter.dart';

getProducts(int state) async {
  dynamic result;
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
