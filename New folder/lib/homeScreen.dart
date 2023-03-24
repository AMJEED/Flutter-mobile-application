import 'package:flutter/material.dart';

import 'SharedPrefrencesFiles/isLogedIn.dart';
import 'Widget/error.dart';
import 'Widget/loaderWidget.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    ThemeData appTheme = Theme.of(context);

    return FutureBuilder<bool>(
        future: loggedInSharedPrefrence().getlogin(),
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
          return Scaffold(
            backgroundColor: Colors.white,
            body: Column(children: [
              const Center(
                child: Text(
                  "\n Career vault",
                  style: TextStyle(
                      fontSize: 24,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Center(
                child: Image.asset(
                  "assets/images/home2.jpg",
                  height: 250,
                  width: 250,
                ),
              ),
              Container(
                height: size.height * 0.45,
                padding: EdgeInsets.all(22),
                alignment: Alignment.bottomCenter,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(height: 10),
                    Text(
                      "Looking to ace your recruitment tests and land your dream job? Our app is here to help!, we'll give you the tools you need to succeed and stand out from the competition.",
                      maxLines: 4,
                      overflow: TextOverflow.fade,
                      style: appTheme.textTheme.bodyText1,
                    ),
                    SizedBox(height: 18),
                    ElevatedButton(
                        onPressed: () {
                          // Navigator.pushNamed(context, AppRoutes.ROUTE_Home);
                        },
                        style: ElevatedButton.styleFrom(
                            primary: appTheme.accentColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)),
                            elevation: 0,
                            textStyle: TextStyle(
                                fontSize: 18,
                                fontFamily: 'PlayFair',
                                fontWeight: FontWeight.bold)),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text("Generate Practice Test! "),
                        ))
                  ],
                ),
              )
            ]),
          );
        });
  }
}
