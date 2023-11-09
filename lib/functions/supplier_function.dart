import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:stock_manager/config/constant.dart';
import 'package:stock_manager/config/parameter.dart';
import 'package:stock_manager/functions/function.dart';

getSuppliers() async {
  dynamic result;
  productsAll = [];
  productsAvailable = [];
  productsUnavalaible = [];

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
