import 'dart:convert';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stock_manager/config/constant.dart';
import 'package:stock_manager/config/parameter.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher_string.dart';

convertDate(
  DateTime tm,
) {
  DateTime today = DateTime.now();
  Duration oneDay = Duration(days: 1);
  Duration twoDay = Duration(days: 2);
  Duration oneWeek = Duration(days: 7);
  String month = "";
  String date(String date, String day, String month, String year) {
    return '$day $month';
  }

  switch (tm.month) {
    case 1:
      month = "JAN";
      break;
    case 2:
      month = "FEB";
      break;
    case 3:
      month = "MAR";
      break;
    case 4:
      month = "APR";
      break;
    case 5:
      month = "MAY";
      break;
    case 6:
      month = "JUN";
      break;
    case 7:
      month = "JUL";
      break;
    case 8:
      month = "AUG";
      break;
    case 9:
      month = "SEPT";
      break;
    case 10:
      month = "OCT";
      break;
    case 11:
      month = "NOV";
      break;
    case 12:
      month = "DEC";
      break;
  }

  Duration difference = today.difference(tm);

  // if (difference.compareTo(oneDay) == 0) {
  //   return "today";
  // } else if (difference.compareTo(twoDay) < 1) {
  //   return "yesterday";
  // } else if (difference.compareTo(twoDay) > 1) {
  //   return "tomorrow";
  // }
  //  else
  if (difference.compareTo(oneWeek) < 1) {
    return date("", tm.day.toString(), month, "");
    // switch (tm.weekday) {
    //   case 1:
    //     return date("monday", tm.day.toString(), month, "");
    //   case 2:
    //     return date("tuesday", tm.day.toString(), month, "");
    //   // return "tuesday";
    //   case 3:
    //     return date("wednesday", tm.day.toString(), month, "");
    //   // return "wednesday";
    //   case 4:
    //     return date("thursday", tm.day.toString(), month, "");
    //   // return "thursday";
    //   case 5:
    //     return date("friday", tm.day.toString(), month, "");
    //   // return "friday";
    //   case 6:
    //     return date("saturday", tm.day.toString(), month, "");
    //   // return "saturday";
    //   case 7:
    //     return date("sunday", tm.day.toString(), month, "");
    //   // return "sunday";
    // }
  } else if (tm.year == today.year) {
    return date("", tm.day.toString(), month, "");
    // return '${tm.day}, $month';
  } else {
    return date("", tm.day.toString(), month, tm.year.toString());
    // return '${tm.day}, $month ${tm.year} ';
  }

  //return "";
}

internetTrue() {
  internet = true;
}

getDetailsOfDevice() async {
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.none) {
    internet = false;
  } else {
    internet = true;
  }
  try {
    pref = await SharedPreferences.getInstance();
  } catch (e) {
    if (e is SocketException) {
      internet = false;
    }
  }
}

setToken(String token) {
  pref.setString('token', token);
}

getToken() {
  var token = pref.getString('token');

  return token;
}

getLocalData() async {
  dynamic result;
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.none) {
    internet = false;
  } else {
    internet = true;
  }
  try {
    if (pref.containsKey('token')) {
      var tokens = getToken();
      if (tokens != null && tokens != '') {
        token = tokens;

        var responce = await getUserDetails(token);
        if (responce == true) {
          result = true;
        } else {
          result = false;
        }
      } else {
        result = false;
      }
      // debugPrint("no token");
    } else {
      result = false;
    }
  } catch (e) {
    if (e is SocketException) {
      result = 'no internet';
      internet = false;
    }
  }

  return result;
}

getUserDetails(token) async {
  dynamic result;
  try {
    var response = await http.get(
      Uri.parse('${api}user'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${token}'
      },
    );
    if (response.statusCode == 200) {
      await clearCache();

      user = Map<String, dynamic>.from(jsonDecode(response.body));
      result = true;
    } else {
      debugPrint("hum" + response.body);
      pref.remove('token');

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

getCountryCode() async {
  dynamic result;
  try {
    await getCurrencyCode();

    final response = await http.post(Uri.parse('${api}country'));

    if (response.statusCode == 200) {
      countries = jsonDecode(response.body)['data'];
      phcode =
          (countries.where((element) => element['default'] == true).isNotEmpty)
              ? countries.indexWhere((element) => element['default'] == true)
              : 0;
      country_id = countries[phcode]['id'];
      result = 'success';
    } else {
      debugPrint(response.body);
      result = 'error';
    }
  } catch (e) {
    if (e is SocketException) {
      internet = false;
      result = 'no internet';
    }
  }
  return result;
}

getCurrencyCode() async {
  dynamic result;
  try {
    final response = await http.post(Uri.parse('${api}currency'));

    if (response.statusCode == 200) {
      currencies = jsonDecode(response.body)['data'];
      curcode = 0;
      currency_id = currencies[curcode]['id'];
      result = 'success';
    } else {
      debugPrint(response.body);
      result = 'error';
    }
  } catch (e) {
    if (e is SocketException) {
      internet = false;
      result = 'no internet';
    }
  }
  return result;
}

showToast(String title, Color color, BuildContext context) {
  // Fluttertoast.showToast(
  //     msg: title,
  //     toastLength: Toast.LENGTH_SHORT,
  //     gravity: ToastGravity.CENTER,
  //     timeInSecForIosWeb: 1,
  //     backgroundColor: color,
  //     textColor: Colors.white,
  //     fontSize: 16.0);
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(title),
      backgroundColor: color,
    ),
  );
}

clearCache() async {
  // CacheManager.;
  // await DefaultCacheManager().emptyCache();
  // await DefaultCacheManager().getImageFile(url)
}
// String getParameterString(Map<String, String> data) {
//   final params = <String, String>{};
//   String url = "?";
//   for (final entry in data.entries) {
//     // if (entry.value != null) {
//     //   params[entry.key] = '${entry.value}';
//     // }

//     url = url + entry.key + "=" + entry.value + "&";
//   }
//   return url;
// }

// String getParameterString(Map<String, dynamic> data) {
//   final params = <String, String>{};
//   for (final entry in data.entries) {
//     if (entry.value != null) {
//       params[entry.key] = '${entry.value}';
//     }
//   }
//   return Uri.encodeComponent(jsonEncode(params));
// }
getVersion(token) async {
  dynamic result;
  try {
    var response = await http.get(
      Uri.parse('${api}user/version'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${token}'
      },
    );
    if (response.statusCode == 200) {
      await clearCache();

      Map<String, dynamic> jsonVal =
          Map<String, dynamic>.from(jsonDecode(response.body));

      version_app = jsonVal['version'];
      url_version = jsonVal['url'];
      url_help = jsonVal['url_help'];

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

openBrowser(browseUrl) async {
  if (await canLaunchUrlString(browseUrl)) {
    await launchUrlString(browseUrl);
  } else {
    throw 'Could not launch $browseUrl';
  }
}
