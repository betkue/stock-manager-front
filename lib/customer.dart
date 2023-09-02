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
                    itemCount: customers.length,
                    itemBuilder: (context, index) {
                      return buildItemContainer(index, context);
                    },
                  ))),
        ],
      )),
    );
  }

  Widget buildItemContainer(int index, BuildContext context) {
    return Container(
      color: Colors.white,
      child: Container(
        margin: const EdgeInsets.all(8.0),
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(customers[index]['image'])),
                color: orange,
                borderRadius:
                    BorderRadius.circular(MediaQuery.of(context).size.height),
                // color: widget.color ?? orange,
              ),
              // child: Image.network(
              //  ,
              //   // fit: BoxFit.cover,
              // )
            ),
            const SizedBox(width: 30),
            Expanded(child: Text(customers[index]['name'])),
            Expanded(child: Text("${customers[index]['reference']} $index")),
            Expanded(
                child:
                    Text("Quantity : ${customers[index]['product_quantity']}")),
            Expanded(child: Text("Location : ${customers[index]['location']}")),
            Expanded(
              child: IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.edit_outlined,
                  color: Colors.orange,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
