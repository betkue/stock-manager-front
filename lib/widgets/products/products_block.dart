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
        for (var i = 0; i < productsAll.length; i++)
          products(
              productsAll[i]['image'],
              productsAll[i]['name'],
              "${productsAll[i]['price']} ${company['currency']['symbol']}",
              productsAll[i]['available'] ? 1 : 0,
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
        for (var i = 0; i < productsAvailable.length; i++)
          products(
              productsAvailable[i]['image'],
              productsAvailable[i]['name'],
              "${productsAvailable[i]['price']} ${company['currency']['symbol']}",
              productsAvailable[i]['available'] ? 1 : 0,
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
        for (var i = 0; i < productsUnavalaible.length; i++)
          products(
              productsUnavalaible[i]['image'],
              productsUnavalaible[i]['name'],
              "${productsUnavalaible[i]['price']} ${company['currency']['symbol']}",
              productsUnavalaible[i]['available'] ? 1 : 0,
              context),
      ],
    );
  }
}
