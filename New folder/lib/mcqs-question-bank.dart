import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'dart:io';
import 'api_provider.dart';
import 'mcqs.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

class MCQsQuestionBank {
  int _questionNum = 0;

//..................................................English MCQS......................................................................
// English Easy Questions List

  var obj = [{}, {}, {}, {}, {}, {}, {}, {}, {}];

  final List<MCQsQuestion> English_questionList_easy = [
    //1
    MCQsQuestion('She is working _______ midnight.', 'Since', 'For', 'In', 'On',
        'Since'),
    //2
    MCQsQuestion(
        'In the test, we will _________ your work and then give you detailed feedback.',
        'assess',
        'judge',
        'measure',
        'check',
        'assess'),
    //3
    MCQsQuestion('A bed of roses.', 'Many roses', 'Tricky option',
        'Difficult option', 'Easy Option', 'Easy Option'),

    //4
    MCQsQuestion(
        'It’s difficult ______ reconcile such different points of view',
        'with',
        'to',
        'in',
        'on',
        'to'),

    //5
    MCQsQuestion('...... apple a day keeps the doctor away', 'An', 'A', 'The',
        'No article', 'An'),
  ];

//English Medium Questions List

  final List<MCQsQuestion> English_questionList_medium = [
    //6
    MCQsQuestion('Choose the correct spelling from the following?', 'Etiquite',
        'Etiquette', 'Etikuit', 'None of These', 'Etiquette'),

    //7
    MCQsQuestion('I promise to ________ you in all circumstances',
        'stand up to', 'stand with', 'stand by', 'stand off', 'stand with'),

    //8
    MCQsQuestion('Can you speak ____ Spanish?', 'a', 'an', 'the', 'no article',
        'no article'),

    //9
    MCQsQuestion(
        'A speed limit is the _________ legal speed that you can travel on the road.',
        'highest',
        'biggest',
        'maximum',
        'longest',
        'maximum'),
    //10
    MCQsQuestion('There is something wonderful _______ him.', 'of', 'about',
        'for', 'inside', 'about'),
  ];

//English Hard Questions List

  final List<MCQsQuestion> English_questionList_hard = [
    //11
    MCQsQuestion('Antonym of mendacious is__________?', 'veracious',
        'dishonest', 'release', 'vigor', 'veracious'),

    //12
    MCQsQuestion('To get on the nerves.', 'To soothe', 'To have an illness',
        'To give medicine', 'To irritate', 'To irritate'),

    //13
    MCQsQuestion(
        'The phrase “To have your hands full” expresses means:.',
        'To be a sinner',
        'To have too many things to do',
        'Something related to fighting',
        'To have plenty of wealth',
        'To have too many things to do'),

    //14
    MCQsQuestion('Every now and then implies means:', 'Often', 'Always',
        'Occasionally', 'Every where', 'Occasionally'),

    //15
    MCQsQuestion('Synonym of negligent is _________?', 'careless', 'turn',
        'decide', 'want', 'careless'),
  ];

//..................................................Maths MCQS......................................................................

//Mathematics Easy Questions List

  List<MCQsQuestion> Maths_questionList_easy = [
    //1
    MCQsQuestion('What is the average of the numbers: 0, 0, 4, 10, 5, and 5 ?',
        '2', '3', '4', '5', '4'),
    //2
    MCQsQuestion(
        '0.003 × 0.02 = ?', '0.06', '0.006', '0.0006', '0.00006', '0.00006'),

    //3
    MCQsQuestion('|–4| + |4| – 4 + 4 = ?', '0', '2', '8', '4', '8'),

    //4
    MCQsQuestion('100 + 50 * 2 = ?', '200', '150', '100', '300', '200'),

    //5
    MCQsQuestion(
        'Calculate the Average of 1,2,3,4,5.', '1', '2', '3', '4', '3'),
  ];

//Mathematics Medium Questions List

  List<MCQsQuestion> Maths_questionList_medium = [
    //6
    MCQsQuestion('What is the average of first 150 natural numbers?', '70',
        '70.5', '75', '75.5', '75.5'),

    //7
    MCQsQuestion('What is the value of x in the equation 3x – 15 – 6 = 0 ?',
        '7', '8', '9', '-9', '7'),

    //8
    MCQsQuestion(
        'Today is khadija’s birthday. After one year, she will become two times as she was ten years ago. What is the current age of Khadija?',
        '21',
        '19',
        '20',
        '22',
        '21'),

    //9
    MCQsQuestion(
        'Find two number whose sum is 28 and the difference is 4 _____________?',
        '12,16',
        '18,20',
        '15,13',
        '14,12',
        '12,16'),

    //10
    MCQsQuestion(
        '1 acre is equal to ________square foot?',
        '45434 square foot',
        '34343 square foot',
        '43572 square foot',
        '43560 square foot ',
        '43560 square foot '),
  ];

//Mathematics Hard Questions List

  List<MCQsQuestion> Maths_questionList_hard = [
    //11
    MCQsQuestion(
        'What is the rate of discount if a car which price was \$4,000 was sold for \$3,200 ?',
        '14%',
        '16%',
        '18%',
        '20%',
        '20%'),

    //12
    MCQsQuestion(
        'If 5% more is gained by selling an article for Rs. 350 than by selling it for Rs. 340, the cost of the article is:________?',
        'Rs. 50',
        'Rs. 160',
        'Rs. 200',
        'Rs. 225',
        'Rs. 200'),

    //13
    MCQsQuestion(
        'A and B can finish a work 30 days if they work together. They worked together for 20 days and then B left. A finished the remaining work in another 20 days. In how many days A alone can finish the work?',
        '70',
        '50',
        '40',
        '60',
        '60'),

    //14
    MCQsQuestion('Complete the series: 4,8,9,13,14,18,_______?', '32', '19',
        '11', '27', '19'),

    //15
    MCQsQuestion('Express 1.09 in term of Percentage.', '1.09%', '10.9%',
        '109%', 'None of these', '109%'),
  ];

//..................................................GK MCQS......................................................................

//General Knowledge Easy Questions List

  List<MCQsQuestion> GK_questionList_easy = [
    //1
    MCQsQuestion(
        'Which of the following countries has the largest area in the world?',
        'China',
        'Russia',
        'USA',
        'Canada',
        'Russia'),

    //2
    MCQsQuestion('Which is the largest of all known animals?', 'Elephant',
        'Whale Shark', 'Blue Whale', 'None of these', 'Blue Whale'),

    //3
    MCQsQuestion('Which country is the largest oil producer in the world?',
        'Iran', 'USA', 'India', 'Saudi Arabia', 'Saudi Arabia'),

    //4
    MCQsQuestion('The biggest desert of the world is:', 'Kalahari Desert',
        'Gobi Desert', 'Sahara Desert', 'None of these', 'Sahara Desert'),

    //5
    MCQsQuestion('Which is the fastest animal of the world?', 'Antelope',
        'Cheetah', 'Grey hound', 'None of these', 'Cheetah'),
  ];

//General Knowledge Medium Questions List

  List<MCQsQuestion> GK_questionList_medium = [
    //6
    MCQsQuestion('The largest producer of silk is:', 'Canada', 'Russia',
        'China', 'None of these', 'China'),

    //7
    MCQsQuestion('Which is the largest continent of the world?', 'Asia',
        'America', 'Australia', 'None of these', 'Asia'),

    //8
    MCQsQuestion(' Which is the deepest ocean in the world?', 'Arctic Ocean',
        'Pacific Ocean', 'Atlantic Ocean', 'None of these', 'Pacific Ocean'),

    //9
    MCQsQuestion(
        'In a very low temperature, which of the following water body will freeze at last?',
        'River water',
        'Sea water',
        'Canal water',
        'Water in a lake',
        'Sea water'),

    //10
    MCQsQuestion(
        'Which of the following gas is used in Refrigerator for cooling?',
        'Methane',
        'Ammonia',
        'Nitrogen',
        'None of these',
        'Ammonia'),
  ];

//General Knowledge Hard Questions List

  List<MCQsQuestion> GK_questionList_hard = [
    //11
    MCQsQuestion(
        'Which river in the world carries the maximum volume of water?',
        'Nile',
        'Mississippi',
        'Amazon',
        'None of these',
        'Amazon'),

    //12
    MCQsQuestion('Which is the world’s largest mountain range?', 'Alps',
        'Himalayas', 'Andes', 'None of these', 'Andes'),

    //13
    MCQsQuestion(
        ' The atmosphere of the Earth is divided into different atmospheric layers based on',
        'temperature',
        'pressure',
        'gasses',
        'water vapors',
        'temperature'),

    //14
    MCQsQuestion(
        'Which of the following pairs of metals are supposed to constitute the internal core of the earth?',
        'Nickel & Iron',
        'Iron & Copper',
        'Magnesium & Lead',
        'Chromium& Iron',
        'Nickel & Iron'),

    //15
    MCQsQuestion('Which country ranks top in the mining of gold?',
        'South Africa', 'Canada', 'U.S.A.', 'India', 'South Africa'),
  ];

//..................................................General Science MCQS............................................................

//General Science Easy Questions List
  List<MCQsQuestion> Science_questionList_easy = [
    //1
    MCQsQuestion('Which is the outermost planet in the solar system?',
        'Mercury', 'Pluto', 'Neptune', 'Uranus', 'Neptune'),

    //2
    MCQsQuestion('The Sun is a __________?', 'Star', 'Planet', 'Asteroid',
        'Meteor', 'Star'),

    //3
    MCQsQuestion('Which from the following is NOT a conductor?', 'Aluminium',
        'Gold', 'Graphite', 'All are conductors', 'All are conductors'),

    //4
    MCQsQuestion(
        'When white light is passed through a prism, it splits into __________ colours.',
        '5',
        '6',
        '7',
        '8',
        '7'),

    //5
    MCQsQuestion(
        'At night, Plants intake __________ and release __________?',
        'Oxygen – Carbon dioxide',
        'Carbon dioxide – Oxygen',
        'Oxygen – Carbon monoxide',
        'None of these',
        'Oxygen – Carbon dioxide'),
  ];

//General Science Medium Questions List
  List<MCQsQuestion> Science_questionList_medium = [
    //6
    MCQsQuestion(
        'A device which converts chemical energy into electrical energy is called __________?',
        'Motor',
        'Generator',
        'Moving-Coil meter',
        'Battery',
        'Battery'),

    //7
    MCQsQuestion('A camera uses a __________ to form an image.', 'Convex Lens',
        'Concave Lens', 'Condenser Lens', 'None of these', 'Convex Lens'),

    //8
    MCQsQuestion('Sound waves are _________ waves.', 'Transverse',
        'Electromagnetic', 'Longitudinal', 'None of these', 'Longitudinal'),

    //9
    MCQsQuestion(
        'CNG stands for?',
        'Converted Natural Gas',
        'Conduced Natural Gas',
        'Conducted Natural Gas',
        'Compressed Natural Gas',
        'Compressed Natural Gas'),

    //10
    MCQsQuestion('A man can survive without food for atleast?', '2 months',
        '3 months', '1 months', '4 months', '1 months'),
  ];

//General Science Hard Questions List

  List<MCQsQuestion> Science_questionList_hard = [
    //11
    MCQsQuestion(
        'Long-sight defect could be corrected by using __________ lens?',
        'Concave',
        'Convex',
        'Diverging',
        'None of these',
        'Convex'),

    //12
    MCQsQuestion('Which of the following is a mammal?', 'Duck', 'Crocodile',
        'Platypus', 'Ostrich', 'Platypus'),

    //13
    MCQsQuestion(
        'Second highest layer of Earth’s atmosphere is__________?',
        'Mesosphere',
        'Stratosphere',
        'Troposphere',
        'Thermosphere',
        'Stratosphere'),

    //14
    MCQsQuestion(
        'Transformers are used to change ________ voltage levels.',
        'circuit',
        'direct current',
        'alternating current',
        'none of these',
        'alternating current'),

    //15
    MCQsQuestion(
        'Bromine is a___________________?',
        'red-brown liquid',
        'highly inflammable gas',
        'colourless gas',
        'black solid',
        'red-brown liquid'),
  ];
// English Easy Questions List

  final List<MCQsQuestion> History_questionList_easy = [
    //1
    MCQsQuestion(
        'What was the term for the official policy of racial segregation in South Africa until 1994?',
        'Oversight',
        'Apartheid',
        'Libel',
        'Civility',
        'Apartheid'),
    //2
    MCQsQuestion(
        'Published after her death, what did teenager Anne Frank leave behind?',
        'Novel',
        'Ballad',
        'Poem',
        'Diary',
        'Diary'),
    //3
    MCQsQuestion('In 1912, which famous human made sea vessel sunk?',
        'Hans Hedtoft', 'Le Raymound', 'Titanic', 'Albatross', 'Titanic'),

    //4
    MCQsQuestion(
        'In 1999, Boris Yeltsin resigned as President of Russia, who replaced him?',
        'Dmitry Medvedev',
        'Alexander Rutskoy',
        'Vladimir Putin',
        'Viktor Chernomyrdin',
        'Vladimir Putin'),

    //5
    MCQsQuestion('What is the roman name for the goddess Hecate?', 'Juno',
        'Minerva', 'Trivia', 'Hera', 'Trivia'),
  ];

//History Medium Questions List

  final List<MCQsQuestion> History_questionList_medium = [
    //6
    MCQsQuestion(
        'Who was the first US President to declare war?',
        'Martin Van Buren',
        'James Monroe',
        'James Madison',
        'None of These',
        'James Madison'),

    //7
    MCQsQuestion(
        'In what year did the United States return the Panama Canal to Panama?',
        '1977',
        '1978',
        '1979',
        '1976',
        '1977'),

    //8
    MCQsQuestion(
        'Who won the first American Idol Contest in 2002?',
        'Ruben Studdard',
        'Kelly Clarkson',
        'Fantasia Barrino',
        'Carrie Underwood',
        'Kelly Clarkson'),

    //9
    MCQsQuestion('The attack on Pearl Harbor took place in which month?',
        'September', 'October', 'November', 'December', 'December'),
    //10
    MCQsQuestion(
        'Which F-word is used for the delay of a Senate matter by debate or proceudral motions?',
        'Fence Mending',
        'Fillbuster',
        'Front Burner',
        'Fishing Expedition',
        'Fillbuster'),
  ];

//History Hard Questions List

  final List<MCQsQuestion> History_questionList_hard = [
    //11
    MCQsQuestion('Saint Patrick Day was originally associated with what color?',
        'Scarlet', 'Yellow', 'Pink', 'Blue', 'Blue'),

    //12
    MCQsQuestion(
        'John Wilkes Booth assassinated which US President?',
        'Ronald Reagan',
        'Gerald Ford',
        'Abraham Lincoln',
        'Lyndon B. Johnson',
        'Abraham Lincoln'),

    //13
    MCQsQuestion(
        'What kind of animal did Bill Clinton had in office?',
        'A pigeon named Ron',
        'A cat named Socks',
        'A dog named Harrier',
        'A deer named Savanah',
        'A cat named Socks'),

    //14
    MCQsQuestion('When did the Cold War officially end?', '1986', '1987',
        '1988', '1989', '1989'),

    //15
    MCQsQuestion(
        'Who assassinated Robert Kennedy in Los Angeles, California in 1968?',
        'James Earl Ray',
        'Lee Harvey Oswald',
        'Sirhan Sirhan',
        'Gavrilo Princip',
        'Sirhan Sirhan'),
  ];
  // End Question
// English Easy Questions List

  final List<MCQsQuestion> Geography_questionList_easy = [
    //1
    MCQsQuestion('What is the largest Desert?', 'Gobi', 'Antarctic', 'Kalahari',
        'None of these', 'Antarctic'),
    //2
    MCQsQuestion('Which is world smallest ocean?', 'Arctic', 'Pacific',
        'Indian', 'None of these', 'Arctic'),
    //3
    MCQsQuestion('The smallest bridge is situated in', 'Ghana', 'Bermuda',
        'china', 'Beerage', 'Bermuda'),

    //4
    MCQsQuestion('Which is the deepest ocean?', 'Pacific', 'Atlantic', 'Indian',
        'None of these', 'Pacific'),
    //5
    MCQsQuestion('Which is the smallest desert in the world?', 'Kalahari',
        'Carcross', 'Sahara', 'None of these', 'Carcross'),
  ];

//History Medium Questions List

  final List<MCQsQuestion> Geography_questionList_medium = [
    //6
    MCQsQuestion('Which river run by most countries?', 'Molonglo', 'Tirane',
        'Danube', 'None of These', 'Danube'),

    //7
    MCQsQuestion('Which country is named after Jesus?', 'El Salvador', 'Haiti',
        'Israel', 'None of these', 'El Salvador'),

    //8
    MCQsQuestion('What is the capital of Kosovo?', 'Victoria', 'Pristina',
        'Lome', 'None of these', 'Pristina'),

    //9
    MCQsQuestion('What is the capital of Iceland?', 'Dhaka', 'Lima',
        'Reykjavik', 'None of these', 'Reykjavik'),
    //10
    MCQsQuestion('What is the deepest river in the world?', 'Congo', 'Danube',
        'Nile', 'Tirane', 'Congo'),
  ];

//History Hard Questions List

  final List<MCQsQuestion> Geography_questionList_hard = [
    //11
    MCQsQuestion('Roughly how many countries are there in Asia?', '45', '50',
        '30', '60', '50'),

    //12
    MCQsQuestion('Which is the highest volcano in the world?', 'Victoria',
        'Angel', 'Niagara', 'None of these', 'Angel'),

    //13
    MCQsQuestion(' Which country has the longest coastline?', 'Australia',
        'Canada', 'China', 'None of these', 'Canada'),

    //14
    MCQsQuestion(
        'Eclipse is related to', 'Moon', 'Ocean', 'Mountain', 'Earth', 'Moon'),

    //15
    MCQsQuestion('What is a glacier made of?', 'Fallen snow', 'Rock', 'Lava',
        'Salt', 'Fallen snow'),
  ];
  // End Question

  int getQuestionNumber() {
    return _questionNum + 1;
  }

  void nextQuestion(String subject, String level) {
    if (subject == "English") {
      if (level == "easy") {
        if (_questionNum < English_questionList_easy.length - 1) {
          _questionNum++;
        }
      } else if (level == "medium") {
        if (_questionNum < English_questionList_medium.length - 1) {
          _questionNum++;
        }
      } else if (level == "hard") {
        if (_questionNum < English_questionList_hard.length - 1) {
          _questionNum++;
        }
      }
    } else if (subject == "Maths") {
      if (level == "easy") {
        if (_questionNum < Maths_questionList_easy.length - 1) {
          _questionNum++;
        }
      } else if (level == "medium") {
        if (_questionNum < Maths_questionList_medium.length - 1) {
          _questionNum++;
        }
      } else if (level == "hard") {
        if (_questionNum < Maths_questionList_hard.length - 1) {
          _questionNum++;
        }
      }
    } else if (subject == "Science") {
      if (level == "easy") {
        if (_questionNum < Science_questionList_easy.length - 1) {
          _questionNum++;
        }
      } else if (level == "medium") {
        if (_questionNum < Science_questionList_medium.length - 1) {
          _questionNum++;
        }
      } else if (level == "hard") {
        if (_questionNum < Science_questionList_hard.length - 1) {
          _questionNum++;
        }
      }
    } else if (subject == "General Knowledge") {
      if (level == "easy") {
        if (_questionNum < GK_questionList_easy.length - 1) {
          _questionNum++;
        }
      } else if (level == "medium") {
        if (_questionNum < GK_questionList_medium.length - 1) {
          _questionNum++;
        }
      } else if (level == "hard") {
        if (_questionNum < GK_questionList_hard.length - 1) {
          _questionNum++;
        }
      }
    } else if (subject == "History") {
      if (level == "easy") {
        if (_questionNum < History_questionList_easy.length - 1) {
          _questionNum++;
        }
      } else if (level == "medium") {
        if (_questionNum < History_questionList_medium.length - 1) {
          _questionNum++;
        }
      } else if (level == "hard") {
        if (_questionNum < History_questionList_hard.length - 1) {
          _questionNum++;
        }
      }
    } else if (subject == "Geography") {
      if (level == "easy") {
        if (_questionNum < Geography_questionList_easy.length - 1) {
          _questionNum++;
        }
      } else if (level == "medium") {
        if (_questionNum < Geography_questionList_medium.length - 1) {
          _questionNum++;
        }
      } else if (level == "hard") {
        if (_questionNum < Geography_questionList_hard.length - 1) {
          _questionNum++;
        }
      }
    } else {}
  }

  int totalnumberofQuestion(String subject, String level) {
    if (subject == "English") {
      if (level == "easy") {
        return English_questionList_easy.length;
      } else if (level == "medium") {
        return English_questionList_medium.length;
      } else if (level == "hard") {
        return English_questionList_hard.length;
      } else {
        return 0;
      }
    } else if (subject == "Maths") {
      if (level == "easy") {
        return Maths_questionList_easy.length;
      } else if (level == "medium") {
        return Maths_questionList_medium.length;
      } else if (level == "hard") {
        return Maths_questionList_hard.length;
      } else {
        return 0;
      }
    } else if (subject == "Science") {
      if (level == "easy") {
        return Science_questionList_easy.length;
      } else if (level == "medium") {
        return Science_questionList_medium.length;
      } else if (level == "hard") {
        return Science_questionList_hard.length;
      } else {
        return 0;
      }
    } else if (subject == "General Knowledge") {
      if (level == "easy") {
        return GK_questionList_easy.length;
      } else if (level == "medium") {
        return GK_questionList_medium.length;
      } else if (level == "hard") {
        return GK_questionList_hard.length;
      } else {
        return 0;
      }
    } else if (subject == "History") {
      if (level == "easy") {
        return History_questionList_easy.length;
      } else if (level == "medium") {
        return History_questionList_medium.length;
      } else if (level == "hard") {
        return History_questionList_hard.length;
      } else {
        return 0;
      }
    } else if (subject == "Geography") {
      if (level == "easy") {
        return Geography_questionList_easy.length;
      } else if (level == "medium") {
        return Geography_questionList_medium.length;
      } else if (level == "hard") {
        return Geography_questionList_hard.length;
      } else {
        return 0;
      }
    } else {
      return 0;
    }
  }

  String getQuestion(String subject, String level) {
    if (subject == "English") {
      if (level == "easy") {
        return English_questionList_easy[_questionNum].questionText;
      } else if (level == "medium") {
        return English_questionList_medium[_questionNum].questionText;
      } else if (level == "hard") {
        return English_questionList_hard[_questionNum].questionText;
      } else {
        return "Level not found";
      }
    } else if (subject == "Maths") {
      if (level == "easy") {
        return Maths_questionList_easy[_questionNum].questionText;
      } else if (level == "medium") {
        return Maths_questionList_medium[_questionNum].questionText;
      } else if (level == "hard") {
        return Maths_questionList_hard[_questionNum].questionText;
      } else {
        return "Level not found";
      }
    } else if (subject == "Science") {
      if (level == "easy") {
        return Science_questionList_easy[_questionNum].questionText;
      } else if (level == "medium") {
        return Science_questionList_medium[_questionNum].questionText;
      } else if (level == "hard") {
        return Science_questionList_hard[_questionNum].questionText;
      } else {
        return "Level not found";
      }
    } else if (subject == "General Knowledge") {
      if (level == "easy") {
        return GK_questionList_easy[_questionNum].questionText;
      } else if (level == "medium") {
        return GK_questionList_medium[_questionNum].questionText;
      } else if (level == "hard") {
        return GK_questionList_hard[_questionNum].questionText;
      } else {
        return "Level not found";
      }
    } else if (subject == "History") {
      if (level == "easy") {
        return History_questionList_easy[_questionNum].questionText;
      } else if (level == "medium") {
        return History_questionList_medium[_questionNum].questionText;
      } else if (level == "hard") {
        return History_questionList_hard[_questionNum].questionText;
      } else {
        return "Level not found";
      }
    } else if (subject == "Geography") {
      if (level == "easy") {
        return Geography_questionList_easy[_questionNum].questionText;
      } else if (level == "medium") {
        return Geography_questionList_medium[_questionNum].questionText;
      } else if (level == "hard") {
        return Geography_questionList_hard[_questionNum].questionText;
      } else {
        return "Level not found";
      }
    } else {
      return "Subject not found";
    }
  }

  String getOption1(String subject, String level) {
    if (subject == "English") {
      if (level == "easy") {
        return English_questionList_easy[_questionNum].option1;
      } else if (level == "medium") {
        return English_questionList_medium[_questionNum].option1;
      } else if (level == "hard") {
        return English_questionList_hard[_questionNum].option1;
      } else {
        return "Level not found";
      }
    } else if (subject == "Maths") {
      if (level == "easy") {
        return Maths_questionList_easy[_questionNum].option1;
      } else if (level == "medium") {
        return Maths_questionList_medium[_questionNum].option1;
      } else if (level == "hard") {
        return Maths_questionList_hard[_questionNum].option1;
      } else {
        return "Level not found";
      }
    } else if (subject == "Science") {
      if (level == "easy") {
        return Science_questionList_easy[_questionNum].option1;
      } else if (level == "medium") {
        return Science_questionList_medium[_questionNum].option1;
      } else if (level == "hard") {
        return Science_questionList_hard[_questionNum].option1;
      } else {
        return "Level not found";
      }
    } else if (subject == "General Knowledge") {
      if (level == "easy") {
        return GK_questionList_easy[_questionNum].option1;
      } else if (level == "medium") {
        return GK_questionList_medium[_questionNum].option1;
      } else if (level == "hard") {
        return GK_questionList_hard[_questionNum].option1;
      } else {
        return "Level not found";
      }
    } else if (subject == "History") {
      if (level == "easy") {
        return History_questionList_easy[_questionNum].option1;
      } else if (level == "medium") {
        return History_questionList_medium[_questionNum].option1;
      } else if (level == "hard") {
        return History_questionList_hard[_questionNum].option1;
      } else {
        return "Level not found";
      }
    } else if (subject == "Geography") {
      if (level == "easy") {
        return Geography_questionList_easy[_questionNum].option1;
      } else if (level == "medium") {
        return Geography_questionList_medium[_questionNum].option1;
      } else if (level == "hard") {
        return Geography_questionList_hard[_questionNum].option1;
      } else {
        return "Level not found";
      }
    } else {
      return "Subject not found";
    }
  }

  String getOption2(String subject, String level) {
    if (subject == "English") {
      if (level == "easy") {
        return English_questionList_easy[_questionNum].option2;
      } else if (level == "medium") {
        return English_questionList_medium[_questionNum].option2;
      } else if (level == "hard") {
        return English_questionList_hard[_questionNum].option2;
      } else {
        return "Level not found";
      }
    } else if (subject == "Maths") {
      if (level == "easy") {
        return Maths_questionList_easy[_questionNum].option2;
      } else if (level == "medium") {
        return Maths_questionList_medium[_questionNum].option2;
      } else if (level == "hard") {
        return Maths_questionList_hard[_questionNum].option2;
      } else {
        return "Level not found";
      }
    } else if (subject == "Science") {
      if (level == "easy") {
        return Science_questionList_easy[_questionNum].option2;
      } else if (level == "medium") {
        return Science_questionList_medium[_questionNum].option2;
      } else if (level == "hard") {
        return Science_questionList_hard[_questionNum].option2;
      } else {
        return "Level not found";
      }
    } else if (subject == "General Knowledge") {
      if (level == "easy") {
        return GK_questionList_easy[_questionNum].option2;
      } else if (level == "medium") {
        return GK_questionList_medium[_questionNum].option2;
      } else if (level == "hard") {
        return GK_questionList_hard[_questionNum].option2;
      } else {
        return "Level not found";
      }
    } else if (subject == "History") {
      if (level == "easy") {
        return History_questionList_easy[_questionNum].option2;
      } else if (level == "medium") {
        return History_questionList_medium[_questionNum].option2;
      } else if (level == "hard") {
        return History_questionList_hard[_questionNum].option2;
      } else {
        return "Level not found";
      }
    } else if (subject == "Geography") {
      if (level == "easy") {
        return Geography_questionList_easy[_questionNum].option2;
      } else if (level == "medium") {
        return Geography_questionList_medium[_questionNum].option2;
      } else if (level == "hard") {
        return Geography_questionList_hard[_questionNum].option2;
      } else {
        return "Level not found";
      }
    } else {
      return "Subject not found";
    }
  }

  String getOption3(String subject, String level) {
    if (subject == "English") {
      if (level == "easy") {
        return English_questionList_easy[_questionNum].option3;
      } else if (level == "medium") {
        return English_questionList_medium[_questionNum].option3;
      } else if (level == "hard") {
        return English_questionList_hard[_questionNum].option3;
      } else {
        return "Level not found";
      }
    } else if (subject == "Maths") {
      if (level == "easy") {
        return Maths_questionList_easy[_questionNum].option3;
      } else if (level == "medium") {
        return Maths_questionList_medium[_questionNum].option3;
      } else if (level == "hard") {
        return Maths_questionList_hard[_questionNum].option3;
      } else {
        return "Level not found";
      }
    } else if (subject == "Science") {
      if (level == "easy") {
        return Science_questionList_easy[_questionNum].option3;
      } else if (level == "medium") {
        return Science_questionList_medium[_questionNum].option3;
      } else if (level == "hard") {
        return Science_questionList_hard[_questionNum].option3;
      } else {
        return "Level not found";
      }
    } else if (subject == "General Knowledge") {
      if (level == "easy") {
        return GK_questionList_easy[_questionNum].option3;
      } else if (level == "medium") {
        return GK_questionList_medium[_questionNum].option3;
      } else if (level == "hard") {
        return GK_questionList_hard[_questionNum].option3;
      } else {
        return "Level not found";
      }
    } else if (subject == "History") {
      if (level == "easy") {
        return History_questionList_easy[_questionNum].option3;
      } else if (level == "medium") {
        return History_questionList_medium[_questionNum].option3;
      } else if (level == "hard") {
        return History_questionList_hard[_questionNum].option3;
      } else {
        return "Level not found";
      }
    } else if (subject == "Geography") {
      if (level == "easy") {
        return Geography_questionList_easy[_questionNum].option3;
      } else if (level == "medium") {
        return Geography_questionList_medium[_questionNum].option3;
      } else if (level == "hard") {
        return Geography_questionList_hard[_questionNum].option3;
      } else {
        return "Level not found";
      }
    } else {
      return "Subject not found";
    }
  }

  String getOption4(String subject, String level) {
    if (subject == "English") {
      if (level == "easy") {
        return English_questionList_easy[_questionNum].option4;
      } else if (level == "medium") {
        return English_questionList_medium[_questionNum].option4;
      } else if (level == "hard") {
        return English_questionList_hard[_questionNum].option4;
      } else {
        return "Level not found";
      }
    } else if (subject == "Maths") {
      if (level == "easy") {
        return Maths_questionList_easy[_questionNum].option4;
      } else if (level == "medium") {
        return Maths_questionList_medium[_questionNum].option4;
      } else if (level == "hard") {
        return Maths_questionList_hard[_questionNum].option4;
      } else {
        return "Level not found";
      }
    } else if (subject == "Science") {
      if (level == "easy") {
        return Science_questionList_easy[_questionNum].option4;
      } else if (level == "medium") {
        return Science_questionList_medium[_questionNum].option4;
      } else if (level == "hard") {
        return Science_questionList_hard[_questionNum].option4;
      } else {
        return "Level not found";
      }
    } else if (subject == "General Knowledge") {
      if (level == "easy") {
        return GK_questionList_easy[_questionNum].option4;
      } else if (level == "medium") {
        return GK_questionList_medium[_questionNum].option4;
      } else if (level == "hard") {
        return GK_questionList_hard[_questionNum].option4;
      } else {
        return "Level not found";
      }
    } else if (subject == "History") {
      if (level == "easy") {
        return History_questionList_easy[_questionNum].option4;
      } else if (level == "medium") {
        return History_questionList_medium[_questionNum].option4;
      } else if (level == "hard") {
        return History_questionList_hard[_questionNum].option4;
      } else {
        return "Level not found";
      }
    } else if (subject == "Geography") {
      if (level == "easy") {
        return Geography_questionList_easy[_questionNum].option4;
      } else if (level == "medium") {
        return Geography_questionList_medium[_questionNum].option4;
      } else if (level == "hard") {
        return Geography_questionList_hard[_questionNum].option4;
      } else {
        return "Level not found";
      }
    } else {
      return "Subject not found";
    }
  }

  String getAnswer(String subject, String level) {
    if (subject == "English") {
      if (level == "easy") {
        return English_questionList_easy[_questionNum].correctAnswer;
      } else if (level == "medium") {
        return English_questionList_medium[_questionNum].correctAnswer;
      } else if (level == "hard") {
        return English_questionList_hard[_questionNum].correctAnswer;
      } else {
        return "Level not found";
      }
    } else if (subject == "Maths") {
      if (level == "easy") {
        return Maths_questionList_easy[_questionNum].correctAnswer;
      } else if (level == "medium") {
        return Maths_questionList_medium[_questionNum].correctAnswer;
      } else if (level == "hard") {
        return Maths_questionList_hard[_questionNum].correctAnswer;
      } else {
        return "Level not found";
      }
    } else if (subject == "Science") {
      if (level == "easy") {
        return Science_questionList_easy[_questionNum].correctAnswer;
      } else if (level == "medium") {
        return Science_questionList_medium[_questionNum].correctAnswer;
      } else if (level == "hard") {
        return Science_questionList_hard[_questionNum].correctAnswer;
      } else {
        return "Level not found";
      }
    } else if (subject == "General Knowledge") {
      if (level == "easy") {
        return GK_questionList_easy[_questionNum].correctAnswer;
      } else if (level == "medium") {
        return GK_questionList_medium[_questionNum].correctAnswer;
      } else if (level == "hard") {
        return GK_questionList_hard[_questionNum].correctAnswer;
      } else {
        return "Level not found";
      }
    } else if (subject == "History") {
      if (level == "easy") {
        return History_questionList_easy[_questionNum].correctAnswer;
      } else if (level == "medium") {
        return History_questionList_medium[_questionNum].correctAnswer;
      } else if (level == "hard") {
        return History_questionList_hard[_questionNum].correctAnswer;
      } else {
        return "Level not found";
      }
    } else if (subject == "Geography") {
      if (level == "easy") {
        return Geography_questionList_easy[_questionNum].correctAnswer;
      } else if (level == "medium") {
        return Geography_questionList_medium[_questionNum].correctAnswer;
      } else if (level == "hard") {
        return Geography_questionList_hard[_questionNum].correctAnswer;
      } else {
        return "Level not found";
      }
    } else {
      return "Subject not found";
    }
  }
}
