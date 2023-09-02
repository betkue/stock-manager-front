import 'package:flutter/material.dart';
import 'package:stock_management/constant.dart';
import 'package:stock_management/widgets/purchase/purchase.dart';

class AllPurchase extends StatefulWidget {
  const AllPurchase({super.key});

  @override
  State<AllPurchase> createState() => _AllPurchaseState();
}

class _AllPurchaseState extends State<AllPurchase> {
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
          purchase(
              "assets/images/LaMater.png",
              "Women's Air Jordan 1 Low SE Utility",
              "1000 ${company['currency']['symbol']}",
              i ~/ 2 == 0 ? 1 : 0,
              context),
      ],
    );
  }
}

class PendingPurchase extends StatefulWidget {
  const PendingPurchase({super.key});

  @override
  State<PendingPurchase> createState() => _PendingStatePurchase();
}

class _PendingStatePurchase extends State<PendingPurchase> {
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
          purchase(
              "assets/images/LaMater.png",
              "Women's Air Jordan 1 Low SE Utility",
              "1000 ${company['currency']['symbol']}",
              0,
              context),
      ],
    );
  }
}

class CompletePurchase extends StatefulWidget {
  const CompletePurchase({super.key});

  @override
  State<CompletePurchase> createState() => _CompletePurchaseState();
}

class _CompletePurchaseState extends State<CompletePurchase> {
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
          purchase(
              "assets/images/LaMater.png",
              "Women's Air Jordan 1 Low SE Utility",
              "1000 ${company['currency']['symbol']}",
              2,
              context),
      ],
    );
  }
}

class IncompletePurchase extends StatefulWidget {
  const IncompletePurchase({super.key});

  @override
  State<IncompletePurchase> createState() => _IncompletePurchaseState();
}

class _IncompletePurchaseState extends State<IncompletePurchase> {
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
          purchase(
              "assets/images/LaMater.png",
              "Women's Air Jordan 1 Low SE Utility",
              "1000 ${company['currency']['symbol']}",
              1,
              context),
      ],
    );
  }
}
