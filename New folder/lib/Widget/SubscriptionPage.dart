import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'CardWidget2.dart';
import 'NavigationDrawerWidget.dart';

class SubscriptionPage extends StatefulWidget {
  @override
  SubscriptionPageState createState() => SubscriptionPageState();
}

class SubscriptionPageState extends State<SubscriptionPage> {
  @override
  Widget build(BuildContext context) => Scaffold(
      // drawer: NavigationDrawerWidget(),
      appBar: AppBar(
        title: Text("Career vault"),
      ),
      body: Container(
          margin: EdgeInsets.all(30),
          decoration: const BoxDecoration(color: Colors.white),
          child: SingleChildScrollView(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CardWidget(
                  pkgText: "Monthly",
                  pkgPrice: 2000,
                  pkgduration: "30 days",
                  color: Colors.blue,
                  pkgid: 4),
              SizedBox(height: 100),
              CardWidget(
                  pkgText: "Quaterly",
                  pkgPrice: 4000,
                  pkgduration: "91 days",
                  color: Colors.blue,
                  pkgid: 14),
              SizedBox(height: 100),
              CardWidget(
                  pkgText: "Bi annually",
                  pkgPrice: 6000,
                  pkgduration: "184 days",
                  color: Color.fromRGBO(225, 245, 254, 1),
                  pkgid: 24),
              SizedBox(height: 100),
              CardWidget(
                  pkgText: "Annually",
                  pkgPrice: 7000,
                  pkgduration: "365 days",
                  color: Colors.lightBlue.shade50,
                  pkgid: 34),
            ],
          ))));
}
