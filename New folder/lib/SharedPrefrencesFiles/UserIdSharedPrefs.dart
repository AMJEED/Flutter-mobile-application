import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefrence2 {
  Future<bool> setId(String uid) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString("id", uid);
  }

  Future<String> getId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("id") ?? '';
  }

  Future<bool> removeId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.remove("id");
  }
}
