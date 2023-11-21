import 'package:flutter/material.dart';
import 'package:stock_manager/config/constant.dart';
import 'package:stock_manager/config/parameter.dart';
import 'package:stock_manager/widgets/products/product.dart';

class Allproduct extends StatefulWidget {
  Function setParent;
  Allproduct({super.key, required this.setParent});

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
              productsAll[i]['clothing'],
              productsAll[i]['weight'],
              "${productsAll[i]['price']} ${company['currency']['symbol']}",
              productsAll[i]['available'] ? 1 : 0,
              context,
              productsAll[i]['id'].toString(),
              productsAll[i]['quantity'].toString(),
              widget.setParent),
      ],
    );
  }
}

class Availableproduct extends StatefulWidget {
  Function setParent;
  Availableproduct({super.key, required this.setParent});

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
              productsAvailable[i]['clothing'],
              productsAvailable[i]['weight'],
              "${productsAvailable[i]['price']} ${company['currency']['symbol']}",
              productsAvailable[i]['available'] ? 1 : 0,
              context,
              productsAvailable[i]['id'].toString(),
              productsAvailable[i]['quantity'].toString(),
              widget.setParent),
      ],
    );
  }
}

class Unavailableproduct extends StatefulWidget {
  Function setParent;
  Unavailableproduct({super.key, required this.setParent});

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
              productsUnavalaible[i]['clothing'],
              productsUnavalaible[i]['weight'],
              "${productsUnavalaible[i]['price']} ${company['currency']['symbol']}",
              productsUnavalaible[i]['available'] ? 1 : 0,
              context,
              productsUnavalaible[i]['image'].toString(),
              productsUnavalaible[i]['quantity'].toString(),
              widget.setParent),
      ],
    );
  }
}
