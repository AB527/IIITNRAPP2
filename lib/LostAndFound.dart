import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iiitnrapp2/Gatepass.dart';
import 'package:url_launcher/url_launcher.dart';

class LostAndFound extends StatefulWidget {
  LostAndFoundPage createState() => LostAndFoundPage();
}

class LostAndFoundPage extends State<LostAndFound> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Lost and Found"),
        ),
        body: Center(
            child: Text("Lost and Found")
        )
    );
  }

}