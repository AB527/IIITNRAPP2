import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iiitnrapp2/Gatepass.dart';
import 'package:url_launcher/url_launcher.dart';

class ComplaintsLodge extends StatefulWidget {
  ComplaintsLodgePage createState() => ComplaintsLodgePage();
}

class ComplaintsLodgePage extends State<ComplaintsLodge> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Lodge Complaint"),
        ),
        body: Center(
            child: Text("Lodge Complaint")
        )
    );
  }

}