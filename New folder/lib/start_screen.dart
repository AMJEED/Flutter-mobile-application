import 'package:flutter/material.dart';
import 'package:trivia_app/JobSeclectionScreen.dart';
import 'package:trivia_app/SharedPrefrencesFiles/emailPrefs.dart';
import 'package:trivia_app/Version_Selection.dart';
import 'package:trivia_app/home_screen.dart';

import 'SharedPrefrencesFiles/isLogedIn.dart';
import 'Widget/NavigationDrawerWidget.dart';
import 'Widget/error.dart';
import 'Widget/loaderWidget.dart';
import 'homeScreen.dart';
import 'login_screen.dart';

class StartScreen extends StatefulWidget {
  @override
  _StartScreenState createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
              drawer: snapshot.data == true
                  ? NavigationDrawerWidget(name: "None")
                  : null,
              appBar: AppBar(
                title: Text('Career vault'),
                elevation: 0,
              ),
              resizeToAvoidBottomInset: true,
              body: SingleChildScrollView(
                child: Column(
                  //mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,

                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Image.asset(
                        "assets/images/circles.png",
                        height: 115,
                        width: 140,
                      ),
                    ),
                    const Center(
                      child: Text(
                        "\n Career vault",
                        style: TextStyle(
                            fontSize: 24,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Center(
                      child: Image.asset(
                        "assets/images/start.png",
                        height: 250,
                        width: 250,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 10),
                      child: const Text(
                        ''' An app that helps the applicants 
    for cracking the Recruitment 
                        Tests''',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        snapshot.data == true
                            ? Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => JobSelecionScreen(),
                                ),
                              )
                            : Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => VersionScreen(),
                                ),
                              );
                      },
                      child: Container(
                        color: Color.fromARGB(255, 32, 142, 245),
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 120),
                        child: const Text(
                          'Get Started',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ));
        });
  }
}
