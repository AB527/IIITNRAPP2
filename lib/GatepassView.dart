import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iiitnrapp2/Gatepass.dart';
import 'package:iiitnrapp2/Utility.dart';
import 'package:url_launcher/url_launcher.dart';


class GatepassView extends StatelessWidget {

  var passData;

  GatepassView(this.passData);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("View your pass"),
        ),
        body: Center(
            child: Column(
              children: [
                  Text(
                      "Entry pass",
                      style: TextStyle(
                        fontSize: 25
                      ),
                  ),
                  Padding(padding: EdgeInsets.only(top: 20, bottom: 20),
                    child: ClipRRect(
                    borderRadius: BorderRadius.circular(20), // Image border
                    child: Image.asset(
                          'assets/images/qr_code_sample.png',
                          fit: BoxFit.cover,
                          height: 200,
                          width: 200,
                      ),
                    ),
                  ),
                  Text(
                    passData["name"],
                    style: TextStyle(
                        fontSize: 25
                    ),
                  ),
                  Container(
                        width: double.infinity,
                        child: Card(
                          margin: const EdgeInsets.only(top: 30, left: 30, right: 30),
                          child: Padding(
                              padding: const EdgeInsets.only(left: 20, top: 15, bottom: 15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Type: "+Utility.capitalize(passData["type"].toString())),
                                    if(passData["type"]=="daily") Text("Date: "+passData["passData"]["outDate"]),
                                    Text("From: "+passData["passData"][passData["type"]=="daily"?"outTime":"fromDate"]),
                                    Text("To: "+passData["passData"][passData["type"]=="daily"?"inTime":"toDate"]),
                                    Text("Location: "+passData["location"]),
                                    Text("Purpose: "+passData["purpose"]),
                                    Text("Approved by: "+passData["approved_by"]),
                                  ]
                              )
                          ),
                        ),
                  )
              ],
            )
        )
    );
  }

}