// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trivia_app/JobSeclectionScreen.dart';
import 'package:trivia_app/SharedPrefrencesFiles/VersionSharedPrefs.dart';
import 'package:trivia_app/mcq-question-databank-api-provider.dart';

import 'card_details.dart';
import 'home_screen.dart';
import 'quiz_app.dart';

const themeTextColor = Colors.white;
//const themeTextColor = Color.fromARGB(255, 253, 140, 11);
const themeColor = Color.fromARGB(255, 28, 3, 102);

class ScoreScreen extends StatelessWidget {
  final String timeTaken;
  final String mode;
  final String score;
  final String correctCount;
  final String incorrectCount;
  final String result;
  final int selectedIndex;
  final String selectedDifficultyLevel;
  final String mcqswithcorrectAnswer;

  ScoreScreen({
    Key? key,
    required this.timeTaken,
    required this.mode,
    required this.selectedIndex,
    required this.selectedDifficultyLevel,
    required this.score,
    required this.correctCount,
    required this.incorrectCount,
    required this.result,
    required this.mcqswithcorrectAnswer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: cardDetailList[selectedIndex].textColor,
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  height: 50.0,
                ),
                Center(
                  child: Text(
                    cardDetailList[selectedIndex].title,
                    style: const TextStyle(
                        fontSize: 40,
                        color: themeTextColor,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Center(
                  child: Text(
                    "( " +
                        selectedDifficultyLevel[0].toUpperCase() +
                        selectedDifficultyLevel.substring(1).toLowerCase() +
                        " )",
                    style: const TextStyle(
                        fontSize: 26,
                        color: themeTextColor,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Center(
                  child: Image.asset(
                    "assets/images/score.png",
                    height: 250,
                    width: 250,
                  ),
                ),
                Column(
                  children: [
                    Center(
                      child: Text(
                        " Score : " + score,
                        style: const TextStyle(
                            fontSize: 26,
                            color: themeTextColor,
                            fontFamily: 'Lobster',
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Center(
                      child: Text(
                        "Correct Answers: " + correctCount,
                        style: const TextStyle(
                            fontSize: 20,
                            color: themeTextColor,
                            fontFamily: 'Lobster'),
                      ),
                    ),
                    Center(
                      child: Text(
                        "Incorrect Answers : " + incorrectCount,
                        style: const TextStyle(
                            fontSize: 20,
                            color: themeTextColor,
                            fontFamily: 'Lobster'),
                      ),
                    ),
                    mode == "attempt"
                        ? Center(
                            child: Text(
                              "Time taken: " + timeTaken + "Sec",
                              style: const TextStyle(
                                  fontSize: 20,
                                  color: themeTextColor,
                                  fontFamily: 'Lobster'),
                            ),
                          )
                        : SizedBox(
                            height: 1,
                          ),
                    Center(
                      child: Text(
                        result,
                        style: const TextStyle(
                            fontSize: 20,
                            color: themeTextColor,
                            fontFamily: 'Lobster'),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {
                        showAlertDialog(
                            context,
                            cardDetailList[selectedIndex].title,
                            " ( " +
                                selectedDifficultyLevel[0].toUpperCase() +
                                selectedDifficultyLevel
                                    .substring(1)
                                    .toLowerCase() +
                                " ) ",
                            mcqswithcorrectAnswer);
                      },
                      child: Image.asset('assets/images/Answers.png',
                          height: 120, width: 100),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: ((context) => QuizAppFree(
                                  mode: mode,
                                  selectedIndex: selectedIndex,
                                  subject: cardDetailList[selectedIndex].title,
                                  selectedDifficultyLevel:
                                      selectedDifficultyLevel,
                                )),
                          ),
                        );
                      },
                      child: Image.asset('assets/images/Retry.png',
                          height: 120, width: 100),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: ((context) => JobSelecionScreen()),
                          ),
                        );
                      },
                      child: Image.asset('assets/images/Home.png',
                          height: 120, width: 100),
                    ),
                  ],
                )
              ],
            ),
          ),
        ));
  }
}

// Answers Dialog Box
void showAlertDialog(BuildContext context, String subject, String level,
    String mcqswithcorrectAnswer) {
  AlertDialog alertDialog = AlertDialog(
    title: Text(
      subject + level + " Quiz Answers",
      style: const TextStyle(fontSize: 28.0),
    ),
    content: Container(
      height: 400,
      width: 300,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(mcqswithcorrectAnswer),
          ],
        ),
      ),
    ),
    actions: [
      TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text("OK", style: TextStyle(color: Colors.blue))),
    ],
  );
  showDialog(
      context: context,
      builder: (context) {
        return alertDialog;
      });
}
