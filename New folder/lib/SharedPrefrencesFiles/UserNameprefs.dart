import 'package:shared_preferences/shared_preferences.dart';

class userNamePrefrence {
  Future<bool> setName(String token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString("name", token);
  }

  Future<String> getName() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("name") ?? '';
  }

  Future<bool> deleteName() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.remove("name");
  }
}
