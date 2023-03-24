import 'package:shared_preferences/shared_preferences.dart';

class VersionSharedPrefrence {
  Future<bool> setVersion(bool ver) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setBool("version", ver);
  }

  Future<bool> getVersion() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.reload();

    return prefs.getBool("version") ?? false;
  }

  Future<bool> removeVersion() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.remove("version");
  }
}
