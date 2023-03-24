import 'dart:convert';

import 'package:flutter_platform_alert/flutter_platform_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:trivia_app/login_screen.dart';

import '../SharedPrefrencesFiles/TokenSharedPrefs.dart';
import '../SharedPrefrencesFiles/UserIdSharedPrefs.dart';
import '../SharedPrefrencesFiles/VersionSharedPrefs.dart';
import 'error.dart';
import 'loaderWidget.dart';

class CardWidget extends StatefulWidget {
  const CardWidget(
      {Key? key,
      required this.pkgid,
      required this.pkgText,
      required this.pkgPrice,
      required this.pkgduration,
      required this.color})
      : super(key: key);
  final String pkgText;
  final int pkgPrice;
  final String pkgduration;
  final Color color;
  final int pkgid;
  @override
  CardWidgetState createState() => CardWidgetState();
}

class CardWidgetState extends State<CardWidget> {
  late bool processing;
  late bool isSubscribedSuceefully;
  late String responce;
  late String token;
  late String id;
  late bool isPremium;
  late SharedPreferences prefs;
  late bool v;
  static const platform = const MethodChannel('com.flutter.khurramdev');
  void initState() {
    super.initState();

    isSubscribedSuceefully = false;
    processing = false;
    responce = "";

    Future version = VersionSharedPrefrence().getVersion();
    version.then((data) async {
      v = data;
    });
    Future auth_token = SharedPrefrence().getToken();
    auth_token.then((data) async {
      token = data;
    });
    Future auth_id = SharedPrefrence2().getId();
    auth_id.then((data) async {
      id = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
        future: VersionSharedPrefrence().getVersion(),
        builder: (context, snapshot) {
          // If your data is not loading show loader
          if (!snapshot.hasData) {
            return LoaderWidget();
            // If your data is not loading show loader
          } else if (snapshot.hasError) {
            return ErrorPage(
              message: "Loading failed",
            );
          }
          return Center(
              child: Column(
            mainAxisAlignment:
                MainAxisAlignment.center, //Center Column contents vertically,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Card(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    ListTile(
                      leading: Image.asset(
                        "assets/images/rank.png",
                        fit: BoxFit.fill,
                      ),
                      title: Text("This is " +
                          widget.pkgText +
                          " package " +
                          " Price:  " +
                          widget.pkgPrice.toString() +
                          "PKR"),
                      subtitle: Text(
                          "The duration of package is " + widget.pkgduration),
                    ),
                    processing
                        ? const CircularProgressIndicator()
                        : ButtonBarTheme(
                            // make buttons use the appropriate styles for cards
                            data: const ButtonBarThemeData(),
                            child: ButtonBar(
                              children: <Widget>[
                                TextButton(
                                  style: TextButton.styleFrom(
                                    primary: Color.fromARGB(255, 246, 246, 247),
                                    backgroundColor:
                                        Color.fromARGB(255, 32, 142, 245),
                                    onSurface:
                                        Color.fromARGB(255, 143, 188, 240),
                                  ),
                                  child: const Text('Buy'),
                                  onPressed: () {
                                    if (snapshot.data == true) {
                                      alert("You have already subscribed");
                                    } else {
                                      start(widget.pkgPrice.toString() + "00");
                                      subscribe();
                                    }

                                    ;
                                  },
                                ),
                              ],
                            ),
                          ),
                  ],
                ),
                elevation: 10,
              )
            ],
          ));
        });
  }

  void start(String price) async {
    Map<String, String> data = {
      "price": widget.pkgPrice.toString() == "2000"
          ? "200000"
          : widget.pkgPrice.toString() == "4000"
              ? "400000"
              : widget.pkgPrice.toString() == "6000"
                  ? "600000"
                  : "700000",
      "Jazz_MerchantID": "MC51551",
      "Jazz_Password": "xy2t853zf9",
      "Jazz_IntegritySalt": "xz33x2y29d",
      "paymentReturnUrl":
          "https://sandbox.jazzcash.com.pk/ApplicationAPI/API/Payment/DoTransaction"
    };
    String value = "";

    try {
      value = await platform.invokeMethod("Print", data);
      return;
    } catch (e) {
      debugPrint(e.toString());
      return;
    }
  }

  subscribe() async {
    setState(() {
      processing = true;
    });

    var url =
        "https://fyp-demo.herokuapp.com/api/applicants/subscribeApplicant/" +
            id;
    // var url = "http://localhost:8080/api/applicants/subscribeApplicant/" + id;

    final http.Response response = await http.put(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'auth': token
      },
      body: jsonEncode(<String, String>{"packageId": widget.pkgid.toString()}),
    );

    if (response != null) {
      setState(() {
        processing = false;
      });
      if (response.body == '[1]') {
        debugPrint("Here is the responce" + response.body);

        VersionSharedPrefrence().setVersion(true);
        alert("Successfully Subscribed");
      } else if (response.body == 'Unauthenticated') {
        debugPrint("Anauthenticated");
      } else if (response.body == "Invalid Package Id") {
        debugPrint("Invalid Package Id");

        alert("Invalid packages Id");
      } else {
        if (json.decode(response.body)["name"] == "JsonWebTokenError") {
          debugPrint("I am inside" + response.body);
          setState(() {
            processing = false;
          });
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => LoginScreen()));
        }
      }
    } else {
      setState(() {
        processing = false;
      });
      throw Exception('Unhandled error accured');
    }

    setState(() {
      processing = false;
    });
  }

  alert(String message) async {
    final result = await FlutterPlatformAlert.showAlert(
        windowTitle: 'Information', text: message);
    print(result);
  }
}
