import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:stock_manager/config/constant.dart';
import 'package:stock_manager/config/parameter.dart';
import 'package:stock_manager/functions/function.dart';

getStore() async {
  dynamic result;
  try {
    var response = await http.post(
      Uri.parse('${api}store'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${token}'
      },
    );
    if (response.statusCode == 200) {
      company = Map<String, dynamic>.from(jsonDecode(response.body));
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

createStore(Map<String, Object> data, imageFile) async {
  // List<int> imageBytes = imageFile.readAsBytesSync();
  // String base64Image = base64Encode(imageBytes);
  try {
    String jsonData = jsonEncode(data);

    final response =
        http.MultipartRequest('POST', Uri.parse('${api}store/create'));
    response.headers.addAll({
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${token}'
    });
    if (imageFile != null) {
      response.files.add(await http.MultipartFile.fromPath('image', imageFile));
    }
    response.fields.addAll({
      "data": jsonData,
      "country_id": "$country_id",
      'currency_id': "${currency_id ?? 1}"
    });
    var request = await response.send();
    var respon = await http.Response.fromStream(request);
    var jsonVal = jsonDecode(respon.body);
    debugPrint(jsonVal.toString());
    if (respon.statusCode == 200) {
    await  clearCache();

      company = jsonVal;
      return true;
    } else {
      return false;
    }
  } catch (e) {
    debugPrint(e.toString());
    if (e is SocketException) {
      internet = false;
    }
  }
  return false;
}

getDashboard() async {
  dynamic result;
  try {
    var response = await http.post(
      Uri.parse('${api}store/dashboard'),
      body: jsonEncode({"store_id": "${company['id']}"}),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${token}'
      },
    );
    if (response.statusCode == 200) {
      dashboard = Map<String, dynamic>.from(jsonDecode(response.body));
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
    debugPrint(e.toString());
  }
  return result;
}
