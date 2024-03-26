import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:stock_manager/config/constant.dart';
import 'package:stock_manager/config/parameter.dart';
import 'package:stock_manager/widgets/sales/sale.dart';

class AllSales extends StatefulWidget {
  Function setParent;
  AllSales({super.key, required this.setParent});

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
              jsonDecode(salesAll[i]['customer'])['logo'],
              jsonDecode(salesAll[i]['customer'])['name'],
              "${salesAll[i]['price']} ${company['currency']['symbol']}",
              salesAll[i]['shipping_state'],
              salesAll[i]['paiement_state'],
              context,
              salesAll[i]['id'].toString(),
              widget.setParent),
      ],
    );
  }
}

class DeleveredSales extends StatefulWidget {
  Function setParent;
  DeleveredSales({super.key, required this.setParent});

  @override
  State<DeleveredSales> createState() => _DeliveredStateSales();
}

class _DeliveredStateSales extends State<DeleveredSales> {
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      primary: false,
      padding: const EdgeInsets.all(20),
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      crossAxisCount: 4,
      children: <Widget>[
        for (var i = 0; i < salesDelivered.length; i++)
          sales(
              salesDelivered[i]['image'],
              salesDelivered[i]['name'],
              "${salesDelivered[i]['price']} ${company['currency']['symbol']}",
              salesDelivered[i]['shipping_state'],
              salesDelivered[i]['paiement_state'],
              context,
              salesDelivered[i]['id'].toString(),
              widget.setParent),
      ],
    );
  }
}

class PendingSales extends StatefulWidget {
  Function setParent;
  PendingSales({super.key, required this.setParent});

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
              salesPending[i]['shipping_state'],
              salesPending[i]['paiement_state'],
              context,
              salesPending[i]['id'].toString(),
              widget.setParent),
      ],
    );
  }
}

// class CompleteSales extends StatefulWidget {
//   Function setParent;
//   CompleteSales({super.key, required this.setParent});

//   @override
//   State<CompleteSales> createState() => _CompleteSalesState();
// }

// class _CompleteSalesState extends State<CompleteSales> {
//   @override
//   Widget build(BuildContext context) {
//     return GridView.count(
//       primary: false,
//       padding: const EdgeInsets.all(20),
//       crossAxisSpacing: 10,
//       mainAxisSpacing: 10,
//       crossAxisCount: 4,
//       children: <Widget>[
//         for (var i = 0; i < salesComplete.length; i++)
//           sales(
//               salesComplete[i]['image'],
//               salesComplete[i]['name'],
//               "${salesComplete[i]['price']} ${company['currency']['symbol']}",
//               salesComplete[i]['shipping_state'],
//               salesComplete[i]['paiement_state'],
//               context,
//               salesComplete[i]['id'].toString(),
//               widget.setParent),
//       ],
//     );
//   }
// }

// class IncompleteSales extends StatefulWidget {
//   Function setParent;
//   IncompleteSales({super.key, required this.setParent});

//   @override
//   State<IncompleteSales> createState() => _IncompleteSalesState();
// }

// class _IncompleteSalesState extends State<IncompleteSales> {
//   @override
//   Widget build(BuildContext context) {
//     return GridView.count(
//       primary: false,
//       padding: const EdgeInsets.all(20),
//       crossAxisSpacing: 10,
//       mainAxisSpacing: 10,
//       crossAxisCount: 4,
//       children: <Widget>[
//         for (var i = 0; i < salesIncomplete.length; i++)
//           sales(
//               salesIncomplete[i]['image'],
//               salesIncomplete[i]['name'],
//               "${salesIncomplete[i]['price']} ${company['currency']['symbol']}",
//               salesIncomplete[i]['shipping_state'],
//               salesIncomplete[i]['paiement_state'],
//               context,
//               salesIncomplete[i]['id'].toString(),
//               widget.setParent),
//       ],
//     );
//   }
// }
