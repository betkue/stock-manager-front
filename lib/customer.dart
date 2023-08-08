import 'package:flutter/material.dart';
import 'package:stock_management/constant.dart';

class CustomerPage extends StatelessWidget {
  const CustomerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: gray,
      body: SafeArea(
          child: Row(
        children: [
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
                        color: Colors.black,
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
                          "Add Customer",
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    ],
                  ),
                ),
                body: ListView.builder(
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return Container(
                      color: Colors.white,
                      child: Container(
                        // Add any styling properties for the item container here
                        margin: const EdgeInsets.all(8.0),
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: white,
                          // borderRadius: BorderRadius.circular(8.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: const Offset(
                                  0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            // Expanded(
                            //   child:
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(
                                      MediaQuery.of(context).size.height),
                                ),
                                // color: gray,
                              ),
                              child: Image.asset(
                                "assets/images/avatar.png",
                                fit: BoxFit.cover,
                              ),
                            ),
                            // ),
                            Expanded(child: Text("Customer $index")),
                            Expanded(child: Text("Customer $index")),
                            Expanded(
                              child: IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.delete,
                                  color: orange,
                                ),
                              ),
                            )
                          ],
                        ),
                        // child: ListTile(
                        //   leading: const CircleAvatar(
                        //     backgroundColor: logo,
                        //     child: Text("C"),
                        //   ),
                        //   title: Text("Customer $index"),
                        //   subtitle: Text("Customer $index"),
                        //   trailing: IconButton(
                        //     onPressed: () {},
                        //     icon: const Icon(
                        //       Icons.delete,
                        //       color: Colors.white,
                        //     ),
                        //   ),
                        // ),
                      ),
                    );
                  },
                ),
              )),
        ],
      )),
    );
  }
}
