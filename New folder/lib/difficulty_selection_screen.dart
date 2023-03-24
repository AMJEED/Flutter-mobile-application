import 'package:flutter/material.dart';
import 'package:trivia_app/JobSeclectionScreen.dart';
import 'package:trivia_app/Widget/NavigationDrawerWidget.dart';
import '../Widget/close_button.dart';
import 'card_details.dart';

import 'difficulty_tile.dart';
import 'start_screen.dart';

class DifficultyScreen extends StatelessWidget {
  const DifficultyScreen(
      {required this.catogoryIndex,
      required this.taxonomyIndex,
      required this.selectedJob});

  final catogoryIndex;
  final taxonomyIndex;
  final String selectedJob;

  @override
  Widget build(BuildContext context) {
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
        body: Container(
          padding:
              const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 20),
          decoration: BoxDecoration(color: Colors.white),
          child: Scaffold(
            backgroundColor: Colors.white,
            body: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const [],
                  ),
                  Text(
                    cardDetailList[catogoryIndex].title,
                    style: const TextStyle(
                      color: Color.fromARGB(255, 110, 109, 109),
                      fontWeight: FontWeight.w900,
                      fontSize: 30,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Hero(
                    tag: cardDetailList[catogoryIndex].iconTag,
                    child: Image.asset(
                      cardDetailList[catogoryIndex].iconAssetName,
                      height: 170,
                      width: 170,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Column(
                    children: [
                      const Text(
                        'Select Difficulty Level',
                        style: TextStyle(
                            color: Color.fromARGB(255, 110, 109, 109),
                            fontSize: 24,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 5),
                      // // Text(
                      // //   'Harder the Difficulty, Harder the questions.'
                      //   style: TextStyle(
                      //       color: Colors.white.withOpacity(0.5),
                      //       fontSize: 14,
                      //       fontWeight: FontWeight.bold),
                      // ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      DifficultyTile(
                          jobSelected: selectedJob,
                          catogoryIndex: this.catogoryIndex,
                          taxonomyIndex: this.taxonomyIndex,
                          difficultyIndex: 0),
                      const SizedBox(height: 20),
                      DifficultyTile(
                          jobSelected: selectedJob,
                          catogoryIndex: this.catogoryIndex,
                          taxonomyIndex: this.taxonomyIndex,
                          difficultyIndex: 1),
                      const SizedBox(height: 20),
                      DifficultyTile(
                          jobSelected: selectedJob,
                          catogoryIndex: this.catogoryIndex,
                          taxonomyIndex: this.taxonomyIndex,
                          difficultyIndex: 2),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
