import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'dart:io';

import 'package:meta/meta.dart';

import 'api_provider.dart';
import 'question.dart';

class MCQsQuestionBankApi {
  int _questionNum = 0;

  List<Question> questions = [];
  MCQsQuestionBankApi(List<Question> q) {
    questions = q;
    // getquestion();
  }
  // void getquestion() async {
  //   // questions = await getQuestions(27, 10, "easy", "remember");
  //   debugPrint("Here we have questions" + questions[0].question.toString());
  //   debugPrint("Here we have op1${questions[0].incorrectAnswers![0]}");
  //   debugPrint("Here we have op2${questions[0].incorrectAnswers![1]}");
  //   debugPrint("Here we have op3${questions[0].incorrectAnswers![2]}");
  //   debugPrint("Here we have op3${questions.length}");
  //   ;
  // }
  resetQuestionNumber() {
    _questionNum = 0;
  }

  int getQuestionNumber() {
    return _questionNum + 1;
  }

  void nextQuestion() {
    _questionNum += 1;
  }

  int totalnumberofQuestion() {
    var numq = questions.length;

    return numq;
  }

  String? getQuestion() {
    var qtext = questions[_questionNum].question.toString();
    return qtext;
  }

  String getOption1() {
    var op1 = questions[_questionNum].option1;
    return op1;
  }

  String getOption2() {
    var op2 = questions[_questionNum].option2;
    return op2;
  }

  String getOption3() {
    var op3 = questions[_questionNum].option3;
    return op3;
  }

  String getOption4() {
    var op4 = questions[_questionNum].option4;
    return op4;
  }

  String getAnswer() {
    var ans = questions[_questionNum].correctAnswer;
    if (ans == "A") {
      return questions[_questionNum].option1;
    }
    if (ans == "B") {
      return questions[_questionNum].option2;
    }
    if (ans == "C") {
      return questions[_questionNum].option3;
    }
    if (ans == "D") {
      return questions[_questionNum].option4;
    }
    return " ";
  }
}
