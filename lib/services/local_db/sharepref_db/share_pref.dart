import 'package:shared_preferences/shared_preferences.dart';

class LocalDbService {
  late SharedPreferences _prefs;

  Future<void> saveSellerState() async {
    _prefs = await SharedPreferences.getInstance();
    await _prefs.setString('AppState', "Seller");
  }

  Future<void> saveBuyerState() async {
    _prefs = await SharedPreferences.getInstance();
    await _prefs.setString('AppState', "Buyer");
  }

  Future<String> getAppState() async {
    _prefs = await SharedPreferences.getInstance();
    _prefs = await SharedPreferences.getInstance();
    return _prefs.getString('AppState') ?? 'Buyer';
  }
}