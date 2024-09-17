import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iiitnrapp2/BuyAndSell.dart';
import 'package:iiitnrapp2/Complaints.dart';
import 'package:iiitnrapp2/ContactDevelopers.dart';
import 'package:iiitnrapp2/Contacts.dart';
import 'package:iiitnrapp2/Gatepass.dart';
import 'package:iiitnrapp2/LostAndFound.dart';
import 'package:iiitnrapp2/Utility.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'IIIT NR APP',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'IIIT NR APP'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  List _homeOptions = [];
  final String name = "BEDEKAR ATHARVA SURESH";
  String _timeCode = "morning";

  // Fetch content from the JSON file
  Future<void> readJson() async {
    final String response = await rootBundle.loadString('assets/data.json');
    final data = await json.decode(response);
    setState(() {
      _homeOptions = data["home"]["options"];
    });
  }

  Future<void> _showLogoutDialog() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Logout'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Do you want to logout ?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Logout'),
              onPressed: () {
                Navigator.of(context).pop();
                Utility.MobileAlert(context, "Logging you out...");
              },
            ),
          ],
        );
      },
    );
  }

  Widget openNewPage(String page) {
    switch (page) {
      case "complaints":
        return Complaints();
      case "gatepass":
        return Gatepass();
      case "buyandsell":
        return BuyAndSell();
      case "contacts":
        return Contacts();
      case "lostandfound":
        return LostAndFound();
      case "contactdevelopers":
        return ContactDevelopers();
      default:
        return Complaints();
    }
  }

  @override
  void initState() {
    super.initState();
    readJson();
    final now = DateTime.now().toLocal();
    setState(() {
      if (now.hour >= 12 && now.hour <= 17) {
        _timeCode = "afternoon";
      } else if (now.hour >= 17 || now.hour <= 6) {
        _timeCode = "evening";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/home_welcome/welcome_" +
                  (_timeCode == "morning"
                      ? "morning_3"
                      : _timeCode == "afternoon"
                      ? "afternoon_3"
                      : "evening_5") +
                  ".png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                  Container(
                    margin: const EdgeInsets.only(top: 50, bottom: 25, left: 30),
                    width: 300,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Good " + Utility.capitalize(_timeCode) + ",",
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: _timeCode == "evening"
                                ? Colors.white
                                : Colors.black,
                          ),
                          textAlign: TextAlign.start,
                        ),
                        Text(
                          name,
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: _timeCode == "evening"
                                ? Colors.white
                                : Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                      color: Colors.white,
                    ),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.7,
                        child: GridView.count(
                          physics: const NeverScrollableScrollPhysics(),
                          padding: const EdgeInsets.only(
                              left: 30, right: 30, top: 40),
                          crossAxisCount: 2,
                          crossAxisSpacing: 25,
                          mainAxisSpacing: 25,
                          children: [
                            for (var option in _homeOptions)
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          openNewPage(option["link"]),
                                    ),
                                  );
                                },
                                child: Container(
                                  child: Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        IconData(
                                          int.parse(option["logo"]),
                                          fontFamily: 'MaterialIcons',
                                        ),
                                      ),
                                      Text(
                                        option["name"],
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  ),
                                  height: 100,
                                  width: 100,
                                  decoration: BoxDecoration(
                                    color: Colors.purpleAccent,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                          ],
                        ),
                    ),
                  ),
                  Container(
                      child:Column(
                          children: [
                            Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.grey.shade200,
                              ),
                              // height: 50,
                              margin: EdgeInsets.only(left: 30, right: 30, bottom: 20),
                              padding: EdgeInsets.only(left: 20, top: 15, bottom: 15),
                              child: Text(
                                  "Switch theme",
                              ),

                            ),
                            InkWell(
                              onTap: () {
                                _showLogoutDialog();
                              },
                              child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.grey.shade200,
                                ),
                                // height: 50,
                                margin: EdgeInsets.only(left: 30, right: 30, bottom: 30),
                                padding: EdgeInsets.only(left: 20, top: 15, bottom: 15),
                                child: Text(
                                  "Sign Out",
                                ),

                              ),
                            )
                          ]
                      ),
                    color: Colors.white,
                  )
              ],
          ),
      ),
      ));
  }
}
