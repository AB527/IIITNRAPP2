import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iiitnrapp2/Complaints.dart';
import 'package:iiitnrapp2/GatepassHistory.dart';
import 'package:iiitnrapp2/GatepassNew.dart';

class Gatepass extends StatefulWidget {
  GatepassPage createState() => GatepassPage();
}

class GatepassPage extends State<Gatepass> {

  List _gatepassOptions = [];

  // Fetch content from the json file
  Future<void> readJson() async {
    final String response = await rootBundle.loadString('assets/data.json');
    final data = await json.decode(response);
    setState(() {
      _gatepassOptions = data["gatepass"]["options"];
    });
  }

  Widget openNewPage(page) {
    if(page == "gatepass_new") return GatepassNew();
    if(page == "gatepass_history") return GatepassHistory();
    return GatepassNew();
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
        title: Text("Gatepass"),
      ),
      body: Center(
        child: GridView.count(
          padding: const EdgeInsets.only(left: 20, right: 20),
          crossAxisCount: 2,
          crossAxisSpacing: 25,
          mainAxisSpacing: 25,
          children: [
            for(var option in _gatepassOptions)
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