import 'package:flutter/material.dart';
import 'package:stock_management/constant.dart';
import 'package:stock_management/widgets/products/product.dart';

class Allproduct extends StatefulWidget {
  const Allproduct({super.key});

  @override
  State<Allproduct> createState() => _AllproductState();
}

class _AllproductState extends State<Allproduct> {
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      primary: false,
      padding: const EdgeInsets.all(20),
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      crossAxisCount: 4,
      children: <Widget>[
        for (var i = 0; i < 10; i++)
          products(
              "assets/images/shoes4.png",
              "Women's Air Jordan 1 Low SE Utility",
              "1000 ${company['currency']['symbol']}",
              i ~/ 2 == 0 ? 1 : 0,
              context),
      ],
    );
  }
}

class Availableproduct extends StatefulWidget {
  const Availableproduct({super.key});

  @override
  State<Availableproduct> createState() => _AvailableproductState();
}

class _AvailableproductState extends State<Availableproduct> {
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      primary: false,
      padding: const EdgeInsets.all(20),
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      crossAxisCount: 4,
      children: <Widget>[
        for (var i = 0; i < 10; i++)
          products(
              "assets/images/shoes4.png",
              "Women's Air Jordan 1 Low SE Utility",
              "1000 ${company['currency']['symbol']}",
              1,
              context),
      ],
    );
  }
}

class Unavailableproduct extends StatefulWidget {
  const Unavailableproduct({super.key});

  @override
  State<Unavailableproduct> createState() => _UnavailableproductState();
}

class _UnavailableproductState extends State<Unavailableproduct> {
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      primary: false,
      padding: const EdgeInsets.all(20),
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      crossAxisCount: 4,
      children: <Widget>[
        for (var i = 0; i < 10; i++)
          products(
              "assets/images/shoes4.png",
              "Women's Air Jordan 1 Low SE Utility",
              "1000 ${company['currency']['symbol']}",
              0,
              context),
      ],
    );
  }
}
