import 'dart:convert';
import 'package:http/http.dart' as http;

import 'question.dart';

const String baseUrl = "https://opentdb.com/api.php";

Future<List<Question>> getQuestions(int category, int? total,
    String? difficulty, String? bloomsTaxonomy) async {
  String url = "$baseUrl?amount=$total&category=${category}";
  if (difficulty != null) {
    url = "$url&difficulty=$difficulty&type=multiple";
  }
  http.Response res = await http.get(Uri.parse(url));
  List<Map<String, dynamic>> questions =
      List<Map<String, dynamic>>.from(json.decode(res.body)["results"]);
  return Question.fromData(questions);
}
