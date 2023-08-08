import 'package:flutter/material.dart';
import 'package:stock_management/constant.dart';
import 'package:stock_management/widgets/products/products_block.dart';

class SalesPage extends StatefulWidget {
  const SalesPage({super.key});

  @override
  State<SalesPage> createState() => _SalesPageState();
}

class _SalesPageState extends State<SalesPage> {
  int index = 0;
  changeState(int i) {
    setState(() {
      index = i;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: gray,
      body: SafeArea(
        child: Row(children: [
          Expanded(
              flex: 8,
              child: Scaffold(
                appBar: AppBar(
                  backgroundColor: white,
                  toolbarHeight: 80,
                  elevation: 0,
                  automaticallyImplyLeading: false,
                  actions: const [
                    InkWell(
                      child: Icon(
                        Icons.help,
                        color: black,
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    )
                  ],
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Expanded(
                        child: SizedBox(
                          height: 40,
                          width: 50,
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: "Search",
                              prefixIcon: Icon(Icons.search),
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 18),
                      ElevatedButton(
                        onPressed: () {
                          // Handle button press for "Add product"
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: white,
                          shadowColor: orange,
                          surfaceTintColor: orange,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 10), // Set the button's padding
                        ),
                        child: const Text(
                          "New Purchase",
                          style: TextStyle(
                              fontSize: 16,
                              color: black,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    ],
                  ),
                ),
                body: SafeArea(
                    child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0, bottom: 40.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              changeState(0);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: index == 0 ? orange : white,
                              shadowColor: orange,
                              surfaceTintColor: orange,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 10), // Set the button's padding
                            ),
                            child: Text(
                              "All Purchase",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: index == 0 ? white : black,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                          const SizedBox(width: 80),
                          ElevatedButton(
                            onPressed: () {
                              changeState(1);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: index == 1 ? orange : white,
                              shadowColor: orange,
                              surfaceTintColor: orange,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 10), // Set the button's padding
                            ),
                            child: Text(
                              "Pending",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: index == 1 ? white : black,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                          const SizedBox(width: 80),
                          ElevatedButton(
                            onPressed: () {
                              changeState(2);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: index == 2 ? orange : white,
                              shadowColor: orange,
                              surfaceTintColor: orange,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 10), // Set the button's padding
                            ),
                            child: Text(
                              "Valid",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: index == 2 ? white : black,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                          const SizedBox(width: 80),
                          ElevatedButton(
                            onPressed: () {
                              changeState(3);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: index == 3 ? orange : white,
                              shadowColor: orange,
                              surfaceTintColor: orange,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 10), // Set the button's padding
                            ),
                            child: Text(
                              "Incomplete",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: index == 3 ? white : black,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(child: determineWidget()),
                  ],
                )),
              )),
        ]),
      ),
    );
  }

  Widget determineWidget() {
    if (index == 0) {
      return const Allproduct();
    } else if (index == 1) {
      return const Availableproduct();
    } else {
      return const Unavailableproduct();
    }
  }
}
