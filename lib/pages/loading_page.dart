import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:stock_manager/config/constant.dart';
import 'package:stock_manager/config/parameter.dart';
import 'package:stock_manager/config/style.dart';
import 'package:stock_manager/create_store.dart';
import 'package:stock_manager/functions/function.dart';
import 'package:stock_manager/functions/store_function.dart';
import 'package:stock_manager/home.dart';
import 'package:stock_manager/info_page.dart';
import 'package:stock_manager/pages/loading.dart';
import 'package:stock_manager/pages/no_internet.dart';
import 'package:stock_manager/pages/update_available.dart';
import 'package:stock_manager/signin.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({super.key});

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  bool isLoading = true;

  @override
  void initState() {
    initialiseApp();
    super.initState();
  }

  initialiseApp() async {
    await getDetailsOfDevice();
    if (internet == true) {
      await getCountryCode();
      var val = await getLocalData();

      var package = await PackageInfo.fromPlatform();
      //if user is login
      if (val == true) {
        var result = await getVersion(token);

        if (result) {
          if (version_app != null) {
            var version = version_app.toString().split('.');
            var packages = package.version.toString().split('.');

            for (var i = 0; i < version.length || i < packages.length; i++) {
              if (i < version.length && i < packages.length) {
                if (int.parse(packages[i]) < int.parse(version[i])) {
                  setState(() {
                    updateAvailable = true;
                  });
                  break;
                } else if (int.parse(packages[i]) > int.parse(version[i])) {
                  setState(() {
                    updateAvailable = false;
                  });
                  break;
                }
              } else if (i >= version.length && i < packages.length) {
                setState(() {
                  updateAvailable = false;
                });
                break;
              } else if (i < version.length && i >= packages.length) {
                setState(() {
                  updateAvailable = false; //TO D put true
                });
                break;
              }
            }
          }

          if (updateAvailable) {
            Future.delayed(const Duration(seconds: 2), () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => UpdateAvailable()));
            });
          } else {
            //if user have store
            var haveStore = await getStore();
            //if user have store
            if (haveStore) {
              var storeAvtive = company['is_active'];
              //if user  store activated
              if (storeAvtive) {
                if (internet) {
                  Future.delayed(const Duration(seconds: 2), () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => Home()));
                  });
                }
              } else {
                //if user  store not activated
                if (internet) {
                  Future.delayed(const Duration(seconds: 2), () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => InfoPage()));
                  });
                }
              }
            } else {
              //if user don't have store
              if (internet) {
                Future.delayed(const Duration(seconds: 2), () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => CreateStore()));
                });
              }
            }
          }
        }
      }
      //if user is not login in this device
      else {
        if (internet) {
          Future.delayed(const Duration(seconds: 2), () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const Signin()));
          });
        }
      }
    } else {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Material(
      child: Scaffold(
        backgroundColor: backgroundColor,
        body: Stack(
          children: [
            Container(
              height: media.height * 1,
              width: media.width * 1,
              decoration: BoxDecoration(
                color: backgroundColor,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.all(media.width * 0.01),
                    width: media.width * 0.429,
                    height: media.width * 0.429,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(logo), fit: BoxFit.contain)),
                  ),
                ],
              ),
            ),
            //loader
            (isLoading == true && internet == true)
                ? const Positioned(top: 0, child: Loading())
                : Container(),

            //internet is not connected
            (internet == false)
                ? Positioned(
                    top: 0,
                    child: NoInternet(
                      onTap: () {
                        //try again
                        setState(() {
                          internetTrue();
                          isLoading = true;
                          initialiseApp();
                        });
                      },
                    ))
                : Container(),
          ],
        ),
      ),
    );
  }
}
