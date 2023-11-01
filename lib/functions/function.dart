
import 'package:stock_manager/config/constant.dart';

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
  // var connectivityResult = await (Connectivity().checkConnectivity());
  // if (connectivityResult == ConnectivityResult.none) {
  //   internet = false;
  // } else {
  //   internet = true;
  // }
  // try {
  //   pref = await SharedPreferences.getInstance();

  // } catch (e) {
  //   if (e is SocketException) {
  //     internet = false;
  //   }
  // }
}

getLocalData() async {
  // dynamic result;
  // var connectivityResult = await (Connectivity().checkConnectivity());
  // if (connectivityResult == ConnectivityResult.none) {
  //   internet = false;
  // } else {
  //   internet = true;
  // }
  // try {
  //   if (pref.containsKey('userId')) {
  //     var tokens = pref.getString('userId');
  //     if (tokens != null && tokens != '') {
  //       userID = tokens;

  //       var responce = await getUserDetails(userID);
  //       if (responce == true) {
  //         result = true;
  //       } else if (responce == false) {
  //         result = false;
  //       }
  //     } else {
  //       result = false;
  //     }
  //   } else {
  //     result = false;
  //   }
  // } catch (e) {
  //   if (e is SocketException) {
  //     result = 'no internet';
  //     internet = false;
  //   }
  // }

  // if (pref.containsKey('name')) {
  //   nameController.text = pref.getString('name') ?? "";
  // } else {
  //   var pref = await SharedPreferences.getInstance();
  //   pref.setString("name", userDetails['name'] ?? "");
  // }

  // if (pref.containsKey('address')) {
  //   addressController.text = pref.getString('address') ?? "";
  // } else {
  //   pref.setString("address", "");
  // }

  // if (pref.containsKey('phones')) {
  //   List<String> phones = pref.getStringList("phones");
  //   for (var element in phones) {
  //     phoneControllers.add(TextEditingController(text: element));
  //   }
  //   // .text =;
  // } else {
  //   pref.setStringList("phones", [""]);
  // }

  // if (pref.containsKey('code')) {
  //   codeController.text = pref.getString('code') ?? "";
  // } else {
  //   pref.setString("code", "");
  // }

  // return result;
}
