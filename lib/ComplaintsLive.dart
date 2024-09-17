import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iiitnrapp2/Gatepass.dart';
import 'package:url_launcher/url_launcher.dart';

class ComplaintsLive extends StatefulWidget {
  ComplaintsLivePage createState() => ComplaintsLivePage();
}

class ComplaintsLivePage extends State<ComplaintsLive> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Live Complaint"),
        ),
        body: Center(
            child: Text("Live Complaint")
        )
    );
  }

}