import 'package:flutter/material.dart';
import 'package:stock_management/constant.dart';
import 'package:stock_management/dashboard.dart';
import 'package:stock_management/menu.dart';
import 'package:stock_management/widgets/profile.dart';
import 'package:stock_management/products.dart';
import 'package:stock_management/customers.dart';
import 'package:stock_management/suppliers.dart';
import 'package:stock_management/purchases.dart';
import 'package:stock_management/sales.dart';
import 'package:stock_management/account.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Widget> contian = [
    const DashBoard(),
    const ProductPage(),
    const CustomerPage(),
    const SupplierPage(),
    const PurchasePage(),
    // Container(),
    const SalesPage(),
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
