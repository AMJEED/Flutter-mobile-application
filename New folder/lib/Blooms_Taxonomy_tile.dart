import 'package:flutter/material.dart';

import 'card_details.dart';
import 'difficulty_selection_screen.dart';

class TaxonomyTile extends StatelessWidget {
  TaxonomyTile(
      {Key? key,
      required this.catogoryIndex,
      required this.taxonomyIndex,
      required this.jobselected})
      : super(key: key);

  final int catogoryIndex;
  final int taxonomyIndex;
  final String jobselected;

  final List<String> level = [
    'Remember',
    'Understand',
    'Apply',
    'Analyze',
    'Evaluate',
    'Create'
  ];
  final List<String> levelLowercase = [
    'Remember',
    'Understand',
    'Apply',
    'Analyze',
    'Evaluate',
    'Create'
  ];

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              //English , Maths , Science , General Knowledge
              builder: ((context) => DifficultyScreen(
                    selectedJob: jobselected,
                    catogoryIndex: this.catogoryIndex,
                    taxonomyIndex: this.taxonomyIndex,
                  )),
            ));
      },
      child: Container(
        height: 45,
        width: MediaQuery.of(context).size.width,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: cardDetailList[taxonomyIndex].textColor,
          borderRadius: BorderRadius.circular(50),
          boxShadow: [
            BoxShadow(
              offset: const Offset(3, 3),
              blurRadius: 3,
              color: Colors.white.withOpacity(0.3),
            ),
          ],
          // border: Border.all(
          //   color: Colors.white,
          // ),
        ),
        child: Text(
          level[taxonomyIndex],
          style: const TextStyle(
            color: Color.fromARGB(255, 248, 246, 246),
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
