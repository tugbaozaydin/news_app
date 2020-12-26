import 'package:shared_preferences/shared_preferences.dart';


class Preferences {
  SharedPreferences prefs;

  Future<bool> setEmail(String value) async {
    prefs = await SharedPreferences.getInstance();
    Future<bool> pref = prefs.setString("email", value);
    return pref;
  }

  Future<String> getEmail() async {
    prefs = await SharedPreferences.getInstance();
    String pref = prefs.getString("email") ?? "";

    return pref;
  }
  Future<bool> setNews(String value) async {
    prefs = await SharedPreferences.getInstance();
    Future<bool> pref = prefs.setString("news", value);
    return pref;
  }

  Future<String> getNews() async {
    prefs = await SharedPreferences.getInstance();
    String pref = prefs.getString("news") ?? "";

    return pref;
  }
  Future<bool> setNewsLink(String value) async {
    prefs = await SharedPreferences.getInstance();
    Future<bool> pref = prefs.setString("newsLink", value);
    return pref;
  }

  Future<String> getNewsLink() async {
    prefs = await SharedPreferences.getInstance();
    String pref = prefs.getString("newsLink") ?? "";

    return pref;
  }
  setDarkTheme(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("theme", value);
  }

  Future<bool> getTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool("theme") ?? false;
  }
}