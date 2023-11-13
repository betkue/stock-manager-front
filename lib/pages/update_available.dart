import 'package:flutter/material.dart';
import 'package:stock_manager/config/constant.dart';
import 'package:stock_manager/config/parameter.dart';
import 'package:stock_manager/config/style.dart';
import 'package:stock_manager/functions/function.dart';
import 'package:stock_manager/functions/store_function.dart';
import 'package:stock_manager/home.dart';
import 'package:stock_manager/main.dart';
import 'package:stock_manager/pages/loading.dart';
import 'package:stock_manager/pages/no_internet.dart';
import 'package:stock_manager/widgets/button.dart';

class UpdateAvailable extends StatefulWidget {
  const UpdateAvailable({super.key});

  @override
  State<UpdateAvailable> createState() => _UpdateAvailableState();
}

class _UpdateAvailableState extends State<UpdateAvailable> {
  bool loading = false;

  @override
  void initState() {
    getState();
    super.initState();
  }

  getState() async {
    openBrowser(url_version);
    // setState(() {
    //   internetTrue();
    //   loading = true;
    // });

    // var result = await getVersion(token);

    // if (result == true) {
    //   // Navigator.pushAndRemoveUntil(context,
    //   //     MaterialPageRoute(builder: (context) => MyApp()), (route) => false);
    // }

    // setState(() {
    //   loading = false;
    // });
  }

  @override
  Widget build(BuildContext context) {
    dynamic media = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "For effective use of your software, please update your software via the official website",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: white,
                    fontSize: 24,
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Container(
                  width: media.width / 5,
                  height: media.height / 10,
                  // padding: EdgeInsets.symmetric(
                  //     vertical: media.height / 10, horizontal: media.width / 5),
                  child: Button(
                      onTap: () async {
                        await getState();
                      },
                      text: "Get Update"),
                )
              ],
            ),
          ),

          (loading == true)
              ? const Positioned(top: 0, child: Loading())
              : Container(),
          //internet is not connected
          (internet == false)
              ? Positioned(
                  top: 0,
                  child: NoInternet(
                    onTap: () async {
                      await getState();
                    },
                  ))
              : Container(),
        ],
      ),
    );
  }
}
