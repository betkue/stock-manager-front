import 'package:path/path.dart';
import 'package:async/async.dart';

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:stock_manager/config/constant.dart';
import 'package:stock_manager/config/parameter.dart';
import 'package:stock_manager/functions/function.dart';

registerUser(String name, String email, String password, String phone,
    File imageFile) async {
  dynamic result;
  try {
    // List<int> imageBytes = image.readAsBytesSync();
    // String base64Image = base64Encode(imageBytes);
    var uri = Uri.parse('${api}auth/register');

    var stream =
        new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
    // get file length
    var length = await imageFile.length();

    // create multipart request
    var request = new http.MultipartRequest("POST", uri);

    // multipart that takes file
    var multipartFile = new http.MultipartFile('image', stream, length,
        filename: basename(imageFile.path));
    // add file to multipart
    request.files.add(multipartFile);
    // Add the email field.
    request.fields['email'] = email;

    // Add the password field.
    request.fields['password'] = password;

    // Add the name field.
    request.fields['name'] = name;

    // Add the country_id field.
    request.fields['country_id'] = '$country_id';

    // Add the phone field.
    request.fields['phone'] = phone;

    // send
    var response = await request.send();

    // var response = await http.post(
    //   Uri.parse('${api}auth/register'),
    //   headers: {
    //     // 'Content-Type': 'application/json',
    //     'Content-Type': 'multipart/form-data'
    //   },
    //   body: {
    //     "email": email,
    //     "password": password,
    //     "name": name,
    //     "country_id": country_id,
    //     "phone": phone,
    //     "image": imageFile
    //   },
    // );

    switch (response.statusCode) {
      case 200:
        // user = Map<String, dynamic>.from(jsonDecode(response.body)['user']);
        // token = jsonDecode(response.body)['access_token'];

        setToken(token);
        result = true;
        break;
      case 401:
        result = "INput Error"; //jsonDecode(response.body)['message'];
        break;
      case 404:
        result = "Not Found";
        break;
      default:
        // debugPrint(response.body);
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

login(String email, String password) async {
  dynamic result;
  try {
    var response = await http.post(
      Uri.parse('${api}auth/login'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        "email": email,
        "password": password,
      }),
    );
    switch (response.statusCode) {
      case 200:
        user = Map<String, dynamic>.from(jsonDecode(response.body)['user']);
        token = jsonDecode(response.body)['access_token'];
        setToken(token);
        result = true;
        break;
      case 401:
        result = "INput Error"; //jsonDecode(response.body)['message'];
        break;
      case 404:
        result = "Not Found";
        break;
      default:
        debugPrint(response.body);
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
