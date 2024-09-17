import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iiitnrapp2/ComplaintsHistory.dart';
import 'package:iiitnrapp2/ComplaintsLive.dart';
import 'package:iiitnrapp2/ComplaintsLodge.dart';
import 'package:iiitnrapp2/Gatepass.dart';

class Complaints extends StatefulWidget {
  ComplaintsPage createState() => ComplaintsPage();
}

class ComplaintsPage extends State<Complaints> {

  List _complaintsOptions = [];

  // Fetch content from the json file
  Future<void> readJson() async {
    final String response = await rootBundle.loadString('assets/data.json');
    final data = await json.decode(response);
    setState(() {
      _complaintsOptions = data["complaints"]["options"];
    });
  }

  Widget openNewPage(page) {
    if(page == "complaints_lodge") return ComplaintsLodge();
    if(page == "complaints_live") return ComplaintsLive();
    if(page == "complaints_history") return ComplaintsHistory();
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
          title: Text("Complaints"),
        ),
        body: Center(
          child: GridView.count(
            padding: const EdgeInsets.all(20),
            crossAxisCount: 3,
            crossAxisSpacing: 25,
            mainAxisSpacing: 25,
            children: [
              for(var option in _complaintsOptions)
                InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => openNewPage(option["link"])));
                  },
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                            IconData(
                                int.parse(option["logo"]),
                                fontFamily: 'MaterialIcons'
                            )
                        ),
                        Text(option["name"], textAlign: TextAlign.center)
                      ],

                    ),
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      color: Colors.purpleAccent,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                )
            ],
          ),
        ),
    );
  }
}