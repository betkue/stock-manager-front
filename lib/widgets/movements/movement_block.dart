import 'package:flutter/material.dart';
import 'package:stock_manager/config/constant.dart';
import 'package:stock_manager/config/parameter.dart';
import 'package:stock_manager/functions/function.dart';
import 'package:stock_manager/widgets/movements/movement.dart';
import 'package:stock_manager/widgets/products/product.dart';

class Allmovement extends StatefulWidget {
  Function setParent;
  Allmovement({super.key, required this.setParent});

  @override
  State<Allmovement> createState() => _AllmovementState();
}

class _AllmovementState extends State<Allmovement> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      primary: false,
      padding: const EdgeInsets.all(20),
      children: <Widget>[
        for (var i = 0; i < mouvementsAll.length; i++)
          movement(
              mouvementsAll[i]['id'].toString(),
              mouvementsAll[i]['product_location']['product']['name'],
              mouvementsAll[i]['new_qte'].toString(),
              mouvementsAll[i]['is_entry'],
              mouvementsAll[i]['last_qte'].toString(),
              convertDate(DateTime.parse(mouvementsAll[i]['created_at'])),
              mouvementsAll[i]['product_location']['location']['name'],
              mouvementsAll[i]['product_location']['product']['image'],
              context,
              widget.setParent),
      ],
    );
  }
}

class EntryMovement extends StatefulWidget {
  Function setParent;
  EntryMovement({super.key, required this.setParent});

  @override
  State<EntryMovement> createState() => _EntryMovementState();
}

class _EntryMovementState extends State<EntryMovement> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      primary: false,
      padding: const EdgeInsets.all(20),
      children: <Widget>[
        for (var i = 0; i < productsAvailable.length; i++)
          movement(
              mouvementsEntry[i]['id'].toString(),
              mouvementsEntry[i]['product_location']['product']['name'],
              mouvementsEntry[i]['new_qte'].toString(),
              mouvementsEntry[i]['is_entry'],
              mouvementsEntry[i]['last_qte'].toString(),
              convertDate(DateTime.parse(mouvementsEntry[i]['created_at'])),
              mouvementsEntry[i]['product_location']['location']['name'],
              mouvementsEntry[i]['product_location']['product']['image'],
              context,
              widget.setParent),
      ],
    );
  }
}

class ExitMovement extends StatefulWidget {
  Function setParent;
  ExitMovement({super.key, required this.setParent});

  @override
  State<ExitMovement> createState() => _ExitMovementState();
}

class _ExitMovementState extends State<ExitMovement> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      primary: false,
      padding: const EdgeInsets.all(20),
      children: <Widget>[
        for (var i = 0; i < productsUnavalaible.length; i++)
          movement(
              mouvementsExit[i]['id'].toString(),
              mouvementsExit[i]['product_location']['product']['name'],
              mouvementsExit[i]['new_qte'].toString(),
              mouvementsExit[i]['is_entry'],
              mouvementsExit[i]['last_qte'].toString(),
              convertDate(DateTime.parse(mouvementsExit[i]['created_at'])),
              mouvementsExit[i]['product_location']['location']['name'],
              mouvementsExit[i]['product_location']['product']['image'],
              context,
              widget.setParent),
      ],
    );
  }
}
