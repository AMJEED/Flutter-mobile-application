import 'package:shared_preferences/shared_preferences.dart';

class loggedInSharedPrefrence {
  Future<bool> setlogin(bool flag) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setBool("isLogedin", flag);
  }

  Future<bool> getlogin() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool("isLogedin") ?? false;
  }

  Future<bool> removelogin() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.remove("isLogedin");
  }
}
