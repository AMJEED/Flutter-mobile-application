import 'package:flutter/material.dart';

import 'Blooms_taxonomy_Screen.dart';
import 'card_details.dart';

class ListCard extends StatelessWidget {
  const ListCard(this.index, this.Selcetdjob);
  final int index;
  final String Selcetdjob;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 240,
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => TaxonomyScreen(
                            catogoryIndex: index,
                            selectedJob: Selcetdjob,
                          )),
                );
              },
              child: Stack(
                alignment: AlignmentDirectional.center,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 50),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 20),
                    height: 200,
                    width: 150,
                    //width: MediaQuery.of(context).size.width,S
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: cardDetailList[index].gradients,
                      ),
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          offset: const Offset(1, 3),
                          blurRadius: 7,
                          spreadRadius: 5,
                          color: cardDetailList[index].shadowColor,
                        )
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          cardDetailList[index].title,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Hero(
                    tag: cardDetailList[index].iconTag,
                    child: Image.asset(
                      cardDetailList[index].iconAssetName,
                      scale: 4,
                    ),
                  ),
                ],
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => TaxonomyScreen(
                            catogoryIndex: index + 3,
                            selectedJob: Selcetdjob,
                          )),
                );
              },
              child: Stack(
                alignment: AlignmentDirectional.center,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 50),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 20),
                    height: 200,
                    width: 150,
                    //width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: cardDetailList[index + 3].gradients,
                      ),
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          offset: const Offset(1, 3),
                          blurRadius: 7,
                          spreadRadius: 5,
                          color: cardDetailList[index + 3].shadowColor,
                        )
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          cardDetailList[index + 3].title,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Hero(
                    tag: cardDetailList[index + 3].iconTag,
                    child: Image.asset(
                      cardDetailList[index + 3].iconAssetName,
                      scale: 4,
                    ),
                  ),
                ],
              ),
            )
          ]),
    );
  }
}
