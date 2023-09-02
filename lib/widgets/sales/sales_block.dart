import 'package:flutter/material.dart';
import 'package:stock_management/constant.dart';
import 'package:stock_management/widgets/sales/sale.dart';

class AllSales extends StatefulWidget {
  const AllSales({super.key});

  @override
  State<AllSales> createState() => _AllSalesState();
}

class _AllSalesState extends State<AllSales> {
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      primary: false,
      padding: const EdgeInsets.all(20),
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      crossAxisCount: 4,
      children: <Widget>[
        for (var i = 0; i < salesAll.length; i++)
          sales(
              salesAll[i]['image'],
              salesAll[i]['name'],
              "${salesAll[i]['price']} ${company['currency']['symbol']}",
              salesAll[i]['shipping_state'],
              salesAll[i]['paiement_state'],
              context),
      ],
    );
  }
}

class PendingSales extends StatefulWidget {
  const PendingSales({super.key});

  @override
  State<PendingSales> createState() => _PendingStateSales();
}

class _PendingStateSales extends State<PendingSales> {
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      primary: false,
      padding: const EdgeInsets.all(20),
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      crossAxisCount: 4,
      children: <Widget>[
        for (var i = 0; i < salesPending.length; i++)
          sales(
              salesPending[i]['image'],
              salesPending[i]['name'],
              "${salesPending[i]['price']} ${company['currency']['symbol']}",
              salesAll[i]['shipping_state'],
              salesPending[i]['paiement_state'],
              context),
      ],
    );
  }
}

class CompleteSales extends StatefulWidget {
  const CompleteSales({super.key});

  @override
  State<CompleteSales> createState() => _CompleteSalesState();
}

class _CompleteSalesState extends State<CompleteSales> {
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      primary: false,
      padding: const EdgeInsets.all(20),
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      crossAxisCount: 4,
      children: <Widget>[
        for (var i = 0; i < salesComplete.length; i++)
          sales(
              salesComplete[i]['image'],
              salesComplete[i]['name'],
              "${salesComplete[i]['price']} ${company['currency']['symbol']}",
              salesComplete[i]['shipping_state'],
              salesComplete[i]['paiement_state'],
              context),
      ],
    );
  }
}

class IncompleteSales extends StatefulWidget {
  const IncompleteSales({super.key});

  @override
  State<IncompleteSales> createState() => _IncompleteSalesState();
}

class _IncompleteSalesState extends State<IncompleteSales> {
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      primary: false,
      padding: const EdgeInsets.all(20),
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      crossAxisCount: 4,
      children: <Widget>[
        for (var i = 0; i < salesIncomplete.length; i++)
          sales(
              salesIncomplete[i]['image'],
              salesIncomplete[i]['name'],
              "${salesIncomplete[i]['price']} ${company['currency']['symbol']}",
              salesIncomplete[i]['shipping_state'],
              salesIncomplete[i]['paiement_state'],
              context),
      ],
    );
  }
}