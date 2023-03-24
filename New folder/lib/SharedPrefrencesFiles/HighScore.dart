import 'package:shared_preferences/shared_preferences.dart';

class ScorePrefrence {
  Future<bool> setScore(double token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setDouble("score", token);
  }

  Future<double> getScore() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getDouble("score") ?? 0.0;
    ;
  }

  Future<bool> deleteScore() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.remove("score");
  }
}
