import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:trivia_app/JobSeclectionScreen.dart';

import 'package:trivia_app/signup_screen.dart';

import 'SharedPrefrencesFiles/VersionSharedPrefs.dart';
import 'SharedPrefrencesFiles/isLogedIn.dart';
import 'login_screen.dart';
import 'start_screen.dart';

class VersionScreen extends StatelessWidget {
  const VersionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String? selectedVersion;
    return Scaffold(
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
                  height: 130,
                  width: 150,
                ),
              ),

              const Center(
                child: Text(
                  "\n Career Vault",
                  style: TextStyle(
                      fontSize: 24,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              ),

              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: const Text(
                  '''Select the version you want to use''',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18.0,
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              GFListTile(
                padding: const EdgeInsets.all(8),
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                color: Color(0xFFADD8E6),
                // Color.fromARGB(255, 236, 230, 138),
                onTap: () => {
                  debugPrint((loggedInSharedPrefrence().getlogin()).toString()),
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          loggedInSharedPrefrence().getlogin == true
                              ? JobSelecionScreen()
                              : SignUpScreen(),
                    ),
                  )
                },
                avatar: Image.asset(
                  'assets/images/rank.png',
                  width: 80,
                  height: 80,
                ),
                titleText: 'Premium',
                subTitleText:
                    'Use Premium version to unlock all the features with multiple options to generate the practice test',
                // icon: Icon(Icons.favorite)
              ),
              SizedBox(
                height: 10.0,
              ),
              GFListTile(
                color: Color(0xFFADD8E6),
                //Color.fromARGB(255, 137, 238, 176),
                onTap: () => {
                  VersionSharedPrefrence().setVersion(false),
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => JobSelecionScreen(),
                    ),
                  )
                },
                padding: const EdgeInsets.all(8),
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                avatar: Image.asset(
                  'assets/images/free_version.png',
                  width: 80,
                  height: 80,
                ),
                titleText: 'Free',
                subTitleText:
                    'Use Free version to get the basic features of app',

                // icon: Icon(Icons.favorite)
              ),

              // const Center(
              //   child: Text(
              //     'An app that helps the applicants for cracking the Recruitment Tests',
              //     style: TextStyle(
              //         fontSize: 20,
              //         color: Colors.black,
              //         fontWeight: FontWeight.bold),
              //   ),
              // ),
            ],
          ),
        ));
  }
}
