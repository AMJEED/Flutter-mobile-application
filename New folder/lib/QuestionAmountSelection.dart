import 'dart:convert';
// import 'dart:ffi';

import 'dart:io';
import 'package:toggle_switch/toggle_switch.dart';

import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:select_modal_flutter/select_modal_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trivia_app/JobSeclectionScreen.dart';
import 'package:trivia_app/login_screen.dart';

import '../Widget/NavigationDrawerWidget.dart';
import 'package:http/http.dart' as http;
import '../Widget/error.dart';
import 'SharedPrefrencesFiles/TokenSharedPrefs.dart';
import 'SharedPrefrencesFiles/VersionSharedPrefs.dart';
import 'Widget/loaderWidget.dart';
import 'api_provider.dart';
import 'card_details.dart';
import 'mcq-question-databank-api-provider.dart';
import 'question.dart';
import 'quizApp_api.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

import 'quiz_app.dart';
import 'start_screen.dart';

class QuestionSelecionScreen extends StatefulWidget {
  const QuestionSelecionScreen(
      {Key? key,
      required this.catogoryIndex,
      required this.difficultyIndex,
      required this.taxonomyIndex,
      required this.jobSelection})
      : super(key: key);
  final int catogoryIndex;
  final int difficultyIndex;
  final int taxonomyIndex;
  final String jobSelection;

  @override
  State<QuestionSelecionScreen> createState() => _QuestionSelecionScreen();
}

class _QuestionSelecionScreen extends State<QuestionSelecionScreen> {
  TextEditingController controllerQuestion = TextEditingController();
  // TextEditingController controllerCountry = TextEditingController();
  // TextEditingController controllerName = TextEditingController();

  final List<String> testModes = [
    'Attempt',
    'Practice',
  ];

  String selectedMode = "";

  final _formKey = GlobalKey<FormState>();

  late String token;
  late bool processing;
  late bool Qprocessing;
  late bool errorSelectQuestions;
  bool? isPremiumVersion;

  late var questions;
  final List<String> level = ['easy', 'medium', 'hard'];
  final List<String> taxonomyLevel = [
    'remember',
    'understand',
    'apply',
    'analyze',
    'evaluate',
    'create'
  ];
  bool _isSelected = false;
  void initState() {
    // TODO: implement initState

    super.initState();
    _isSelected = false;
    Qprocessing = false;
    processing = false;
    questions = [];
    errorSelectQuestions = false;

    Future ver = VersionSharedPrefrence().getVersion();
    ver.then((data) async {
      isPremiumVersion = data;
    });
    selectedMode = 'practice';
    Future auth_token = SharedPrefrence().getToken();
    auth_token.then((data) async {
      token = data;
    });
  }

  List<ItemSelect> listItemSelectNumberOfQuestionsForFree = [
    const ItemSelect(value: 5, label: "5"),
  ];
  List<int> _dropdownValues = [5, 10, 15, 20, 25, 30, 35];

  List<int> _dropdownValuesFree = [
    5,
  ];
  int _selectedValue = 5;
  List<ItemSelect> listItemSelectNumberOfQuestionsForPremium = [
    const ItemSelect(value: 5, label: '5'),
    const ItemSelect(value: 10, label: '10'),
    const ItemSelect(value: 15, label: '15'),
    const ItemSelect(value: 20, label: '20'),
    const ItemSelect(value: 30, label: '30'),
  ];

  @override
  void dispose() {
    controllerQuestion.dispose();

    super.dispose();
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
          // In other cases you have a valid data and you can shot content
          return Scaffold(
              // drawer: NavigationDrawerWidget(),
              appBar: AppBar(
                leading: IconButton(
                  icon: Icon(Icons.home),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: ((context) => JobSelecionScreen()),
                        ));
                  },
                ),
                actions: [
                  IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
                title: Text('Career vault'),
                elevation: 0,
              ),
              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Hero(
                          tag: cardDetailList[1].iconTag,
                          child: Image.asset(
                            cardDetailList[1].iconAssetName,
                            height: 180,
                            width: 180,
                          ),
                        ),
                        // const Text(
                        //   'Select Mode and Question Amount',
                        //   style: TextStyle(
                        //       color: Color.fromARGB(255, 12, 12, 12),
                        //       fontSize: 20,
                        //       fontWeight: FontWeight.bold),
                        // ),
                        const SizedBox(height: 5),
                        snapshot.data == true
                            ? SizedBox(height: 10.0)
                            : Text(
                                '''Switch to premium version to unlock 
                more question options''',
                                style: TextStyle(
                                    color: Color.fromARGB(255, 212, 11, 4)
                                        .withOpacity(0.5),
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold),
                              ),
                        const SizedBox(
                          height: 15.0,
                        ),

                        DropdownButtonFormField2(
                          decoration: InputDecoration(
                            //Add isDense true and zero Padding.
                            //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
                            isDense: true,
                            contentPadding: EdgeInsets.zero,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            //Add more decoration as you want here
                            //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
                          ),
                          isExpanded: true,
                          hint: const Text(
                            'Select question ',
                            style: TextStyle(fontSize: 14),
                          ),
                          icon: const Icon(
                            Icons.arrow_drop_down,
                            color: Colors.black45,
                          ),
                          iconSize: 30,
                          buttonHeight: 60,
                          buttonPadding:
                              const EdgeInsets.only(left: 20, right: 10),
                          dropdownDecoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          items: snapshot.data == true
                              ? _dropdownValues
                                  .map((item) => DropdownMenuItem<String>(
                                        value: item.toString(),
                                        child: Text(
                                          item.toString(),
                                          style: const TextStyle(
                                            fontSize: 14,
                                          ),
                                        ),
                                      ))
                                  .toList()
                              : _dropdownValuesFree
                                  .map((item) => DropdownMenuItem<String>(
                                        value: item.toString(),
                                        child: Text(
                                          item.toString(),
                                          style: const TextStyle(
                                            fontSize: 14,
                                          ),
                                        ),
                                      ))
                                  .toList(),
                          validator: (value) {
                            if (value == null) {
                              return 'Please select any value.';
                            }
                          },
                          onChanged: (value) {
                            setState(() {
                              _selectedValue = int.parse(value.toString());
                            });
                            //Do something when changing the item if you want.
                          },
                        ),
                        // SelectModalFlutter(
                        //   icon: const IconData(0xef90,
                        //       fontFamily: 'MaterialIcons'),
                        //   title: 'Number of questions',
                        //   searchText: 'Select the number of questions',
                        //   controller: controllerQuestion,
                        //   listItemSelect: snapshot.data == true
                        //       ? listItemSelectNumberOfQuestionsForPremium
                        //       : listItemSelectNumberOfQuestionsForFree,
                        //   borderTextField: InputBorder.none,
                        //   boxDecoration: BoxDecoration(
                        //     borderRadius: BorderRadius.circular(15.0),
                        //     color: Colors.white,
                        //     border: Border.all(color: Colors.grey, width: 1.0),
                        //   ),
                        // ),
                        // errorSelectQuestions
                        //     ? Text(
                        //         'Please select any value',
                        //         style: TextStyle(
                        //             color: Color.fromARGB(255, 238, 19, 19)
                        //                 .withOpacity(0.5),
                        //             fontSize: 10,
                        //             fontWeight: FontWeight.bold),
                        //       )
                        //     : const SizedBox(
                        //         height: 15.0,
                        //       ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        Text(
                          'Select Mode',
                          style: TextStyle(
                              color: Color.fromARGB(255, 32, 142, 245),
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),

                        SizedBox(
                          width: 300,
                          height: 80,
                          child: GFListTile(
                            // icon: Icon(
                            //   Icons.follow_the_signs,
                            //   color: Color.fromARGB(255, 10, 10, 10),
                            //   size: 20.0,
                            // ),
                            color: selectedMode == "practice"
                                ? Color(0xFFADD8E6)
                                : Color.fromARGB(255, 235, 234, 229),
                            onTap: () => {
                              setState(() {
                                selectedMode = 'practice';
                              })
                            },

                            padding: const EdgeInsets.symmetric(vertical: 10),
                            // margin: EdgeInsets.symmetric(
                            //     vertical: 30, horizontal: 5),
                            avatar: Image.asset(
                              'assets/images/pencil.png',
                              width: 50,
                              height: 50,
                            ),
                            title: Text(
                              '''Practice''',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 7, 7, 7)
                                      .withOpacity(0.5),
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                            subTitleText: 'Show result',

                            // icon: Icon(Icons.favorite)
                          ),
                        ),
                        SizedBox(
                          width: 300,
                          height: 80,
                          child: GFListTile(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            // icon: Icon(
                            //   Icons.smart_button,
                            //   color: Color.fromARGB(255, 10, 10, 10),
                            //   size: 30.0,
                            // ),
                            color: selectedMode == "attempt"
                                ? Color(0xFFADD8E6)
                                : Color.fromARGB(255, 235, 234, 229),
                            onTap: () => {
                              setState(() {
                                selectedMode = 'attempt';
                              })
                            },

                            // padding: const EdgeInsets.all(10),
                            // margin: EdgeInsets.symmetric(
                            //     vertical: 30, horizontal: 5),
                            avatar: Image.asset(
                              'assets/images/exam.png',
                              width: 50,
                              height: 50,
                            ),
                            title: Text(
                              '''Attempt''',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 7, 7, 7)
                                      .withOpacity(0.5),
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                            // titleText: 'Attempt',
                            subTitleText: 'Do not show result ',

                            // icon: Icon(Icons.favorite)
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Qprocessing
                            ? CircularProgressIndicator()
                            : ElevatedButton(
                                child: Container(
                                  color: Color.fromARGB(255, 32, 142, 245),
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 70),
                                  child: const Text(
                                    'Start Quiz',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                onPressed: () {
                                  snapshot.data == true
                                      ? loadQuestions()
                                      : Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) => QuizAppFree(
                                                    mode: selectedMode,
                                                    selectedIndex:
                                                        widget.catogoryIndex,
                                                    selectedDifficultyLevel:
                                                        level[widget
                                                            .difficultyIndex],
                                                    subject: cardDetailList[
                                                            widget
                                                                .catogoryIndex]
                                                        .title,
                                                  )));
                                },
                              ),
                        SizedBox(height: 20.0),
                      ],
                    ),
                  ),
                ),
              ));
        });
  }

  void _submit() async {
    setState(() {
      processing = true;
    });

    if (!(isPremiumVersion == true)) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) => QuizAppFree(
                    selectedIndex: widget.catogoryIndex,
                    selectedDifficultyLevel: level[widget.difficultyIndex],
                    subject: cardDetailList[1].title,
                    mode: selectedMode,
                  )));
    } else {
      try {
        if (questions.length < 1) {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => const ErrorPage(
                    message:
                        "There are not enough questions in the category, with the options you selected.",
                  )));
          setState(() {
            processing = false;
          });
          return;
        }
        MCQsQuestionBankApi api = MCQsQuestionBankApi(questions);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => QuizApp(
                      mode: selectedMode,
                      quest: api,
                      selectedIndex: widget.catogoryIndex,
                      selectedDifficultyLevel: level[widget.difficultyIndex],
                      subject: cardDetailList[widget.catogoryIndex].title,
                    )));
      } on SocketException catch (_) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (_) => ErrorPage(
                      message:
                          "Can't reach the servers, \n Please check your internet connection.",
                    )));
        setState(() {
          processing = false;
        });
      } catch (e) {
        print(e.toString());
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (_) => ErrorPage(
                      message: "Unexpected error trying to connect to the API",
                    )));
      }
      setState(() {
        processing = false;
      });
    }
  }

  ///Api calling function
  loadQuestions() async {
    setState(() {
      Qprocessing = true;
    });
    var url =
        "https://fyp-demo.herokuapp.com/api/applicants/getRandomQuestions";
    // var url = "http://localhost:8080/api/applicants/getRandomQuestions"; // iOS
    final http.Response response = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'auth': token
      },
      body: jsonEncode(<String, dynamic>{
        // "bloomsTaxonomyLevel": "learning",
        "bloomsTaxonomyLevel": taxonomyLevel[widget.taxonomyIndex], //,
        "job": widget.jobSelection,
        "difficultyLevel": level[widget.difficultyIndex],
        "subject": cardDetailList[widget.catogoryIndex].category,
        "questionAmount": _selectedValue
      }),
    );
    debugPrint(widget.jobSelection +
        "   " +
        taxonomyLevel[widget.taxonomyIndex] +
        "  " +
        cardDetailList[widget.catogoryIndex].category +
        level[widget.difficultyIndex] +
        "  " +
        _selectedValue.toString());

    if (response != null) {
      debugPrint(response.toString());
      if (response.body.toString() == "Unauthenticated") {
        debugPrint(response.body.toString());
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => LoginScreen()));
        debugPrint("unauthenticated");
        return;
      } else if (response.body.toString() == "[]") {
        debugPrint(response.body.toString());
        Navigator.of(context).push(MaterialPageRoute(
            builder: (_) => const ErrorPage(
                  message:
                      "There are not enough questions in the category, with the options you selected.",
                )));
        setState(() {
          Qprocessing = false;
        });
      } else {
        debugPrint(response.body.toString());
        if (json.decode(response.body).runtimeType.toString() ==
            "List<dynamic>") {
          debugPrint("array of objects " + response.body.toString());
          setState(() {
            questions = getapiQuestioMap(json.decode(response.body));
          });
          debugPrint(questions.toString());
          _submit();
        }
        if (json.decode(response.body).runtimeType.toString() ==
            "object_JsonMap") {
          debugPrint("objects" + response.body.toString());
        }
      }
    } else {
      throw Exception('Failed to create album.');
    }

    setState(() {
      Qprocessing = false;
    });
  }

  getapiQuestioMap(var q) {
    List<Map<String, dynamic>> questionsret =
        List<Map<String, dynamic>>.from(q);
    return Question.fromData(questionsret);
  }
}
