import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class payment extends StatefulWidget {
  payment({required this.title});
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<payment> {
  static const platform = const MethodChannel('com.flutter.khurramdev');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Container(
            child: Column(
          children: <Widget>[
            TextButton(
              child: Center(child: Text("start")),
              onPressed: () {
                start();
              },
            ),
          ],
        )));
  }

  void start() async {
    Map<String, String> data = {
      "price": "400000",
      "Jazz_MerchantID": "MC51551",
      "Jazz_Password": "xy2t853zf9",
      "Jazz_IntegritySalt": "xz33x2y29d",
      "paymentReturnUrl":
          "https://sandbox.jazzcash.com.pk/ApplicationAPI/API/Payment/DoTransaction"
    };
    String value = "";

    try {
      value = await platform.invokeMethod("Print", data);
    } catch (e) {
      print(e);
    }

    print(value.toString());
  }
}
