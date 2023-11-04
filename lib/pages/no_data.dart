import 'package:flutter/material.dart';
import 'package:stock_manager/config/constant.dart';
import 'package:stock_manager/config/style.dart';
import 'package:stock_manager/functions/function.dart';
import 'package:stock_manager/widgets/button.dart';

// ignore: must_be_immutable
class NoData extends StatefulWidget {
  // const NoData({ Key? key }) : super(key: key);
  dynamic onTap;
  // ignore: use_key_in_widget_constructors
  NoData({required this.onTap});

  @override
  State<NoData> createState() => _NoDataState();
}

class _NoDataState extends State<NoData> {
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
                //     'assets/images/noData.png',
                //     fit: BoxFit.contain,
                //   ),
                // ),
                SizedBox(
                  height: media.width * 0.05,
                ),
                Text(
                  'No Data found',
                  style: TextStyle(
                      fontSize: media.width * eighteen,
                      fontWeight: FontWeight.w600,
                      color: textColor),
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
                SizedBox(
                  width: media.width / 7,
                  height: media.height / 12,
                  child: Button(
                      onTap: () {
                        internetTrue();
                        widget.onTap();
                      },
                      text: 'Try Aigain'),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
