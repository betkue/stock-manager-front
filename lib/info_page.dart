import 'package:flutter/material.dart';
import 'package:stock_manager/config/constant.dart';
import 'package:stock_manager/config/parameter.dart';
import 'package:stock_manager/config/style.dart';
import 'package:stock_manager/functions/function.dart';
import 'package:stock_manager/functions/store_function.dart';
import 'package:stock_manager/home.dart';
import 'package:stock_manager/pages/loading.dart';
import 'package:stock_manager/pages/no_internet.dart';
import 'package:stock_manager/widgets/button.dart';
import 'package:stock_manager/widgets/help_button.dart';

class InfoPage extends StatefulWidget {
  const InfoPage({super.key});

  @override
  State<InfoPage> createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  bool loading = false;

  @override
  void initState() {
    getState();
    super.initState();
  }

  getState() async {
    setState(() {
      internetTrue();
      loading = true;
    });

    var result = await getStore();

    if (result == true && company['is_active'] == true) {
      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (context) => Home()), (route) => false);
    }

    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    dynamic media = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Stack(
        children: [
          
        
        Positioned(child: HelpButton(),

        right: 30,
        top: 30,
        ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Thank you for providing us with the necessary information to create your online store\n for stock management. We appreciate your interest in our application.\n We kindly ask you to patiently wait for the validation of your store. Our team will review the\n details you've provided to ensure everything is set up correctly. Once the validation process\n is complete, we will send a confirmation message to your registered email address with the information about the paiement process.",
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
                      text: "Check States"),
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
