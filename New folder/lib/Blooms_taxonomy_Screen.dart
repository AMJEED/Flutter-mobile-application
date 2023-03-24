import 'package:flutter/material.dart';
import 'package:trivia_app/JobSeclectionScreen.dart';
import 'package:trivia_app/start_screen.dart';

import '../Widget/NavigationDrawerWidget.dart';
import '../Widget/close_button.dart';
import 'Blooms_Taxonomy_tile.dart';
import 'card_details.dart';

import 'difficulty_tile.dart';

class TaxonomyScreen extends StatelessWidget {
  const TaxonomyScreen(
      {required this.catogoryIndex, required this.selectedJob});
  final int catogoryIndex;
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
                    Text(
                      cardDetailList[catogoryIndex].title,
                      style: const TextStyle(
                        color: Color.fromARGB(255, 110, 109, 109),
                        fontWeight: FontWeight.w900,
                        fontSize: 30,
                      ),
                    ),
                    Hero(
                      tag: cardDetailList[catogoryIndex].iconTag,
                      child: Image.asset(
                        cardDetailList[catogoryIndex].iconAssetName,
                        height: 170,
                        width: 170,
                      ),
                    ),
                    Column(
                      children: [
                        const Text(
                          "Select Bloom's Taxonomy  Level",
                          style: TextStyle(
                              color: Color.fromARGB(255, 110, 109, 109),
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 5),
                        // Text(
                        //   "Highr the Bloom's Taxonomy level, Harder the questions.",
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
                        TaxonomyTile(
                            jobselected: selectedJob,
                            catogoryIndex: this.catogoryIndex,
                            taxonomyIndex: 0),
                        const SizedBox(height: 20),
                        TaxonomyTile(
                            jobselected: selectedJob,
                            catogoryIndex: this.catogoryIndex,
                            taxonomyIndex: 1),
                        const SizedBox(height: 20),
                        TaxonomyTile(
                            jobselected: selectedJob,
                            catogoryIndex: this.catogoryIndex,
                            taxonomyIndex: 2),
                        const SizedBox(height: 20),
                        TaxonomyTile(
                            jobselected: selectedJob,
                            catogoryIndex: this.catogoryIndex,
                            taxonomyIndex: 3),
                        const SizedBox(height: 20),
                        TaxonomyTile(
                            jobselected: selectedJob,
                            catogoryIndex: this.catogoryIndex,
                            taxonomyIndex: 4),
                        const SizedBox(height: 20),
                        TaxonomyTile(
                            jobselected: selectedJob,
                            catogoryIndex: this.catogoryIndex,
                            taxonomyIndex: 5),
                      ],
                    ),
                  ],
                ),
              ),
            )));
  }
}
