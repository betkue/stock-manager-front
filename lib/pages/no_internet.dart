import 'package:flutter/material.dart';
import 'package:stock_manager/config/constant.dart';
import 'package:stock_manager/config/style.dart';
import 'package:stock_manager/functions/function.dart';
import 'package:stock_manager/widgets/button.dart';

// ignore: must_be_immutable
class NoInternet extends StatefulWidget {
  // const NoInternet({ Key? key }) : super(key: key);
  dynamic onTap;
  // ignore: use_key_in_widget_constructors
  NoInternet({required this.onTap});

  @override
  State<NoInternet> createState() => _NoInternetState();
}

class _NoInternetState extends State<NoInternet> {
  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Container(
      height: media.height * 1,
      width: media.width * 1,
      color: Colors.transparent.withOpacity(0.6),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(media.width * 0.05),
            width: media.width * 0.8,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: backgroundColor),
            child: Column(
              children: [
                // SizedBox(
                //   width: media.width * 0.6,
                //   child: Image.asset(
                //     'assets/images/noInternet.png',
                //     fit: BoxFit.contain,
                //   ),
                // ),
                SizedBox(
                  height: media.width * 0.05,
                ),
                Text(
                  'No Internet Connection',
                  style: TextStyle(
                      fontSize: media.width * eighteen,
                      fontWeight: FontWeight.w600,
                      color: white),
                ),
                SizedBox(
                  height: media.width * 0.05,
                ),
                Text(
                  'Please check your Internet connection, try enabling wifi or tey again later',
                  style: TextStyle(
                      fontSize: media.width * fourteen, color: hintColor),
                ),
                SizedBox(
                  height: media.width * 0.05,
                ),
                Button(
                    onTap: () {
                      internetTrue();
                      widget.onTap();
                    },
                    text: 'Ok')
              ],
            ),
          )
        ],
      ),
    );
  }
}
