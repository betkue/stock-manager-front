import 'package:flutter/material.dart';

class Product {
  final String name;
  final bool available;

  Product(this.name, this.available);
}

class TestPage extends StatefulWidget {
  const TestPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  List<Product> products = [
    Product("Product A", true),
    Product("Product B", false),
    Product("Product C", true),
    // Add more products here
  ];

  List<Product> filteredProducts = [];

  void filterProducts(String query) {
    setState(() {
      filteredProducts = products
          .where((product) =>
              product.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  void initState() {
    super.initState();
    // By default, show all products
    filteredProducts = products;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Page'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              onChanged: filterProducts,
              decoration: InputDecoration(
                labelText: 'Search',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredProducts.length,
              itemBuilder: (context, index) {
                final product = filteredProducts[index];
                return ListTile(
                  title: Text(product.name),
                  subtitle: Text(product.available ? 'Available' : 'Unavailable'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(home: TestPage()));
}