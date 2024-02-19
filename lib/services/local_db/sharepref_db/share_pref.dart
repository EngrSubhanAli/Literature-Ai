import 'package:shared_preferences/shared_preferences.dart';

class LocalDb {
  // save the user data to the local db
  /// [key] is the key of the data;
  /// [value] is the value of the data;
  static saveString(String key, String value) async {
    // save the user data to the local db
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
  }

  // get the user data from the local db
  /// [key] is the key of the data;a
  /// [value] is the value of the data;
  static getString(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.getString(key);
  }
}
