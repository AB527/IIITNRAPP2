import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iiitnrapp2/Complaints.dart';
import 'package:iiitnrapp2/GatepassView.dart';
import 'package:iiitnrapp2/Utility.dart';

class GatepassNew extends StatefulWidget {
  GatepassNewPage createState() => GatepassNewPage();
}

class GatepassNewPage extends State<GatepassNew> {

  bool _isPassTypeDaily = true, _isCheckboxSelected = false;
  Map<String, String> _dailyPassData = {
      "outDate": "",
      "outTime": ""
  }, _homePassData = {
        "fromDate": "",
        "toDate": ""
  };

  final TextEditingController purposeController = TextEditingController();
  final TextEditingController locationController = TextEditingController();

  Map<String, String> setNowDateTime() {
    var now = new DateTime.now().toLocal();
    return {
      "outDate": now.day.toString()+"-"+now.month.toString()+"-"+now.year.toString(),
      "outTime": now.hour.toString()+":"+now.minute.toString()
    };
  }
  Map<String, String> setTwoDayGap() {
    var now = new DateTime.now().toLocal();
    var next = now.add(const Duration(days: 2));
    return {
      "fromDate": now.day.toString()+"-"+now.month.toString()+"-"+now.year.toString(),
      "toDate": next.day.toString()+"-"+next.month.toString()+"-"+next.year.toString()
    };
  }

  void onPassTypeChange(isDaily) {
    setState(() {
      _isPassTypeDaily = isDaily;
    });
    if(isDaily) {
      setState(() {
        _dailyPassData = setNowDateTime();
      });
    }
  }

  void onNewPassRequest() {
    var msg = "";
    if (purposeController.text.trim().isEmpty) return Utility.MobileAlert(context, 'Please enter purpose');
    if (locationController.text.trim().isEmpty) return Utility.MobileAlert(context, 'Please enter location');
    if (!_isCheckboxSelected) return Utility.MobileAlert(context, "Accept the checkbox to proceed");
    var dailyPassDataTemp = _dailyPassData;
    dailyPassDataTemp["inTime"] = "22:30";
    Navigator.push(context, MaterialPageRoute(builder: (context) => GatepassView({
      "name": "BEDEKAR ATHARVA SURESH",
      "type": _isPassTypeDaily ? "daily" : "home",
      "passData": _isPassTypeDaily ? dailyPassDataTemp : _homePassData,
      "purpose": purposeController.text.trim(),
      "location": locationController.text.trim(),
      "approved_by": "Raman House"
    })));
}

  @override
  void initState() {
    super.initState();
    setState(() {
      _dailyPassData = setNowDateTime();
      _homePassData = setTwoDayGap();
    });
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    purposeController.dispose();
    locationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Gatepass New"),
      ),
      body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Home pass available : 4",
                style: new TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold
                ),
              ),
              Text(
                  "For month of September",
                  style: new TextStyle(
                      fontWeight: FontWeight.bold
                  )
              ),
              Padding(
                  padding: EdgeInsets.only(top: 50, bottom: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        onTap: () {
                          onPassTypeChange(true);
                        },
                        child: Container(
                          child: Center(
                              child: Text(
                                  "Daily Pass",
                                  style: TextStyle(
                                      fontSize: 27
                                  ),
                                textAlign: TextAlign.center,
                              )
                          ),
                          width: 125,
                          height: 100,
                          decoration: BoxDecoration(
                            color: _isPassTypeDaily?Colors.green:Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        )
                      ),
                      InkWell(
                          onTap: () {
                            onPassTypeChange(false);
                          },
                          child: Container(
                            child: Center(
                                child: Text(
                                  "Home Pass",
                                  style: TextStyle(
                                      fontSize: 27
                                  ),
                                  textAlign: TextAlign.center,
                                )
                            ),
                            width: 125,
                            height: 100,
                            decoration: BoxDecoration(
                              color: !_isPassTypeDaily?Colors.green:Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                          )
                      ),
                  ],
                )
              ),
              Padding(
                  padding: EdgeInsets.only(left: 30, right: 30, bottom: 30),
                  child: TextField (
                      controller: purposeController,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Purpose',
                          hintText: 'Please enter purpose'
                      )
                  )
              ),
              Padding(
                  padding: EdgeInsets.only(left: 30, right: 30, bottom: 30),
                  child: TextField (
                      controller: locationController,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Location',
                          hintText: 'Please enter location'
                      )
                  )
              ),
              Container(
                  child: Center(
                      child: Text(
                          _isPassTypeDaily ?
                              _dailyPassData["outTime"]!+"\n"+_dailyPassData["outDate"]!
                              : "From: "+_homePassData["fromDate"]!+"\nTo: "+_homePassData["toDate"]!,
                          style: TextStyle(
                              fontSize: 30,
                          ),
                        textAlign: TextAlign.center,
                      )
                  ),
                height: 100,
                width: 275,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              Padding(
                  padding: EdgeInsets.only(top: 20, bottom: 20),
                  child: Align(
                      alignment: Alignment.center,
                      child: Container(
                          width: 300,
                          child: CheckboxListTile(
                            title: Text("I am going at my own risk"),
                            value: _isCheckboxSelected,
                            onChanged: (newValue) {
                              setState(() {
                                _isCheckboxSelected = newValue!;
                              });
                            },
                            controlAffinity: ListTileControlAffinity.leading,  //  <-- leading Checkbox
                          )
                      )
                  ),
              ),
              TextButton(
                child: Text(
                  'Request',
                  style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.white
                  ),
                ),
                style: TextButton.styleFrom(
                    backgroundColor: Colors.blueAccent
                ),
                onPressed: () { onNewPassRequest(); },
              ),
            ]
          ),
      )
    );
  }
}