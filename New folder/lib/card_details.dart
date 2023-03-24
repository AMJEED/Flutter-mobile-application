import 'package:flutter/material.dart';

class ListDetail {
  ListDetail(
      {required this.title,
      required this.iconAssetName,
      required this.gradients,
      required this.shadowColor,
      required this.iconTag,
      required this.category,
      required this.textColor});
  final String title;
  final String iconAssetName;
  final List<Color> gradients;
  final Color shadowColor;
  final Object iconTag;
  final String category;
  final Color textColor;
}

const double opacity = 0.4;

final List<ListDetail> cardDetailList = [
  ListDetail(
    title: 'English',
    iconAssetName: 'assets/images/english.png',
    gradients: [
      // const Color(0xffd6182e),
      // const Color(0xffed475a),
      const Color(0xff50C2C9),
      Color.fromARGB(255, 77, 203, 210),
    ],
    shadowColor: const Color.fromARGB(255, 77, 203, 210).withOpacity(opacity),
    iconTag: 'english_icon',
    category: 'english',
    textColor: const Color(0xff50C2C9),
  ),
  ListDetail(
    title: 'General Knowledge',
    iconAssetName: 'assets/images/general knowledge.png',
    gradients: [
      const Color(0xff008080),
      Color.fromARGB(157, 2, 121, 121),
    ],
    shadowColor: const Color.fromARGB(157, 2, 121, 121).withOpacity(opacity),
    iconTag: 'gk_icon',
    category: 'GK',
    textColor: const Color(0xff008080),
  ),
  ListDetail(
    title: 'Geography',
    iconAssetName: 'assets/images/geography.png',
    gradients: [
      const Color(0xffFB5031),
      Color.fromARGB(195, 251, 79, 49),
    ],
    shadowColor: const Color.fromARGB(195, 251, 79, 49).withOpacity(opacity),
    iconTag: 'geography_icon',
    category: 'geography',
    textColor: const Color(0xffFB5031),
  ),
  ListDetail(
    title: 'Maths',
    iconAssetName: 'assets/images/mathematics.png',
    gradients: [
      const Color(0xff4F4FFD),
      Color.fromARGB(255, 127, 127, 245),
    ],
    shadowColor: const Color.fromARGB(255, 127, 127, 245).withOpacity(opacity),
    iconTag: 'math_icon',
    category: 'mathematics',
    textColor: const Color(0xff4F4FFD),
  ),
  ListDetail(
    title: 'Science',
    iconAssetName: 'assets/images/science.png',
    gradients: [
      const Color(0xffF8394F),
      const Color(0xffed475a),
    ],
    shadowColor: const Color(0xffed475a).withOpacity(opacity),
    iconTag: 'science_icon',
    category: 'Science',
    textColor: const Color(0xffF8394F),
  ),
  ListDetail(
    title: 'History',
    iconAssetName: 'assets/images/history.png',
    gradients: [
      const Color(0xff089E44),
      Color.fromARGB(177, 8, 158, 68),
    ],
    shadowColor: const Color.fromARGB(177, 8, 158, 68).withOpacity(opacity),
    iconTag: 'history_icon',
    category: 'history',
    textColor: const Color(0xff089E44),
  ),
];
