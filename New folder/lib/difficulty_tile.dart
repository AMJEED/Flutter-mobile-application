import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:trivia_app/QuestionAmountSelection.dart';

import 'card_details.dart';
import 'quiz_app.dart';

class DifficultyTile extends StatelessWidget {
  DifficultyTile(
      {Key? key,
      required this.catogoryIndex,
      required this.difficultyIndex,
      required this.taxonomyIndex,
      required this.jobSelected})
      : super(key: key);

  final int catogoryIndex;
  final int difficultyIndex;
  final int taxonomyIndex;
  final String jobSelected;

  final List<String> level = ['Easy', 'Medium', 'Hard'];
  final List<String> levelLowercase = ['easy', 'medium', 'hard'];

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: ((context) => QuestionSelecionScreen(
                  jobSelection: jobSelected,
                  catogoryIndex: catogoryIndex,
                  difficultyIndex: difficultyIndex,
                  taxonomyIndex: taxonomyIndex)),
            ));
      },
      child: Container(
        height: 50,
        width: MediaQuery.of(context).size.width,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: cardDetailList[difficultyIndex].textColor,
          borderRadius: BorderRadius.circular(50),
          boxShadow: [
            BoxShadow(
              offset: const Offset(3, 3),
              blurRadius: 3,
              color: Colors.white.withOpacity(0.3),
            ),
          ],
          border: Border.all(
            color: Colors.white,
          ),
        ),
        child: Text(
          level[difficultyIndex],
          style: const TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
