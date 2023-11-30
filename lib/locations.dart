// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:stock_manager/config/parameter.dart';
import 'package:stock_manager/config/style.dart';
import 'package:stock_manager/functions/product_function.dart';
import 'package:stock_manager/load_page.dart';
import 'package:stock_manager/pages/locations/details.dart';
import 'package:stock_manager/pages/suppliers/details.dart';
import 'package:stock_manager/widgets/help_button.dart';
import 'package:stock_manager/widgets/location/location.dart';

class LocationPage extends StatefulWidget {
  const LocationPage({super.key});

  @override
  State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  bool load = true;

  bool details = false;

  setStatePage() {
    setState(() {});
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() async {
    setState(() {
      load = true;
    });

    await getLocations();

    setState(() {
      load = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return load
        ? LoadPage()
        : Scaffold(
            backgroundColor: gray,
            body: SafeArea(
                child: Row(
              children: [
                Expanded(
                    flex: 8,
                    child: details
                        ? DetailLocation(
                            id: id_location,
                            setParent: setStatePage,
                            back: () async {
                              setState(() {
                                details = false;
                              });
                              await getData();
                            },
                          )
                        : Scaffold(
                            appBar: AppBar(
                              backgroundColor: white,
                              toolbarHeight: 80,
                              elevation: 0,
                              automaticallyImplyLeading: false,
                              actions: const [
                                HelpButton(),
                                SizedBox(
                                  width: 20,
                                )
                              ],
                              title: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: SizedBox(
                                      height: 40,
                                      width: 50,
                                      child: TextField(
                                        controller: searchLocationsController,
                                        decoration: InputDecoration(
                                          hintText: "Search",
                                          prefixIcon: Icon(Icons.search),
                                          border: OutlineInputBorder(),
                                        ),
                                        onChanged: (value) {
                                          setState(() {
                                            // searchLocationsController.text = value;
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 18),
                                  ElevatedButton(
                                    onPressed: () {
                                      setState(() {
                                        id_location = null;
                                        details = true;
                                      });
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: white,
                                      shadowColor: primaryColor,
                                      surfaceTintColor: primaryColor,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20,
                                          vertical:
                                              10), // Set the button's padding
                                    ),
                                    child: const Text(
                                      "Add Location",
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: black,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            body: ListView.builder(
                              itemCount: locationsLoad.length,
                              itemBuilder: (context, index) {
                                return location(
                                  locationsLoad[index]['id'].toString(),
                                  locationsLoad[index]['name'],
                                  locationsLoad[index]['location'] ?? "",
                                  locationsLoad[index]['products']
                                      .length
                                      .toString(),
                                  context,
                                  () {
                                    details = true;
                                    setStatePage();
                                  },
                                );
                              },
                            ),
                          )),
              ],
            )),
          );
  }
}
