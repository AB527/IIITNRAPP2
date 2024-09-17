import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iiitnrapp2/Gatepass.dart';
import 'package:url_launcher/url_launcher.dart';

class GatepassHistory extends StatefulWidget {
  GatepassHistoryPage createState() => GatepassHistoryPage();
}

class GatepassHistoryPage extends State<GatepassHistory> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("History"),
        ),
        body: Center(
            child: Text("History")
        )
    );
  }

}