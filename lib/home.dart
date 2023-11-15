// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:stock_manager/config/constant.dart';
import 'package:stock_manager/config/style.dart';
import 'package:stock_manager/dashboard.dart';
import 'package:stock_manager/locations.dart';
import 'package:stock_manager/menu.dart';
import 'package:stock_manager/movements.dart';
import 'package:stock_manager/widgets/profile.dart';
import 'package:stock_manager/products.dart';
import 'package:stock_manager/customers.dart';
import 'package:stock_manager/suppliers.dart';
import 'package:stock_manager/purchases.dart';
import 'package:stock_manager/sales.dart';
import 'package:stock_manager/profile.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Widget> contian = [
    // DashBoard(),
    LocationPage(),
    ProductPage(),
    Movements(),
    CustomerPage(),
    SupplierPage(),
    PurchasePage(),
    // Container(),
    SalesPage(),
    AccountPage(),
  ];

  // int selected = 1;

  select(int index) {
    setState(() {
      home_index = index;
    });
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: gray,
        key: _scaffoldKey,
        drawer: !Responsive.isDesktop(context)
            ? SizedBox(
                width: 250,
                child: Menu(
                  scaffoldKey: _scaffoldKey,
                  select: select,
                ))
            : null,
        endDrawer: Responsive.isMobile(context)
            ? SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: const Profile())
            : null,
        body: SafeArea(
          child: Row(
            children: [
              if (Responsive.isDesktop(context))
                Expanded(
                  flex: 2,
                  child: SizedBox(
                      height: MediaQuery.of(context).size.height,
                      child: Menu(
                        scaffoldKey: _scaffoldKey,
                        select: select,
                      )),
                ),
              if (!Responsive.isMobile(context))
                Expanded(
                  flex: 8,
                  child: contian[home_index],
                ),
            ],
          ),
        ));
  }
}
