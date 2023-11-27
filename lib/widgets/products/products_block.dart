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
      children: removeWidget(productsAll, context, widget.setParent),
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
      children: removeWidget(productsAvailable, context, widget.setParent),
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
      children: removeWidget(productsUnavalaible, context, widget.setParent),
    );
  }
}

removeWidget(List<Map<String, dynamic>> productsList, BuildContext context,
    Function setParent) {
  List<Widget> results = [];
  for (var i = 0; i < productsList.length; i++) {
    Widget product = products(
        productsList[i]['image'] ?? "",
        productsList[i]['name'],
        productsList[i]['features'] ?? "",
        productsList[i]['reference'],
        productsList[i]['clothing'],
        productsList[i]['weight'],
        "${productsList[i]['price']} ${company['currency']['symbol']}",
        productsList[i]['available'] ? 1 : 0,
        context,
        productsList[i]['id'].toString(),
        productsList[i]['quantity'].toString(),
        setParent);

    if (((product).toString() == Container().toString())) {
    } else {
      results.add(product);
    }
  }
  return results;
}


// products(
//               productsUnavalaible[i]['image'],
//               productsUnavalaible[i]['name'],
//               productsUnavalaible[i]['features'] ?? "",
//               productsUnavalaible[i]['reference'],
//               productsUnavalaible[i]['clothing'],
//               productsUnavalaible[i]['weight'],
//               "${productsUnavalaible[i]['price']} ${company['currency']['symbol']}",
//               productsUnavalaible[i]['available'] ? 1 : 0,
//               context,
//               productsUnavalaible[i]['image'].toString(),
//               productsUnavalaible[i]['quantity'].toString(),
//               widget.setParent)