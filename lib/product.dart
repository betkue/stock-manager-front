import 'package:flutter/material.dart';
import 'package:stock_management/constant.dart';
import 'package:stock_management/widgets/products/product.dart';
import 'package:stock_management/widgets/products/products_block.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
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
                          "Add product",
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
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
                              "All Products",
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
                              "Available",
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
                              "Unavailable",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: index == 2 ? white : black,
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

/*import "package:flutter/material.dart";
import "package:stock_management/constant.dart";

class ProductPage extends StatefulWidget {
  const ProductPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  bool showAllProducts = true;
  bool showAvailableProducts = false;
  bool showUnavailableProducts = false;

  List<Product> products = [
    // Add your product data here
    // Product(name: "Product 1", available: true),
    // Product(name: "Product 2", available: false),
    for (var i = 0; i < 10; i++)
      Product(
          imagePath: "images/shoes4.png",
          name: "Women's Air Jordan 1 Low SE Utility",
          price: "1000 XFA",
          available: true),
  ];

  List<Product> getDisplayedProducts() {
    if (showAllProducts) {
      return products;
    } else if (showAvailableProducts) {
      return products.where((product) => product.available).toList();
    } else {
      return products.where((product) => !product.available).toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: gray,
      appBar: AppBar(
        backgroundColor: Colors.white,
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
                    horizontal: 20, vertical: 10), // Set the button's padding
              ),
              child: const Text(
                "Add product",
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
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
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        showAllProducts = true;
                        showAvailableProducts = false;
                        showUnavailableProducts = false;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      primary: showAllProducts
                          ? orange
                          : white, // Highlight the active button
                      onPrimary: showAllProducts
                          ? white
                          : Colors.black, // Set the text color accordingly
                    ),
                    child: const Text("All Products"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        showAllProducts = false;
                        showAvailableProducts = true;
                        showUnavailableProducts = false;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor:
                          showAvailableProducts ? white : Colors.black,
                      backgroundColor: showAvailableProducts ? orange : white,
                    ),
                    child: const Text("Available"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        showAllProducts = false;
                        showAvailableProducts = false;
                        showUnavailableProducts = true;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor:
                          showUnavailableProducts ? white : Colors.black,
                      backgroundColor: showUnavailableProducts ? orange : white,
                    ),
                    child: const Text("Unavailable"),
                  ),
                ],
              ),
            ),
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.all(16.0),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16.0,
                  crossAxisSpacing: 16.0,
                ),
                itemCount: getDisplayedProducts().length,
                itemBuilder: (BuildContext context, int index) {
                  Product product = getDisplayedProducts()[index];
                  return ProductWidget(product: product);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Product {
  String imagePath;
  final String name;
  String price;
  final bool available;

  Product(
      {required this.imagePath,
      required this.name,
      required this.price,
      required this.available});
}

class ProductWidget extends StatelessWidget {
  final Product product;

  const ProductWidget({super.key, required this.product});

  Widget products(String imagePath, String productName, String price, int state,
      BuildContext context) {
    return Container(
      // color: gray,
      decoration: const BoxDecoration(color: white, boxShadow: [
        BoxShadow(
            color: gray, spreadRadius: 2, blurRadius: 5, offset: Offset(0, 3))
      ]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(
            height: 200,
            width: double.infinity,
            imagePath,
            fit: BoxFit.cover,
          ),
          Text(
            productName,
            maxLines: 2,
            textAlign: TextAlign.center,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  price.toString(),
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: state == 1 ? black : orange),
                ),
              ),
              Icon(Icons.edit_outlined, color: state == 1 ? orange : black),
              const SizedBox(width: 10),
            ],
          ),
          Container(
            width: MediaQuery.of(context).size.width / 8,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              // color: state == 1 ? orange : gray
            ),
            child: Text(
              state == 1 ? "Available" : "Unavailable",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: state == 1
                      ? orange
                      : black), //color: state == 1 ? white : black),
            ),
          ),
          const SizedBox(height: 5),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}*/
