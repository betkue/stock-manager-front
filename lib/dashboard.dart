// ignore_for_file: prefer_const_constructors

/*import 'package:flutter/material.dart';

class DashBoard extends StatefulWidget {
  @override
  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    HomeWidget(),
    SettingsWidget(),
    // Add more page widgets here
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Main Page'),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              tileColor: _currentIndex == 0 ? Colors.grey[300] : null,
              onTap: () {
                setState(() {
                  _currentIndex = 0;
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              tileColor: _currentIndex == 1 ? Colors.grey[300] : null,
              onTap: () {
                setState(() {
                  _currentIndex = 1;
                });
                Navigator.pop(context);
              },
            ),
            // Add more vertical menu items here
          ],
        ),
      ),
      body: _pages[_currentIndex],
    );
  }
}

// Example home widget
class HomeWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Home Page'),
    );
  }
}

// Example settings widget
class SettingsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Settings Page'),
    );
  }
}*/
/*import 'package:flutter/material.dart';
import 'package:stock_management/constant.dart';
import 'package:stock_management/menu.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({super.key});

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const HomeWidget(),
    const SettingsWidget(),
    // Add more page widgets here
  ];
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: gray,
      appBar: AppBar(),
      key: _scaffoldKey,
      drawer: !Responsive.isDesktop(context)
          ? SizedBox(width: 250, child: Menu(scaffoldKey: _scaffoldKey))
          : null,
      body: SafeArea(
        child: Row(
          children: [
            if (Responsive.isDesktop(context))
              Expanded(
                flex: 2,
                child: SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: Menu(scaffoldKey: _scaffoldKey)),
              ),
            if (!Responsive.isMobile(context))
              const Expanded(
                flex: 8,
                child: Column(),
              ),
            PageView(
              children: _pages,
              onPageChanged: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
          // Add more bottom navigation items here
        ],
      ),
    );
  }
}

// Example home widget
class HomeWidget extends StatelessWidget {
  const HomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Home Page'),
    );
  }
}

// Example settings widget
class SettingsWidget extends StatelessWidget {
  const SettingsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Settings Page'),
    );
  }
}*/

import 'package:flutter/material.dart';
import 'package:stock_management/menu.dart';
import 'package:stock_management/constant.dart';
import 'package:stock_management/widgets/profile.dart';

class DashBoard extends StatelessWidget {
  DashBoard({super.key});

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    double radius = 15;
    return Scaffold(
        backgroundColor: gray,
        key: _scaffoldKey,
        drawer: !Responsive.isDesktop(context)
            ? SizedBox(width: 250, child: Menu(scaffoldKey: _scaffoldKey))
            : null,
        endDrawer: Responsive.isMobile(context)
            ? SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: const Profile())
            : null,
        body: SafeArea(
          child: Row(
            children: [
              if (Responsive.isDesktop(context))
                Expanded(
                  flex: 2,
                  child: SizedBox(
                      height: MediaQuery.of(context).size.height,
                      child: Menu(scaffoldKey: _scaffoldKey)),
                ),
              if (!Responsive.isMobile(context))
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
                      title: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Add your widgets for the information bar here
                          Text(
                            "DashBoard/",
                            style: TextStyle(fontSize: 22, color: black),
                          ),
                          Text(
                            'This Month',
                            style: TextStyle(
                              fontFamily: "Inter",
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                              color: dark,
                              height: 24 / 20,
                            ),
                          ),
                          Icon(
                            Icons.arrow_drop_down,
                            color: black,
                          ),
                        ],
                      ),
                    ),
                    body: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  height: 200,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 10),
                                  decoration: BoxDecoration(
                                      color: white,
                                      borderRadius:
                                          BorderRadius.circular(radius)),
                                  // Add your widgets for container 2 here
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      productInfo(
                                          "count of all product", 20000, true),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Divider(),
                                      productInfo(
                                          "Product out of stock", 20, true),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Divider(),
                                      productInfo(
                                          "Product overstocked", 2, true),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(width: 20),
                              Expanded(
                                child: Container(
                                  height: 200,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 28, vertical: 10),
                                  decoration: BoxDecoration(
                                      color: white,
                                      borderRadius:
                                          BorderRadius.circular(radius)),
                                  // Add your widgets for container 3 here
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Inventory Summary",
                                        style: const TextStyle(
                                          fontFamily: "Inter",
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400,
                                          color: Color(0xff000000),
                                          height: 24 / 20,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 30,
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          productInfo(
                                              "Quantity in hand", 450, false),
                                          SizedBox(
                                            height: 15,
                                          ),
                                          productInfo("Quantity to be received",
                                              50, false),
                                          SizedBox(
                                            height: 15,
                                          ),
                                          productInfo(
                                              "Quantity to be delivered",
                                              250,
                                              false),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          // Large container 4
                          Expanded(
                            child: Container(
                              decoration: const BoxDecoration(
                                color: white,
                              ),
                              // Add your widgets for the large container 4 here
                              child: Column(
                                children: [
                                  Expanded(
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Center(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  "Purchase order",
                                                  style: TextStyle(
                                                    color: black,
                                                    fontSize: 15,
                                                  ),
                                                ),
                                                SizedBox(height: 10),
                                                Container(
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: dark,
                                                        width: 0.5),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0),
                                                  ),
                                                  width: 550,
                                                  height: 180,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                "Top selling items",
                                                style: TextStyle(
                                                  color: black,
                                                  fontSize: 15,
                                                ),
                                              ),
                                              SizedBox(height: 10),
                                              Container(
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: dark, width: 0.5),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                ),
                                                width: 550,
                                                height: 180,
                                                child: Row(
                                                  children: [
                                                    Container(
                                                      width: 170,
                                                      // content of the first section
                                                    ),
                                                    VerticalDivider(
                                                      color: dark,
                                                      thickness: 0.5,
                                                    ),
                                                    Container(
                                                      width: 170,
                                                      // content of the second section
                                                    ),
                                                    VerticalDivider(
                                                      color: dark,
                                                      thickness: 0.5,
                                                    ),
                                                    Container(
                                                      width: 170,
                                                      // content of the first section
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Container(
                                          width: 350,
                                          height: 220,
                                          color: Colors.yellow,
                                        ),
                                        Container(
                                          width: 750,
                                          height: 220,
                                          color: Colors.yellow,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ));
  }

  Widget productInfo(String title, int number, bool showPrduct) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.w400,
            color: dark,
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              number.toString(),
              style: TextStyle(fontWeight: FontWeight.w400, color: orange),
              textAlign: TextAlign.center,
            ),
            Divider(
              height: 5,
            ),
            showPrduct
                ? Text(
                    "Products",
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.center,
                  )
                : Container()
          ],
        )
      ],
    );
  }
}
