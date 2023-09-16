// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:stock_management/constant.dart';
import 'package:stock_management/widgets/account/account.dart';
import 'package:stock_management/test.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController statuController = TextEditingController();

  @override
  void initState() {
    nameController.text = user['name'];
    emailController.text = user['email'];
    // passwordController.text = user['password'];
    phoneController.text = user['phone'];
    statuController.text = user['rule'];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: gray,
      body: SafeArea(
          child: Row(
        children: [
          Expanded(
              flex: 5,
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
                        // GestureDetector(
                        //   onTap: () {
                        //     Navigator.push(
                        //       context,
                        //       MaterialPageRoute(
                        //           builder: (context) => const TestPage()),
                        //     );
                        //   },
                        //   child: const TextField(
                        //     decoration: InputDecoration(
                        //       hintText: "Search",
                        //       prefixIcon: Icon(Icons.search),
                        //       border: OutlineInputBorder(),
                        //     ),
                        //   ),
                        // ),
                        Expanded(
                          child: Column(
                            children: [
                              for (var i = 0; i < users.length; i++)
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 10),
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
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
                                              image: DecorationImage(
                                                  image: NetworkImage(
                                                      users[i]['image']))
                                              // color: gray,
                                              ),
                                          // child: Image.network(
                                          //   user['image'],
                                          //   fit: BoxFit.cover,
                                          // ),
                                        ),
                                        const SizedBox(
                                          width: 30,
                                        ),
                                        /*Expanded(child: Text("Marceline Paule II $i"),
                                        ),*/
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Wrap(
                                              crossAxisAlignment:
                                                  WrapCrossAlignment.center,
                                              children: [
                                                Icon(
                                                  Icons.circle,
                                                  size: 10,
                                                  color: users[i]['active']
                                                      ? backgroundColor
                                                      : gray,
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                  users[i]['name'],
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ],
                                            ),
                                            Text(users[i]['email']),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              const SizedBox(
                                height: 30,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  // user['rule'].contains("Admin")
                  //     ? Positioned(
                  //         bottom: 18,
                  //         right: 18,
                  //         child: FloatingActionButton(
                  //           backgroundColor: orange,
                  //           onPressed: () {
                  //             // Handle button press
                  //           },
                  //           child: const Icon(Icons.add),
                  //         ),
                  //       )
                  //     : Container()
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
                        image:
                            DecorationImage(image: NetworkImage(user['image'])),
                        borderRadius: BorderRadius.all(
                          Radius.circular(MediaQuery.of(context).size.height),
                        ),
                        // color: widget.color ?? orange,
                      ),
                      // child: Image.asset(
                      //   "assets/images/avatar.png",
                      //   fit: BoxFit.cover,
                      // )
                    ),
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
                                inputContain(width, 'Name', nameController,
                                    (String value) {
                                  setState(() {
                                    nameController.text = value;
                                    user_name = nameController.text;
                                  });
                                }, false, false),
                                const SizedBox(height: 20),
                                label('Email'),
                                inputContain(width, 'Email', emailController,
                                    (String value) {
                                  setState(() {
                                    emailController.text = value;
                                    user_email = emailController.text;
                                  });
                                }, false, false),
                                const SizedBox(height: 20),
                                label(' Password'),
                                inputContain(
                                    width, ' Password', passwordController,
                                    (String value) {
                                  passwordController.text = value;
                                  user_password = passwordController.text;
                                }, true, false),
                                const SizedBox(height: 20),
                                label(' Phone'),
                                inputContain(width, ' Phone', phoneController,
                                    (String value) {
                                  setState(() {
                                    phoneController.text = value;
                                    user_phone = phoneController.text;
                                  });
                                }, false, false),
                                const SizedBox(height: 20),
                                label(' Status'),
                                inputContain(width, ' Status', statuController,
                                    (String value) {
                                  setState(() {
                                    statuController.text = value;
                                    user_rule = statuController.text;
                                  });
                                }, false, true),
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
                                        style: TextStyle(
                                            fontSize: 24, color: white),
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
