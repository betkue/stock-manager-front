import 'package:path/path.dart';
import 'package:async/async.dart';

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:stock_manager/config/constant.dart';
import 'package:stock_manager/config/parameter.dart';
import 'package:stock_manager/config/style.dart';
import 'package:stock_manager/functions/function.dart';

registerUser(String name, String email, String password, String phone,
    dynamic imageFile) async {
  dynamic result;
  try {
    // List<int> imageBytes = imageFile.readAsBytesSync();
    // String base64Image = base64Encode(imageBytes);

    final response =
        http.MultipartRequest('POST', Uri.parse('${api}auth/register'));
    response.headers.addAll({'Content-Type': 'application/json'});
    if (imageFile != null) {
      response.files.add(await http.MultipartFile.fromPath('image', imageFile));
    }
    response.fields.addAll({
      "email": email,
      "password": password,
      "name": name,
      "country_id": "$country_id",
      "phone": phone,
    });
    // var response = await http.post(
    //   Uri.parse('${api}auth/register'),
    //   headers: {
    //     'Content-Type': 'application/json',
    //     // 'Content-Type': 'multipart/form-data'
    //   },
    //   body: jsonEncode({
    //     "email": email,
    //     "password": password,
    //     "name": name,
    //     "country_id": country_id,
    //     "phone": phone,
    //     "image": base64Image
    //   }),
    // );
    var request = await response.send();
    var respon = await http.Response.fromStream(request);
    var jsonVal = jsonDecode(respon.body);
    switch (respon.statusCode) {
      case 200:
        user = Map<String, dynamic>.from(jsonVal);
        token = jsonVal['access_token'];

        setToken(token);
        result = true;
        break;
      case 401:
        showToast(jsonVal['special'], red);
        result = "INput Error"; //jsonDecode(response.body)['message'];
        break;
      case 404:
        showToast(jsonVal['special'], red);
        result = "Not Found";
        break;
      default:
        // debugPrint(response.body);
        showToast("Server Error", red);
        result = "Server errr";
    }
  } catch (e) {
    result = "Server errr";
    if (e is SocketException) {
      internet = false;
    }

    debugPrint(e.toString());
  }
  return result;
}

login(String email, String password) async {
  dynamic result;
  try {
    var response = await http.post(
      Uri.parse('${api}auth/login'),
      headers: {
        'Content-Type': 'application/json',
      },
      body:
          jsonEncode({"email": email, "password": password, "fromApi": "true"}),
    );
    var jsonVal = jsonDecode(response.body);
    switch (response.statusCode) {
      case 200:
        user = Map<String, dynamic>.from(jsonVal);
        token = jsonVal['access_token'];
        setToken(token);
        result = true;
        break;
      case 401:
        result = "INput Error"; //jsonDecode(response.body)['message'];
        showToast(jsonVal['special'], red);
        break;
      case 404:
        result = "Not Found";
        showToast(jsonVal['special'], red);
        break;
      default:
        debugPrint(response.body);
        showToast("Server Error", red);
        result = "Server errr";
    }
  } catch (e) {
    result = "Server errr";
    if (e is SocketException) {
      debugPrint(e.toString());
      internet = false;
    }
  }
  return result;
}

upload(File imageFile) async {
  // open a bytestream
  var stream =
      new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
  // get file length
  var length = await imageFile.length();

  // string to uri
  var uri = Uri.parse("http://ip:8082/composer/predict");

  // create multipart request
  var request = new http.MultipartRequest("POST", uri);

  // multipart that takes file
  var multipartFile = new http.MultipartFile('file', stream, length,
      filename: basename(imageFile.path));

  // add file to multipart
  request.files.add(multipartFile);

  // send
  var response = await request.send();
  print(response.statusCode);

  // listen for response
  response.stream.transform(utf8.decoder).listen((value) {
    print(value);
  });
}
