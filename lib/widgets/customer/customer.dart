import 'package:flutter/material.dart';
import 'package:stock_management/constant.dart';

class CustomerBlockPage extends StatelessWidget {
  const CustomerBlockPage({super.key});
  Widget buildItemContainer(int index) {
    return Container(
      color: white,
      child: Container(
        margin: const EdgeInsets.all(8.0),
        padding: const EdgeInsets.all(8.0),
        decoration: const BoxDecoration(
          color: white,
          boxShadow: [
            BoxShadow(
              color: gray,
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              decoration: const BoxDecoration(
                  // borderRadius: BorderRadius.circular(
                  //   MediaQuery.of(context).size.height,
                  // ),
                  ),
              child: Image.asset(
                "assets/images/avatar.png",
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 30),
            Expanded(child: Text("Customer $index")),
            Expanded(child: Text("Ref $index")),
            Expanded(child: Text("Num_Products $index")),
            Expanded(child: Text("Location $index")),
            Expanded(
              child: IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.edit_outlined,
                  color: orange,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    throw UnimplementedError();
  }
}
