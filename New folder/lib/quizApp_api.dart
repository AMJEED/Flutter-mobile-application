import 'dart:async';

import 'package:flutter/material.dart';
import 'package:trivia_app/SharedPrefrencesFiles/HighScore.dart';
import 'card_details.dart';
import 'mcq-question-databank-api-provider.dart';
import 'score_screen.dart';

const themeColor = Colors.black;
const themeTextColor = Color.fromARGB(255, 236, 156, 7);
String mcqswithcorrectAnswers = "";
String e = "";

class QuizApp extends StatefulWidget {
  final String mode;
  final String subject;
  final int selectedIndex;
  final String selectedDifficultyLevel;
  final MCQsQuestionBankApi quest;

  const QuizApp({
    Key? key,
    required this.mode,
    required this.quest,
    required this.selectedIndex,
    required this.subject,
    required this.selectedDifficultyLevel,
  }) : super(key: key);

  @override
  _QuizAppState createState() => _QuizAppState();
}

class _QuizAppState extends State<QuizApp> {
  int correctCount = 0, incorrectCount = 0, total = 0;
  String result = "";
  bool practicemode = false;

  // MCQsQuestionBank questions = MCQsQuestionBank();

  // MCQsQuestionBankApi questions2 =
  //     MCQsQuestionBankApi(27, 5, 'easy', 'remember');
  List<Expanded> scoreCard = [];

  bool? checkAnswer(String ans) {
    // debugPrint(questions2.getQuestion());
    // debugPrint(questions2.totalnumberofQuestion().toString());
    mcqswithcorrectAnswers +=
        '''Q ${widget.quest.getQuestionNumber()}.  ${widget.quest.getQuestion()} 
Answer : ${widget.quest.getAnswer()}.

''';
    setState(() {
      _progressValue += 1 / widget.quest.totalnumberofQuestion();
      tapedIndex = 0;
      istaped = false;
      selectedAns = "";
    });
    bool isCorrect = false;
    if (widget.quest.getAnswer() == ans) {
      correct();
      isCorrect = true;
    } else {
      inCorrect();
      isCorrect = false;
    }
    total = correctCount + incorrectCount;
    result = "Nice Score, Do you want to try again";

    if (total == widget.quest.totalnumberofQuestion()) {
      e = mcqswithcorrectAnswers;
      mcqswithcorrectAnswers = "";

      updateScore();
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ScoreScreen(
            time: formatedTime(_seconds).toString(),
            mode: widget.mode,
            quest: widget.quest,
            selectedIndex: widget.selectedIndex,
            selectedDifficultyLevel: widget.selectedDifficultyLevel,
            score: correctCount.toString(),
            correctCount: correctCount.toString(),
            incorrectCount: incorrectCount.toString(),
            result: result.toString(),
            mcqswithcorrectAnswer: e,
          ),
        ),
      );
      _stopTimer();
      return isCorrect;
    }

    widget.quest.nextQuestion();
  }

  void correct() {
    setState(
      () {
        correctCount++;
        if (practicemode) {
          scoreCard.add(
            const Expanded(
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Icon(
                  Icons.check_circle,
                  size: 28.0,
                  color: Colors.green,
                ),
              ),
            ),
          );
        }
      },
    );
  }

  void inCorrect() {
    setState(
      () {
        incorrectCount++;
        if (practicemode) {
          scoreCard.add(
            const Expanded(
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Icon(
                  Icons.close,
                  size: 28.0,
                  color: Color.fromARGB(255, 231, 18, 3),
                ),
              ),
            ),
          );
        }
      },
    );
  }

  updateScore() {
    var sc = ScorePrefrence().getScore();
    var percent = (correctCount * 100) / widget.quest.totalnumberofQuestion();
    sc.then((value) => (value < percent)
        ? ScorePrefrence().setScore(percent)
        : ScorePrefrence().getScore());
  }

  late int tapedIndex;
  String selectedAns = "";
  double _progressValue = 0;
  bool istaped = false;
  void initState() {
    _progressValue = 0;
    selectedAns = "";
    istaped = false;
    super.initState();
    tapedIndex = 0;
    _startTimer();
  }

  int _seconds = 0;
  bool _isActive = false;
  late Timer _timer;

  void _startTimer() {
    _isActive = true;
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _seconds++;
      });
    });
  }

  void _stopTimer() {
    _isActive = false;
    _timer.cancel();
  }

  void _resetTimer() {
    setState(() {
      _seconds = 0;
    });
  }

  formatedTime(int timeInSecond) {
    int sec = timeInSecond % 60;
    int min = (timeInSecond / 60).floor();
    String minute = min.toString().length <= 1 ? "0$min" : "$min";
    String second = sec.toString().length <= 1 ? "0$sec" : "$sec";
    return "$minute : $second";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          SizedBox(
            height: 20,
          ),
          Container(
            height: 10,
            child: LinearProgressIndicator(
              value: _progressValue,
              backgroundColor: Colors.grey[300],
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
            ),
          ),
          widget.mode == "attempt"
              ? Container(
                  child: Text("Time " + formatedTime(_seconds).toString(),
                      style: TextStyle(
                          color: Color.fromARGB(255, 243, 58, 2),
                          fontFamily: 'Lobster',
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center),
                )
              : SizedBox(
                  height: 1,
                ),
          // Text(
          //   'Correct : $correctCount',
          //   style: const TextStyle(
          //     fontFamily: 'Lobster',
          //     color: Color.fromARGB(255, 4, 112, 7),
          //     fontSize: 25.0,
          //   ),
          // ),
          // Text(
          //   'Incorrect : $incorrectCount',
          //   style: const TextStyle(
          //     fontFamily: 'Lobster',
          //     color: Color.fromARGB(255, 202, 20, 7),
          //     fontSize: 25.0,
          //   ),
          // ),

          Center(
            child: Text(
              widget.subject,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: cardDetailList[widget.selectedIndex].textColor,
                  fontFamily: 'Lobster',
                  fontSize: 40.0,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Center(
            child: Text(
              "( " +
                  widget.selectedDifficultyLevel[0].toUpperCase() +
                  widget.selectedDifficultyLevel.substring(1).toLowerCase() +
                  " ) ",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: cardDetailList[widget.selectedIndex].textColor,
                  fontFamily: 'Lobster',
                  fontSize: 40.0,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Center(
                child: Text(
                  widget.quest.getQuestionNumber().toString() +
                      ") " +
                      widget.quest.getQuestion().toString(),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      color: Colors.black,
                      fontFamily: 'Lobster',
                      fontSize: 25.0),
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 40.0, vertical: 10.0),
              child: MaterialButton(
                onPressed: () {
                  setState(() {
                    tapedIndex = 0;
                    istaped = true;
                    selectedAns = widget.quest.getOption1();
                  });
                  // checkAnswer(widget.quest.getOption1());
                },
                color: (widget.mode == "attempt" && istaped && tapedIndex == 0)
                    ? cardDetailList[widget.selectedIndex]
                        .textColor
                        .withOpacity(0.5)
                    : ((istaped && widget.mode == "attempt" && tapedIndex != 0)
                        ? cardDetailList[widget.selectedIndex].textColor
                        : (!istaped
                            ? cardDetailList[widget.selectedIndex].textColor
                            : (isCorrect(widget.quest.getOption1())
                                ? Colors.green
                                : Colors.red))),
                child: Text(
                  widget.quest.getOption1(),
                  style: const TextStyle(
                      fontStyle: FontStyle.italic,
                      color: Colors.white,
                      fontSize: 25.0,
                      fontFamily: 'Lobster'),
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 40.0, vertical: 10.0),
              child: MaterialButton(
                onPressed: () {
                  setState(() {
                    tapedIndex = 1;
                    istaped = true;
                    selectedAns = widget.quest.getOption2();
                  });
                  // checkAnswer(widget.quest.getOption2());
                },
                color: (widget.mode == "attempt" && istaped && tapedIndex == 1)
                    ? cardDetailList[widget.selectedIndex]
                        .textColor
                        .withOpacity(0.5)
                    : ((istaped && widget.mode == "attempt" && tapedIndex != 1)
                        ? cardDetailList[widget.selectedIndex].textColor
                        : (!istaped
                            ? cardDetailList[widget.selectedIndex].textColor
                            : (isCorrect(widget.quest.getOption2())
                                ? Colors.green
                                : Colors.red))),
                child: Text(
                  widget.quest.getOption2(),
                  style: const TextStyle(
                      fontStyle: FontStyle.italic,
                      color: Colors.white,
                      fontSize: 25.0,
                      fontFamily: 'Lobster'),
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 40.0, vertical: 10.0),
              child: MaterialButton(
                onPressed: () {
                  tapedIndex = 2;
                  setState(() {
                    istaped = true;
                    selectedAns = widget.quest.getOption3();
                  });
                  // checkAnswer(widget.quest.getOption3());
                },
                color: (widget.mode == "attempt" && istaped && tapedIndex == 2)
                    ? cardDetailList[widget.selectedIndex]
                        .textColor
                        .withOpacity(0.5)
                    : ((istaped && widget.mode == "attempt" && tapedIndex != 2)
                        ? cardDetailList[widget.selectedIndex].textColor
                        : (!istaped
                            ? cardDetailList[widget.selectedIndex].textColor
                            : (isCorrect(widget.quest.getOption3())
                                ? Colors.green
                                : Colors.red))),
                child: Text(
                  widget.quest.getOption3(),
                  style: const TextStyle(
                      fontStyle: FontStyle.italic,
                      color: Colors.white,
                      fontSize: 25.0,
                      fontFamily: 'Lobster'),
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 40.0, vertical: 10.0),
              child: MaterialButton(
                onPressed: () {
                  setState(() {
                    tapedIndex = 3;
                    istaped = true;
                    selectedAns = widget.quest.getOption4();
                  });
                  // checkAnswer(widget.quest.getOption4());
                },
                color: (widget.mode == "attempt" && istaped && tapedIndex == 3)
                    ? cardDetailList[widget.selectedIndex]
                        .textColor
                        .withOpacity(0.5)
                    : ((istaped && widget.mode == "attempt" && tapedIndex != 3)
                        ? cardDetailList[widget.selectedIndex].textColor
                        : (!istaped
                            ? cardDetailList[widget.selectedIndex].textColor
                            : (isCorrect(widget.quest.getOption4())
                                ? Colors.green
                                : Colors.red))),
                child: Text(
                  widget.quest.getOption4(),
                  style: const TextStyle(
                      fontStyle: FontStyle.italic,
                      color: Colors.white,
                      fontSize: 25.0,
                      fontFamily: 'Lobster'),
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 40.0, vertical: 10.0),
              child: MaterialButton(
                onPressed: () {
                  checkAnswer(selectedAns);
                },
                color: Color.fromARGB(255, 32, 142, 245),
                child: Text(
                  "Next ",
                  style: const TextStyle(
                      fontStyle: FontStyle.italic,
                      color: Colors.white,
                      fontSize: 25.0,
                      fontFamily: 'Lobster'),
                ),
              ),
            ),
          ),
          Row(
            children: scoreCard,
          ),
        ],
      ),
    );
  }

  isCorrect(ans) {
    if (widget.quest.getAnswer() == ans) {
      return true;
    } else {
      return false;
    }
  }
}
