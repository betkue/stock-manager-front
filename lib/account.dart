import 'package:flutter/material.dart';
import 'package:stock_management/constant.dart';
import 'package:stock_management/widgets/account/account.dart';
import 'package:stock_management/test.dart';

class AccountPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: gray,
      body: SafeArea(
          child: Row(
        children: [
          Expanded(
              flex: 3,
              child: Stack(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const TestPage()),
                            );
                          },
                          child: const TextField(
                            decoration: InputDecoration(
                              hintText: "Search",
                              prefixIcon: Icon(Icons.search),
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                        Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                for (var i = 0; i < 20; i++)
                                  Padding(
                                    padding: const EdgeInsets.only(left: 34),
                                    child: Row(
                                      children: [
                                        Container(
                                          margin: const EdgeInsets.symmetric(
                                              vertical: 10),
                                          width: 50,
                                          height: 50,
                                          decoration: BoxDecoration(
                                            color: orange,
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(
                                                  MediaQuery.of(context)
                                                      .size
                                                      .height),
                                            ),
                                            // color: gray,
                                          ),
                                          child: Image.asset(
                                            "assets/images/avatar.png",
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 30,
                                        ),
                                        /*Expanded(child: Text("Marceline Paule II $i"),
                                        ),*/
                                        Column(
                                          children: [
                                            Text("Marceline Paule II $i"),
                                            Text("marceline@gmail.com $i"),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                const SizedBox(
                                  height: 30,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 18,
                    right: 18,
                    child: FloatingActionButton(
                      backgroundColor: orange,
                      onPressed: () {
                        // Handle button press
                      },
                      child: const Icon(Icons.add),
                    ),
                  )
                ],
              )),
          Expanded(
              flex: 8,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const Align(
                      alignment: Alignment.centerRight,
                      child: InkWell(
                        child: Icon(
                          Icons.help,
                          color: black,
                        ),
                      ),
                    ),
                    Container(
                        width: 150,
                        height: 150,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(MediaQuery.of(context).size.height),
                          ),
                          // color: widget.color ?? orange,
                        ),
                        child: Image.asset(
                          "assets/images/avatar.png",
                          fit: BoxFit.cover,
                        )),
                    Form(
                      key: _formKey,
                      child: Padding(
                        padding: const EdgeInsets.all(4),
                        child: Center(
                          child: SizedBox(
                            width: width / 4,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                label('Name'),
                                inputContain(width, 'Name'),
                                const SizedBox(height: 20),
                                label('Email'),
                                inputContain(width, 'Email'),
                                const SizedBox(height: 20),
                                label(' Password'),
                                inputContain(width, ' Password'),
                                const SizedBox(height: 20),
                                label(' Phone'),
                                inputContain(width, ' Phone'),
                                const SizedBox(height: 20),
                                label(' Status'),
                                inputContain(width, ' Status'),
                                const SizedBox(height: 20),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 4),
                                  child: SizedBox(
                                    width: width / 4.5,
                                    height: 47,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        if (_formKey.currentState!.validate()) {
                                          // Form is valid, process the data here.
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                              content: Text(
                                                  'Form submitted successfully!'),
                                            ),
                                          );
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const TestPage()));
                                        }
                                      },
                                      style: ElevatedButton.styleFrom(
                                        //<-- SEE HERE
                                        backgroundColor: orange,
                                      ),
                                      child: const Text(
                                        'Modify',
                                        style: TextStyle(fontSize: 24),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ))
        ],
      )),
    );
  }
}
