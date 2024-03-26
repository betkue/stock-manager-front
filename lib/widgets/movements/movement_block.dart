import 'package:flutter/material.dart';
import 'package:stock_manager/config/constant.dart';
import 'package:stock_manager/config/parameter.dart';
import 'package:stock_manager/config/style.dart';
import 'package:stock_manager/functions/function.dart';
import 'package:stock_manager/widgets/error_buil.dart';
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
    try {
      return ListView(
        primary: false,
        padding: const EdgeInsets.all(20),
        children: <Widget>[
          for (var i = movementsAll.length - 1; i >= 0; i--)
            movement(
                movementsAll[i]['id'].toString(),
                movementsAll[i]['product_location']['product']['name'],
                movementsAll[i]['product_location']['product']['reference'],
                movementsAll[i]['new_qte'].toString(),
                movementsAll[i]['is_entry'],
                movementsAll[i]['last_qte'].toString(),
                convertDate(DateTime.parse(movementsAll[i]['created_at'])),
                movementsAll[i]['product_location']['location']['name'],
                movementsAll[i]['product_location']['product']['image'] ??
                    "https://actogmbh.com/files/no-product-image.png",
                movementsAll[i]['comment'],
                context,
                widget.setParent,
                i == movementsAll.length - 1),
        ],
      );
    } catch (e) {
      debugPrint(e.toString());
      return ErrorBuild();
    }
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
        for (var i = movementsEntry.length - 1; i >= 0; i--)
          movement(
              movementsEntry[i]['id'].toString(),
              movementsEntry[i]['product_location']['product']['name'],
              movementsEntry[i]['product_location']['product']['reference'],
              movementsEntry[i]['new_qte'].toString(),
              movementsEntry[i]['is_entry'],
              movementsEntry[i]['last_qte'].toString(),
              convertDate(DateTime.parse(movementsEntry[i]['created_at'])),
              movementsEntry[i]['product_location']['location']['name'],
              movementsEntry[i]['product_location']['product']['image'],
              movementsEntry[i]['comment'],
              context,
              widget.setParent,
              i == movementsEntry.length - 1),
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
        for (var i = movementsExit.length - 1; i >= 0; i--)
          movement(
              movementsExit[i]['id'].toString(),
              movementsExit[i]['product_location']['product']['name'],
              movementsExit[i]['product_location']['product']['reference'],
              movementsExit[i]['new_qte'].toString(),
              movementsExit[i]['is_entry'],
              movementsExit[i]['last_qte'].toString(),
              convertDate(DateTime.parse(movementsExit[i]['created_at'])),
              movementsExit[i]['product_location']['location']['name'],
              movementsExit[i]['product_location']['product']['image'],
              movementsExit[i]['comment'],
              context,
              widget.setParent,
              i == movementsExit.length - 1),
      ],
    );
  }
}
