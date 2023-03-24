import 'package:flutter/material.dart';
import 'package:trivia_app/start_screen.dart';

import 'Widget/NavigationDrawerWidget.dart';
import 'card_details.dart';
import 'list_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key, required this.selectedjob}) : super(key: key);
  final String selectedjob;

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
                  builder: ((context) => StartScreen()),
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
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: Container(
          margin:
              const EdgeInsets.only(top: 40, left: 20, right: 20, bottom: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              const Text(
                'Subjects',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                '''Hey, What subject do you want to improve today?''',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              ListView.builder(
                itemCount: cardDetailList.length - 3,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return ListCard(index, selectedjob);
                },
              ),
              // ListView.builder(
              //   itemCount: cardDetailList2.length,
              //   physics: const NeverScrollableScrollPhysics(),
              //   shrinkWrap: true,
              //   itemBuilder: (context, index) {
              //     return ListCard(index);
              //   },
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
