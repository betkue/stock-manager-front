import 'package:flutter/material.dart';
import 'package:stock_manager/constant.dart';
import 'package:stock_manager/widgets/purchase/purchase.dart';

class AllPurchase extends StatefulWidget {
  Function setParent;
  AllPurchase({super.key, required this.setParent});

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
        for (var i = 0; i < purchasesAll.length; i++)
          purchase(
              purchasesAll[i]['image'],
              purchasesAll[i]['name'],
              "${purchasesAll[i]['price']} ${company['currency']['symbol']}",
              purchasesAll[i]['shipping_state'],
              purchasesAll[i]['paiement_state'],
              context,
              purchasesAll[i]['id'].toString(),
              widget.setParent),
      ],
    );
  }
}

class PendingPurchase extends StatefulWidget {

  Function setParent;
   PendingPurchase({super.key, required this.setParent});

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
        for (var i = 0; i < purchasesPending.length; i++)
          purchase(
              purchasesPending[i]['image'],
              purchasesPending[i]['name'],
              "${purchasesPending[i]['price']} ${company['currency']['symbol']}",
              purchasesPending[i]['shipping_state'],
              purchasesPending[i]['paiement_state'],
              context,
              purchasesPending[i]['id'].toString(),
              widget.setParent),
      ],
    );
  }
}

class CompletePurchase extends StatefulWidget {

  Function setParent;
   CompletePurchase({super.key, required this.setParent});

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
        for (var i = 0; i < purchasesComplete.length; i++)
          purchase(
              purchasesComplete[i]['image'],
              purchasesComplete[i]['name'],
              "${purchasesComplete[i]['price']} ${company['currency']['symbol']}",
              purchasesComplete[i]['shipping_state'],
              purchasesComplete[i]['paiement_state'],
              context,
              purchasesComplete[i]['id'].toString(),
              widget.setParent),
      ],
    );
  }
}

class IncompletePurchase extends StatefulWidget {

  Function setParent;
   IncompletePurchase({super.key, required this.setParent});

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
        for (var i = 0; i < purchasesIncomplete.length; i++)
          purchase(
              purchasesIncomplete[i]['image'],
              purchasesIncomplete[i]['name'],
              "${purchasesIncomplete[i]['price']} ${company['currency']['symbol']}",
              purchasesIncomplete[i]['shipping_state'],
              purchasesIncomplete[i]['paiement_state'],
              context,
              purchasesIncomplete[i]['id'].toString(),
              widget.setParent),
      ],
    );
  }
}
