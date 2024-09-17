import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iiitnrapp2/Gatepass.dart';
import 'package:iiitnrapp2/Utility.dart';
import 'package:url_launcher/url_launcher.dart';

class Contacts extends StatefulWidget {
  ContactsPage createState() => ContactsPage();
}

class ContactsPage extends State<Contacts> {

  List _contacts = [];

  // Fetch content from the json file
  Future<void> readJson() async {
    final String response = await rootBundle.loadString('assets/data.json');
    final data = await json.decode(response);
    setState(() {
      _contacts = data["contacts"];
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
      body: Center(
        child: Column(
          children: [
            for(var contact in _contacts)
              Container(
                  margin: const EdgeInsets.only(left: 20.0, right: 20.0, top: 10, bottom: 10),
                  height: 75,
                  decoration: BoxDecoration(
                    color: Colors.purpleAccent,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(contact["name"]),
                              Text(contact["position"]),
                            ],
                          )
                        ),
                        Text(contact["number"]),
                        IconButton(
                            icon: Icon(Icons.content_copy),
                            onPressed: () async {
                              await Clipboard.setData(ClipboardData(text: contact["number"]));
                              Utility.MobileAlert(context, "Copied to clipboard");
                            },
                        ),
                        IconButton(
                          icon: Icon(Icons.phone),
                          onPressed: () async {
                            Uri url = Uri(scheme: "tel", path: contact["number"]);
                            if (await canLaunchUrl(url)) {
                              await launchUrl(url);
                            } else {
                              throw 'Could not launch $url';
                            }
                          },
                        ),
                      ],
                  ),
              ),
          ],
        ),
      ),
    );
  }
}