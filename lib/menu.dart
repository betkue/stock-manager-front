import 'package:flutter/material.dart';
import 'package:stock_management/constant.dart';

class Menu extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final Widget? child;
  final Color? color;
  final EdgeInsetsGeometry? padding;
  final Function select;

  const Menu(
      {super.key,
      required this.scaffoldKey,
      required this.select,
      this.child,
      this.color,
      this.padding});

  @override
  State createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  // _MenuState(this.child, this.color, this.padding);

  List<MenuModel> menu = [
    MenuModel(icon: Icons.dashboard_outlined, title: "Dashboard"),
    MenuModel(icon: Icons.sell_sharp, title: "Product"),
    MenuModel(icon: Icons.people, title: "Customer"),
    MenuModel(icon: Icons.emoji_people, title: "Supplier"),
    MenuModel(icon: Icons.card_travel, title: "Purchase"),
    MenuModel(icon: Icons.stacked_bar_chart_outlined, title: "Stock"),
    MenuModel(icon: Icons.sell, title: "Sales"),
    MenuModel(icon: Icons.account_box, title: "Account"),
  ];

  int selected = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      decoration: const BoxDecoration(
          border: Border(
            right: BorderSide(
              color: white,
              width: 1,
            ),
          ),
          color: backgroundColor),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: selected == 0 ? logo : logo,
            ),
            child: Center(
              child: Image.asset(
                "images/Logo.png",
                height: 80,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: SingleChildScrollView(
                child: Column(
              children: [
                SizedBox(
                  height: Responsive.isMobile(context) ? 8 : 10,
                ),
                Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(MediaQuery.of(context).size.height),
                      ),
                      color: widget.color ?? orange,
                    ),
                    child: Image.asset(
                      "assets/images/avatar.png",
                      fit: BoxFit.cover,
                    )),
                const SizedBox(
                  height: 15,
                ),
                const Text(
                  "Michelle",
                  style: TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w600, color: white),
                ),
                const SizedBox(
                  height: 2,
                ),
                Text(
                  "michelle@gmail.com ",
                  style: TextStyle(
                    fontSize: 12,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                SizedBox(
                  height: Responsive.isMobile(context) ? 20 : 40,
                ),
                for (var i = 0; i < menu.length; i++)
                  Container(
                    width: MediaQuery.of(context).size.width / 12,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(6.0),
                      ),
                    ),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          selected = i;
                          widget.select(i);
                        });
                        widget.scaffoldKey.currentState!.closeDrawer();
                      },
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 13, vertical: 7),
                            child: Icon(
                              menu[i].icon,
                              color: selected == i ? orange : white,
                            ),
                            // color: selected == i ? orange : white,
                          ),
                          Text(
                            menu[i].title,
                            style: TextStyle(
                                fontSize: 16,
                                color: selected == i ? orange : white,
                                fontWeight: selected == i
                                    ? FontWeight.w600
                                    : FontWeight.normal),
                          )
                        ],
                      ),
                    ),
                  ),
              ],
            )),
          ),
        ],
      ),
    );
  }
}

class Responsive {
  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 850;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width < 1100 &&
      MediaQuery.of(context).size.width >= 850;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 1100;
}

class MenuModel {
  IconData icon;
  String title;
  MenuModel({required this.icon, required this.title});
}
