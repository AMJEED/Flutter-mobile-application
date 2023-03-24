import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:select_modal_flutter/select_modal_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trivia_app/SharedPrefrencesFiles/VersionSharedPrefs.dart';
import 'package:trivia_app/home_screen.dart';

import '../Widget/NavigationDrawerWidget.dart';

import '../Widget/error.dart';
import 'SharedPrefrencesFiles/UserNameprefs.dart';
import 'SharedPrefrencesFiles/isLogedIn.dart';
import 'Widget/loaderWidget.dart';
import 'api_provider.dart';
import 'card_details.dart';
import 'mcq-question-databank-api-provider.dart';
import 'question.dart';
import 'quizApp_api.dart';
import 'start_screen.dart';

class JobSelecionScreen extends StatefulWidget {
  const JobSelecionScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<JobSelecionScreen> createState() => _JobSelecionScreen();
}

class _JobSelecionScreen extends State<JobSelecionScreen> {
// Obtain shared preferences.

  TextEditingController controllerjob = TextEditingController();
  TextEditingController controllerClass = TextEditingController();
  // TextEditingController controllerCountry = TextEditingController();
  // TextEditingController controllerName = TextEditingController();

  late bool errorSelectJob;
  late bool errorSelectClass;
  String name = "";
  // late bool isFreeVersion = getversion() == "Premium" ? false : true;
  final List<String> level = ['easy', 'medium', 'hard'];
  final List<String> levelLowercase = [
    'remember',
    'understand',
    'apply',
    'analyze',
    'evaluate',
    'create'
  ];

  void initState() {
    // TODO: implement initState
    super.initState();
    errorSelectClass = false;
    errorSelectJob = false;

    Future n = userNamePrefrence().getName();
    n.then((data) async {
      name = data;
    });
  }

  List<ItemSelect> listItemSelectJobs = [
    const ItemSelect(value: 1, label: 'PST'),
    const ItemSelect(value: 2, label: 'JEST'),
    const ItemSelect(value: 3, label: 'SST'),
    const ItemSelect(value: 4, label: 'HST'),
    // const ItemSelect(value: 5, label: 'University Lecturer'),
    // const ItemSelect(value: 6, label: 'SST'),
    // const ItemSelect(value: 7, label: 'PST'),
    // const ItemSelect(value: 8, label: 'JST'),
    // const ItemSelect(value: 9, label: 'NTHP'),
  ];

  List<ItemSelect> listItemSelectClass = [
    const ItemSelect(value: 1, label: 'Primary'),
    const ItemSelect(value: 2, label: 'Secondary'),
    const ItemSelect(value: 3, label: 'Higher Secondary'),
    const ItemSelect(value: 4, label: 'UnderGraduate'),
    const ItemSelect(value: 5, label: 'PostGraduate'),
    // const ItemSelect(value: 6, label: 'Ten'),
    // const ItemSelect(value: 7, label: 'Eleven'),
    // const ItemSelect(value: 8, label: 'twelve'),
  ];

  @override
  void dispose() {
    controllerjob.dispose();

    super.dispose();
  }

  final box = GetStorage();

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
          // In other cases you have a valid data and you can shot content
          return Scaffold(
            drawer: snapshot.data == true
                ? NavigationDrawerWidget(
                    name: name,
                  )
                : null,
            appBar: AppBar(
              title: Text('Career vault'),
              elevation: 0,
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Hero(
                        tag: cardDetailList[1].iconTag,
                        child: Image.asset(
                          cardDetailList[1].iconAssetName,
                          height: 200,
                          width: 200,
                        ),
                      ),
                      const Text(
                        '''Select the job and Class for which 
          you want to prepare
                        ''',
                        style: TextStyle(
                            color: Color.fromARGB(255, 3, 3, 3),
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 5),
                      SizedBox(height: 10.0),
                      const SizedBox(
                        height: 15.0,
                      ),
                      SelectModalFlutter(
                        icon:
                            const IconData(0xef90, fontFamily: 'MaterialIcons'),
                        title: 'Select the Job ',
                        searchText: 'Jobs',
                        controller: controllerjob,
                        listItemSelect: listItemSelectJobs,
                        borderTextField: InputBorder.none,
                        boxDecoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                          color: Colors.white,
                          border: Border.all(color: Colors.grey, width: 1.0),
                        ),
                      ),
                      errorSelectJob
                          ? Text(
                              'Please select any value',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 238, 19, 19)
                                      .withOpacity(0.5),
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold),
                            )
                          : const SizedBox(
                              height: 15.0,
                            ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      SelectModalFlutter(
                        icon:
                            const IconData(0xef90, fontFamily: 'MaterialIcons'),
                        title: 'Select the class',
                        searchText: 'Class',
                        controller: controllerClass,
                        listItemSelect: listItemSelectClass,
                        borderTextField: InputBorder.none,
                        boxDecoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                          color: Colors.white,
                          border: Border.all(color: Colors.grey, width: 1.0),
                        ),
                      ),
                      errorSelectClass
                          ? Text(
                              'Please select any value',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 238, 19, 19)
                                      .withOpacity(0.5),
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold),
                            )
                          : const SizedBox(
                              height: 15.0,
                            ),
                      SizedBox(height: 20.0),
                      ElevatedButton(
                        child: Container(
                          color: Color.fromARGB(255, 32, 142, 245),
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 100),
                          child: const Text(
                            'Next',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        onPressed: () {
                          if (controllerjob.text.isEmpty) {
                            setState(() {
                              errorSelectJob = true;
                            });
                          } else if (controllerClass.text.isEmpty) {
                            setState(() {
                              errorSelectClass = true;
                            });
                          } else {
                            debugPrint(controllerjob.text);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => HomeScreen(
                                        selectedjob: controllerjob.text)));
                          }
                        },
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

  getversion() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    String? stringValue = prefs.getString('version');
    return stringValue;
  }
}
