import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iiitnrapp2/Gatepass.dart';
import 'package:url_launcher/url_launcher.dart';

class BuyAndSell extends StatefulWidget {
  BuyAndSellPage createState() => BuyAndSellPage();
}

class BuyAndSellPage extends State<BuyAndSell> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Buy and Sell"),
      ),
      body: Center(
        child: Text("Buy and Sell")
      )
    );
  }

}