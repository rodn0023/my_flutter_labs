import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';

class DataRepository {
  static String loginName = "";
  static String password = "";
  static String firstName = "";
  static String lastName = "";
  static String phoneNumber = "";
  static String email = "";

  static late EncryptedSharedPreferences _prefs;

  static Future<String> init() async {
    _prefs = EncryptedSharedPreferences();
    await loadData();

    return "Done";
  }

  static Future<void> loadData() async {


    loginName = await _prefs.getString("username") ?? "";
    password = await _prefs.getString("password") ?? "";
    firstName = await _prefs.getString("firstName") ?? "";
    lastName = await _prefs.getString("lastName") ?? "";
    phoneNumber = await _prefs.getString("phoneNumber") ?? "";
    email = await _prefs.getString("email") ?? "";
  }

  static Future<void> saveData() async {
    await _prefs.setString("username", loginName);
    await _prefs.setString("password", password);
    await _prefs.setString("firstName", firstName);
    await _prefs.setString("lastName", lastName);
    await _prefs.setString("phoneNumber", phoneNumber);
    await _prefs.setString("email", email);
  }

  static Future<void> deleteData() async {
    await _prefs.remove("username");
    await _prefs.remove("password");
  }
}
