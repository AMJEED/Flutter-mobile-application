import 'package:shared_preferences/shared_preferences.dart';

class emailPrefrence {
  Future<bool> setemail(String token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString("email", token);
  }

  Future<String> getemail() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("email") ?? '';
  }

  Future<bool> deleteemail() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.remove("email");
  }
}
