import 'dart:collection';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iiitnrapp2/Gatepass.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactDevelopers extends StatefulWidget {
  ContactDevelopersPage createState() => ContactDevelopersPage();
}

class ContactDevelopersPage extends State<ContactDevelopers> {

  List _contactdevelopers_dl = [], _contactdevelopers_leads = [];

  // Fetch content from the json file
  Future<void> readJson() async {
    final String response = await rootBundle.loadString('assets/data.json');
    final data = await json.decode(response);
    setState(() {
      _contactdevelopers_dl = data["contactdevelopers"]["developers"];
      _contactdevelopers_leads = data["contactdevelopers"]["leads"];
    });
  }

  Widget openNewPage(page) {
    return Gatepass();
  }

  @override
  void initState() {
    super.initState();
    readJson();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contacts"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 10, bottom: 10),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                    for(var lead in _contactdevelopers_leads)
                        ClipOval(
                          child: SizedBox.fromSize(
                            size: Size.fromRadius(75),
                            child: Image.asset(
                              "assets/images/contactdevelopers/"+lead["image"]+".jpg",
                              fit: BoxFit.cover,
                              height: 150,
                              width: 150,
                            ),
                          )
                        )
                  ],
              ),
              for(var lead in _contactdevelopers_leads)
                Card(
                  margin: const EdgeInsets.only(left: 20, right: 20, top: 30),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      lead["description"]!,
                      style: new TextStyle(
                          fontSize: 20.0
                      ),
                    )
                  ),
                ),
              Padding(
                  padding: const EdgeInsets.only(top: 20, bottom: 10),
                  child: Text(
                      "Current Developers",
                      textAlign: TextAlign.center,
                      style: new TextStyle(
                          fontSize: 30
                      ),
                  )
              ),
              for(var developer in _contactdevelopers_dl)
                  Container(
                    margin: const EdgeInsets.only(
                        left: 20.0, right: 20.0, top: 10, bottom: 10),
                    child: Row(
                      children: [
                        Padding(
                            padding: EdgeInsets.only(left: 10, right: 10, top: 7, bottom: 7),
                            child: ClipOval(
                                child: SizedBox.fromSize(
                                  size: Size.fromRadius(30),
                                  child: Image.asset(
                                    "assets/images/contactdevelopers/"+developer["image"]+".jpg",
                                      fit: BoxFit.cover,
                                  ),
                                )
                            )
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(developer["name"]),
                            Text(developer["email"]),
                          ],
                        ),
                      ],

                    ),
                    height: 75,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  )
            ],
          ),
        ),
      )
    );
  }
}